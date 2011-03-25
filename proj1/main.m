[images, exposures] = readImages('exposures');

disp('resizing the images.');
[row, col, channel, number] = size(images);
srow = 10;
scol = 20;
simages = zeros(srow, scol, channel, number);
for i = 1:number
    simages(:,:,:,i) = round(imresize(images(:,:,:,i), [srow scol], 'bilinear'));
end

disp('calculating camera response function by gsolve.');
g = zeros(256, 3);
lnE = zeros(srow*scol, 3);
w = weightingFunction('deb97');
w = w/max(w);

for channel = 1:3
    rsimages = reshape(simages(:,:,channel,:), srow*scol, number);
    [g(:,channel), lnE(:,channel)] = gsolve(rsimages, log(exposures), 10, w);
end

plot(g);
%plot(lnE);

disp('done!');
