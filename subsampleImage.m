function [outputArg1] = subsampleImage(targetTile, samplesPerTile)
sPT = sqrt(samplesPerTile); %Inte supereffektivt men den är mer intiutivt me tinks

[rows, cols, ~] = size(targetTile);

% Calculate the size of each axis part
partRows = floor(rows / sPT);
partCols = floor(cols / sPT);

averages = zeros(sPT, sPT);

% Loop through each part and compute the average
for i = 1:sPT
    for j = 1:sPT

        % Define the region of interest (ROI)
        rowStart = (i-1) * partRows + 1;
        rowEnd = i * partRows;
        colStart = (j-1) * partCols + 1;
        colEnd = j * partCols;
        
        % Extract the smaller part
        sample = targetTile(rowStart:rowEnd, colStart:colEnd, :);
        
        % Compute the average of L in the sample.
        sampleLab = rgb2lab(sample); 
        averages(i, j) = mean(mean(sampleLab(:,:,1))); %L only (light)
    end
end

% Display the averages
%disp('Averages of each part:');
%disp(averages);

outputArg1 = averages;


end

