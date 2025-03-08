function match = comparePrimaryColours(im1Colours,im2Colours)
load("M_XYZ2RGB.mat")
match = false;


[~, numberOfColours1] = size(im1Colours);
[~, numberOfColours2] = size(im2Colours);

for c1 = 1:numberOfColours1
    currentColour = im1Colours(:,c1);
    currentColourXYZ = inv(M_XYZ2RGB) * currentColour;

    for c2 = 1:numberOfColours2
        compareColour = im2Colours(:,c2);
        compareColourXYZ = inv(M_XYZ2RGB) * compareColour;

        [meanDeltaE, ~] = calcDeltaE(currentColourXYZ', compareColourXYZ');
            
        % if same inc counter
        if meanDeltaE < 10
            match = true;
            break
        end

        
    end
end


end