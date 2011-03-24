function [imgs, exposureTimes] = readImages(folder, extension)
% read in several images with different exposures.
%
% input
%  folder: folder name containing images.
%  extension: file extension. default to 'jpg'.
%
% output
%  imgs: 4 dimensional matrices, representing iamge set
%	[i, row, col, channel]
%  exposureTimes: (n, 1) matrices, representing image's exposure time in second.
%
% note
%  we assume the input images have the same dimension, channel and color space.
%
    imgs = [];
    exposureTimes = [];

    if( ~exist('extension') )
	extension = 'jpg';
    end

    files = dir([folder, '/*.', extension]);
    n = length(files);
    exposureTimes = zeros(n, 1);
    for i = 1:n
	filename = [folder, '/', files(i).name];
	img = double(imread(filename));
	[row, col, channel] = size(img);
	if( i == 1 )
	    imgs = zeros(n, row, col, channel);
	end
	imgs(i,:,:,:) = img;

	try
	    exif = exifread(filename);
	    exposureTimes(i) = exif.ExposureTime;
	catch
	    exposureTimes(i) = 1;
	end
    end
end
