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
    white_ = 3;
end
if( ~exist('phi') )
    phi = 4;
end
if( ~exist('epsilon') )
    epsilon = 1e-4;
end

imgOut = zeros(size(img));

%Lw = 0.2126 * img(:,:,1) + 0.7152 * img(:,:,2) + 0.0722 * img(:,:,3);
%Cw = img ./ Lw;

switch type_
case 'global'
    disp('global');
    for channel = 1:3
        Lw = img(:,:,channel);
        LwMean = exp(mean(mean(log(delta + Lw))));
        Lm = (alpha_ / LwMean) * Lw;
        Ld = (Lm .* (1 + Lm / (white_ * white_))) ./ (1 + Lm);

        %imgOut(:,:,channel) = round(Ld .* 255);
	imgOut(:,:,channel) = Ld;
    end
case 'local'
    disp('local');
end

end
