function weight = weightingFunction(weightType)
    weight = zeros(256, 1);

    switch weightType
	case 'one'
	    weight = ones(256, 1);
	case 'debevec97'
	    weight = [1:1:256];
	    weight = min(weight, 256-weight);
    end
end
