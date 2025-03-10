function outputArray = preprocessImages3(imgArray, targetColours, threshold, tileRatio, nrOfPrimaryColours)

% Initialize waitbar
h = waitbar(0, 'Preprocessing Images...');
numberOfImagesPerTile = 3;
% Initialize output array
outputArray = {};
length(imgArray)    
%add first image to output array
outputArray{end+1, 1} = imresize(imgArray{1}, tileRatio);
%col = imgArray{1, 2};
outputArray{end, 2} = imgArray{1, 2};
%colours = getImportantColours(imresize(imgArray{1}, tileRatio), nrOfPrimaryColours);
%[~, cMax] = size(colours);
%for c = 1:cMax
%    outputArray{end, c+1} = colours(:,c);
%end
[rMax, cMax, ~] = size(targetColours);
addedIndex(1) = 0;
for r = 1:rMax
    waitbar(r/rMax, h);
    for c = 1:cMax
        for colour = 1:(nrOfPrimaryColours)
            colours = targetColours{r,c,colour};
            targetPrimaryColours(:, colour) = colours;
        end

        if length(addedIndex) == length(imgArray)
            close(h)
            return
        end

        currentNumberOfImagesPerTile = 0;
        % for each tile, find colours that work
        for i = 1:length(imgArray)
            shouldAdd = true;

            currentPrimaryColours = imgArray{i, 2};
            if currentNumberOfImagesPerTile >= numberOfImagesPerTile || length(addedIndex) == length(imgArray)
                break
            end
            % check if current would fit, if it does, check if we need to
            % add it
            if comparePrimaryColours(targetPrimaryColours, currentPrimaryColours, threshold)
                for ii = 1:length(addedIndex)
                    if i == addedIndex(ii)
                        shouldAdd = false;
                        break
                    end
                end
                if shouldAdd == true
                    outputArray{end+1, 1} = imresize(imgArray{i, 1}, tileRatio);
                    %col = imgArray{i, 2};
                    outputArray{end, 2} = imgArray{i, 2};
                    addedIndex(end+1) = i;              
                end
                currentNumberOfImagesPerTile = currentNumberOfImagesPerTile + 1;
            end
        end

        % if we cant find a cat, find the best cat
        if currentNumberOfImagesPerTile == 0
            bestE = 9999;
            bestIndex = 0;
            for i = 1:length(imgArray)
                currentPrimaryColours = imgArray{i, 2};
                currentE = comparePrimaryColours2(targetPrimaryColours, currentPrimaryColours);
                if currentE < bestE
                    bestIndex = i;
                    bestE = currentE;
                end
            end
            % check if we need to add the cat
            catAdded = false;
            for ii = 1:length(addedIndex)
                if bestIndex == addedIndex(ii)
                    catAdded = true;
                end
            end
            if catAdded == false
                outputArray{end+1, 1} = imresize(imgArray{bestIndex, 1}, tileRatio);
                %col = imgArray{bestIndex, 2};
                outputArray{end, 2} = imgArray{bestIndex, 2};
                addedIndex(end+1) = bestIndex;
            end
            
        end
    end
end
sort(addedIndex)
close(h)
end