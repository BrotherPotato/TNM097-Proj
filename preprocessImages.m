function [outputArray] = preprocessImages(imgArray, threshold)
    % Remove similar images from dataset based on average color value
    % imgArray: Input array of images
    % threshold: Threshold value for similarity (e.g., 10, 20, etc.)
    
    % Initialize waitbar
    h = waitbar(0, 'Preprocessing Images...');
    
    % Initialize output array
    outputArray = {};
    
    %add first image to output array
    outputArray{end+1} = imgArray{1};
    
    %Holds index of items already added to the img pool (maybe useless)
    similarImgIndex = {};
    
    % Loop through each image in the array
    for i = 1:length(imgArray)
        % Update waitbar
        waitbar(i/length(imgArray), h);
        
        alreadyExists = false;
        for si = 1:length(similarImgIndex)
            if(similarImgIndex{si} == i)
                %disp("skipping too similar image with index: ")
                %disp(i)
                alreadyExists = true;
            end
        end
        
        %jump to next loop
        if(alreadyExists)
            continue
        end

        %convert to XYZ
        currentImageXYZ = averageColourXYZ(imgArray{i});
        
        for j = 1:length(imgArray)-1
            nextImageXYZ = averageColourXYZ(imgArray{j+1});

            % use calcDeltaE
            [meanDeltaE, ~] = calcDeltaE(nextImageXYZ', currentImageXYZ');
    
            %add image to output array if above treshold
            if (meanDeltaE > threshold)
                if ~isImageDuplicate(imgArray{j+1}, outputArray)
                    outputArray{end+1} = imgArray{j+1};
                    similarImgIndex{end+1} = j+1;
                end %if 
            end %if thresh
        end %for imgarray
    end %for imgarray

    
    % Add the last image to the output array
    %outputArray{end+1} = imgArray{end};
    
    % Close the waitbar
    close(h);
end

function isDuplicate = isImageDuplicate(newImage, existingImages)
    % check diplicate
    isDuplicate = false;
    for k = 1:length(existingImages)
        if isequal(newImage, existingImages{k})
            isDuplicate = true;
            return;
        end
    end
end

