function [images, exposureTimes] = readImages(folder, extension)
% read in several images with different exposures.
%
% input
%  folder: folder name containing images.
%  extension: file extension. default to 'jpg'.
%
% output
%  images: 4 dimensional matrices, representing the whole image set.
%	[row, col, channel, i] for i = 1:number of images.
%  exposureTimes: (number, 1) matrices, representing image's exposure time in second.
%
% note
%  We assume the input images have the same dimension, channel number and color space.
%  
%
    images = [];
    exposureTimes = [];

    if( ~exist('extension') )
	extension = 'jpg';
    end

    files = dir([folder, '/*.', extension]);
    number = length(files);
    exposureTimes = zeros(number, 1);
    for i = 1:number
	filename = [folder, '/', files(i).name];
	img = double(imread(filename));
	[row, col, channel] = size(img);
	if( i == 1 )
	    images = zeros(row, col, channel, number);
	end
	images(:,:,:,i) = img;

	try
	    exif = exifread(filename);
	    exposureTimes(i) = exif.ExposureTime;
	catch
	    exposureTimes(i) = 1;
	end
    end
end
