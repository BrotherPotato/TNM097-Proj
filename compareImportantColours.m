function [outputArg1,outputArg2] = compareImportantColours(im1, im2, numberOfColours)
quantizeLevel = 30;
histColours1 = reshape(im1(1, 1, :),[3, 1]);
histColours1(4,1) = 0;
[rMax, cMax, dMax] = size(im1);
for r = 1:rMax
    for c = 1:cMax
        [~, histLength] = size(histColours1);
        currentColour = reshape(targetImage(r, c, :),[3, 1]);
        currentColourXYZ = inv(M_XYZ2RGB) * currentColour;
        currentColourXYZ = quantizeColour(currentColourXYZ, quantizeLevel);
        colourFound = false;
        for i = 1:histLength
            compareColour = reshape(histColours1(1:3,i),[3, 1]);
            compareColourXYZ = inv(M_XYZ2RGB) * compareColour;
            compareColourXYZ = quantizeColour(compareColourXYZ, quantizeLevel);
            [meanDeltaE, Max] = calcDeltaE(currentColourXYZ', compareColourXYZ');
            
            % if same inc counter
            if meanDeltaE < quantizeLevel
                histColours1(4,i) = histColours1(4,i) + 1;
                colourFound = true;
                break
            end
        end
        % if we have not found the colour add it
        if colourFound == false
            histColours1(1:3, end+1) = currentColour;
            histColours1(4, end) = 1;
        end
    end
end




end