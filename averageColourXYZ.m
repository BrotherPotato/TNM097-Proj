function colourXYZ = averageColourXYZ(imageRGB)

%load("xyz.mat");
%load("illum.mat");
%load("DLP.mat");

load("M_XYZ2RGB.mat");
[~, ~, d] = size(imageRGB);
if(d < 3) %greyscale
    meanRGB(1) = mean(mean(imageRGB(:,:,1)));
    colourXYZ = inv(M_XYZ2RGB(:,:,1)) * meanRGB';
else
meanRGB(1) = mean(mean(imageRGB(:,:,1)));
meanRGB(2) = mean(mean(imageRGB(:,:,2)));
meanRGB(3) = mean(mean(imageRGB(:,:,3)));

colourXYZ = inv(M_XYZ2RGB) * meanRGB';
end

%Srgb = DLP * meanRGB';

%k = 100 ./ sum(xyz(:,2)' .* CIED65);

%colourXYZ = (k * xyz' * Srgb);


%colourXYZ = inv(M_XYZ2RGB) * meanRGB';

end