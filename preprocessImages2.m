function outputArray = preprocessImages2(imgArray, threshold, tileRatio, nrOfPrimaryColours)

% Initialize waitbar
h = waitbar(0, 'Preprocessing Images...');

% Initialize output array
outputArray = {};
    
%add first image to output array
outputArray{end+1} = imresize(imgArray{1}, tileRatio);
colours = getImportantColours(imresize(imgArray{1}, tileRatio), nrOfPrimaryColours);
[~, cMax] = size(colours);
for c = 1:cMax
    outputArray{end, c+1} = colours(:,c);
end
outputArray
% Loop through each image in the array
for i = 1:length(imgArray)
    currentImage = imresize(imgArray{i}, tileRatio);
    currentImageXYZ = averageColourXYZ(currentImage);
    % Update waitbar
    waitbar(i/length(imgArray), h);
    imageMatch = false;
    [numOfImages, ~] = size(outputArray);
    for j = 1:numOfImages
        
        compareImage = imresize(outputArray{j,1}, tileRatio);
        compareImageXYZ = averageColourXYZ(compareImage);

        % use calcDeltaE
        [meanDeltaE, ~] = calcDeltaE(currentImageXYZ', compareImageXYZ');

        %add image to output array if above treshold
        if (meanDeltaE < threshold)
            imageMatch = true;
            break;
        end 
    end

    if imageMatch == false
        outputArray{end+1,1} = currentImage;
        colours = getImportantColours(currentImage, nrOfPrimaryColours);
        [~, cMax] = size(colours);
        for c = 1:cMax
            outputArray{end, c+1} = colours(:,c);
        end
    end

end
close(h);
end