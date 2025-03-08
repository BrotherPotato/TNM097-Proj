function mostCommonColours = getImportantColours(im, numberOfColours)
load("M_XYZ2RGB.mat")
quantizeLevel = 30;
histColours = reshape(im(1, 1, :),[3, 1]);
histColours(4,1) = 0;
[rMax, cMax, dMax] = size(im);
for r = 1:rMax
    for c = 1:cMax
        [~, histLength] = size(histColours);
        currentColour = reshape(im(r, c, :),[3, 1]);
        currentColourXYZ = inv(M_XYZ2RGB) * currentColour;
        currentColourXYZ = quantizeColour(currentColourXYZ, quantizeLevel);
        colourFound = false;
        for i = 1:histLength
            compareColour = reshape(histColours(1:3,i),[3, 1]);
            compareColourXYZ = inv(M_XYZ2RGB) * compareColour;
            compareColourXYZ = quantizeColour(compareColourXYZ, quantizeLevel);
            [meanDeltaE, Max] = calcDeltaE(currentColourXYZ', compareColourXYZ');
            
            % if same inc counter
            if meanDeltaE < quantizeLevel
                histColours(4,i) = histColours(4,i) + 1;
                colourFound = true;
                break
            end
        end
        % if we have not found the colour add it
        if colourFound == false
            histColours(1:3, end+1) = currentColour;
            histColours(4, end) = 1;
        end
    end
end
[~, histLength] = size(histColours);
histColours(4,:)
plot(histColours(4,:))
mostCommonColours = zeros(3, numberOfColours);
for c = 1:numberOfColours
    maxValue = 0;
    bestIndex = 1;
    for i = 1:histLength
        if histColours(4,i) > maxValue
            maxValue = histColours(4,i);
            bestIndex = i;
        end
    end
    histColours(4, bestIndex) = 0;
    mostCommonColours(:, c) = histColours(1:3, bestIndex);
end

mostCommonColours;

end