function match = comparePrimaryColours(im1Colours,im2Colours, delta)
load("M_XYZ2RGB.mat")
match = false;


[~, numberOfColours1] = size(im1Colours);
[~, numberOfColours2] = size(im2Colours);

for c1 = 1:numberOfColours1
    currentColour = im1Colours(:,c1);
    currentColourValue = currentColour(4);
    currentColourXYZ = inv(M_XYZ2RGB) * currentColour(1:3);

    for c2 = 1:numberOfColours2
        compareColour = im2Colours(:,c2);
        compareColourValue = compareColour(4);
        compareColourXYZ = inv(M_XYZ2RGB) * compareColour(1:3);

        [meanDeltaE, ~] = calcDeltaE(currentColourXYZ', compareColourXYZ');
        meanDeltaE = meanDeltaE * (1/currentColourValue) * (1/compareColourValue);
            
        % if same inc counter
        if meanDeltaE < delta
            match = true;
            return
        end

        
    end
end


end