function [outputArray] = preprocessImages1Depend(imgArray, targetImage, threshold)
    % Remove similar images from dataset based on average color value
    % imgArray: Input array of images
    % threshold: Threshold value for similarity (e.g., 10, 20, etc.)
    
    % Initialize waitbar
    h = waitbar(0, 'Preprocessing Images...');
    
    % Initialize output array
    outputArray = {};
    numberOfImagesPerTile = 3;
    
    %add first image to output array
    outputArray{end+1} = imgArray{1};
    
    %Holds index of items already added to the img pool (maybe useless)
    addedImages = [];

    rTileSize = 32;
    oTileSize = 8;
    [rows, cols, ~] = size(targetImage);
    tileRows = ceil(rows / oTileSize);
    tileCols = ceil(cols / oTileSize);
    %imageIndex = 1;
    for r = 1:tileRows
        % Update waitbar
        waitbar(r/tileRows, h);
        for c = 1:tileCols
            imagesForThisTile = 0;

            tileRFrom = 1 + (r-1)*(oTileSize);
            tileRTo = r*oTileSize;
            if tileRTo > rows
                tileRTo = rows;
            end
            tileCFrom = 1 + (c-1)*(oTileSize);
            tileCTo = c*oTileSize;
            if tileCTo > cols
                tileCTo = cols;
            end
            currentTile = targetImage(tileRFrom:tileRTo, tileCFrom:tileCTo, :);
            %convert to XYZ
            currentImageXYZ = averageColourXYZ(currentTile);

            for i = 1:length(imgArray)
                % if we have 3 images for this tile quit
                if imagesForThisTile >= numberOfImagesPerTile
                    break;
                end

                nextImageXYZ = averageColourXYZ(imgArray{i});

                % use calcDeltaE
                [meanDeltaE, ~] = calcDeltaE(nextImageXYZ', currentImageXYZ');
                addImage = false;

                if meanDeltaE < threshold
                    addImage = true;
                    imagesForThisTile = imagesForThisTile + 1;
                    for ii = 1:length(addedImages)
                        if i == addedImages(ii)
                            addImage = false;
                            break
                        end
                    end
                end

                if addImage == true
                    addedImages(end+1) = i;
                    outputArray{end+1} = imgArray{i};
                end

            end
        end
    end

    % Close the waitbar
    close(h);
end
