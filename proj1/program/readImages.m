%
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
%  We assume the input images have the same dimension, channel number and color space,
%  with EXIF metadata.
%
function [images, exposureTimes] = readImages(folder, extension)
    images = [];
    exposureTimes = [];

    if( ~exist('extension') )
	extension = 'jpg';
    end

    files = dir([folder, '/*.', extension]);

    % grab images info to initialize images and exposureTimes.
    filename = [folder, '/', files(1).name];
    info = imfinfo(filename);
    number = length(files);
    images = zeros(info.Height, info.Width, info.NumberOfSamples, number);
    exposureTimes = zeros(number, 1);

    for i = 1:number
	filename = [folder, '/', files(i).name];
	img = imread(filename);
	images(:,:,:,i) = img;

	exif = exifread(filename);
	exposureTimes(i) = exif.ExposureTime;
    end
end
