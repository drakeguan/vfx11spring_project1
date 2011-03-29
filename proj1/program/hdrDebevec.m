function imgHDR = hdrDebevec(images, g, ln_t, w)
    [row, col, channel, number] = size(images);
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

    % remove NAN or INF
    index = find(isnan(imgHDR) | isinf(imgHDR));
    imgHDR(index) = 0;
end
