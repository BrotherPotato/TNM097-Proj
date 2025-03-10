function deltaE = comparePrimaryColours2(im1Colours,im2Colours)
load("M_XYZ2RGB.mat")


[~, numberOfColours1] = size(im1Colours);
[~, numberOfColours2] = size(im2Colours);

deltaE = 9999;

for c1 = 1:numberOfColours1
    currentColour = im1Colours(:,c1);
    currentColourValue = currentColour(4);
    currentColourXYZ = inv(M_XYZ2RGB) * currentColour(1:3);

    for c2 = 1:numberOfColours2
        compareColour = im2Colours(:,c2);
        compareColourValue = compareColour(4);
        compareColourXYZ = inv(M_XYZ2RGB) * compareColour(1:3);

        [~, maxDeltaE] = calcDeltaE(currentColourXYZ', compareColourXYZ');
        maxDeltaE = maxDeltaE * (1/currentColourValue) * (1/compareColourValue);
            
        % if same inc counter
        if maxDeltaE < deltaE
            deltaE = maxDeltaE;
        end   
    end
end


end