%
% Tone Mapping Operator, by Reinhard 02 paper.
%
% input:
%   img: 3 channel HDR img
%   type_: 'global'(default) or 'local'.
%   alpha_: scalar constant to specify a high key or low key. (0.18)
%   delta: scalar constant to prevent log(0). (1e-6)
%   white_: scalar constant, the smallest luminance to be mapped to 1. (1.5)
%   phi: (local) scalar constant. (4)
%   epsilon: (local) scalar constant to tell the terminating threshold. (1e-4)
%
% output:
%   tone-mapped image (LDR or SDR)
%
function imgOut = tmoReinhard02(img, type_, alpha_, delta, white_, phi, epsilon)

    if( ~exist('type_') )
	type_ = 'global';
    end
    if( ~exist('alpha_') )
	alpha_ = 0.18;
    end
    if( ~exist('delta') )
	delta = 1e-6;
    end
    if( ~exist('white_') )
	white_ = 1.5;
    end
    if( ~exist('phi') )
	phi = 4;
    end
    if( ~exist('epsilon') )
	epsilon = 1e-4;
    end

    imgOut = zeros(size(img));

    %
    % Here, I favor to allpy tone mapping on luminance and then multiply
    % it back to the rest (color?!) cause it might produce color shifting
    % if applying TMO separately on each channel!
    % There should be some other better ways to handle this.
    %
    Lw = 0.2126 * img(:,:,1) + 0.7152 * img(:,:,2) + 0.0722 * img(:,:,3);

    switch type_
	case 'global'
	    disp('global');

	    LwMean = exp(mean(mean(log(delta + Lw))));
	    Lm = (alpha_ / LwMean) * Lw;
	    Ld = (Lm .* (1 + Lm / (white_ * white_))) ./ (1 + Lm);
	case 'local'
	    disp('local');
    end

    for channel = 1:3
	Cw = img(:,:,channel) ./ Lw;
	imgOut(:,:,channel) = Cw .* Ld;
    end

end
