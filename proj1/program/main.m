% configurations
folder = '../image/original/exposures'; % no tailing slash!
lambda = 10;
srow = 10;
scol = 20;



tokens = strsplit('/', folder);
prefix = char(tokens(end));

disp('loading images with different exposures.');
[images, exposures] = readImages(folder);
ln_t = log(exposures);

disp('resizing the images.');
[row, col, channel, number] = size(images);
simages = zeros(srow, scol, channel, number);
for i = 1:number
    simages(:,:,:,i) = round(imresize(images(:,:,:,i), [srow scol], 'bilinear'));
end

disp('calculating camera response function by gsolve.');
g = zeros(256, 3);
lnE = zeros(srow*scol, 3);
w = weightingFunction('debevec97');
w = w/max(w);

for channel = 1:3
    rsimages = reshape(simages(:,:,channel,:), srow*scol, number);
    [g(:,channel), lnE(:,channel)] = gsolve(rsimages, ln_t, lambda, w);
end

disp('constructing HDR radiance map.');
ln_E = zeros(row, col, 3);
for channel = 1:3
    for y = 1:row
	for x = 1:col
	    total_lnE = 0;
	    totalWeight = 0;
	    for j = 1:number
		tempZ = images(y, x, channel, j) + 1;
		tempw = w(tempZ);
		tempg = g(tempZ);
		templn_t = ln_t(j);

		total_lnE = total_lnE + tempw * (tempg - templn_t);
		totalWeight = totalWeight + tempw;
	    end
	    ln_E(y, x, channel) = total_lnE / totalWeight;
	end
    end
end

imgHDR = exp(ln_E);
write_rgbe(imgHDR, strcat(prefix, '.hdr'));
imgTMO = tmoReinhard02(imgHDR, 'global', 0.18, 1e-6, 3);
write_rgbe(imgTMO, [prefix '_tone_mapped.hdr']);
imwrite(imgTMO, [prefix '_tone_mapped.png']);

disp('done!');
exit();
