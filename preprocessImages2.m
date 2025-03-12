function outputArray = preprocessImages2(imgArray, threshold, tileRatio)

% Initialize waitbar
h = waitbar(0, 'Preprocessing Images...');
% Initialize output array
maxNumberOfImages = 300;
outputArray = {};
length(imgArray)    
%add first image to output array
outputArray{end+1, 1} = imresize(imgArray{1}, tileRatio);
outputArray{end, 2} = imgArray{1, 2};
%addedIndex(1) = 0;

% Loop through each image in the array
for i = 1:length(imgArray)
        % Update waitbar
        waitbar(i/length(imgArray), h);

        

        targetPrimaryColours = imgArray{i,2};
        shouldAdd = true;
        [a, ~] = size(outputArray);
            
        if a >= maxNumberOfImages
            break;
        end

        for ii = 1:a
            currentPrimaryColours = outputArray{ii,2};
            % if they match we dont want it
            if comparePrimaryColours(targetPrimaryColours, currentPrimaryColours, threshold) == true
                shouldAdd = false;
                break
            end
        end

        if shouldAdd == true
            outputArray{end+1, 1} = imresize(imgArray{i, 1}, tileRatio);
            outputArray{end, 2} = imgArray{i, 2};
        end


end

close(h)
end