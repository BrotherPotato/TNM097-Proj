function [MSE] = subsampledCmp(targetSample,currentSample, sampleAmt)
% compare subsamples
% return distance between values.

sAmt = sqrt(sampleAmt);

%preallocate
distance = zeros(sAmt, sAmt);

% disp("targetSample(i,j)")
% disp(targetSample)
% disp("currentSample(i,j)")
% disp(currentSample)
MSE = 0;

for i = 1:sAmt
    for j = 1:sAmt
    distance(i,j) = abs(targetSample(i,j) - currentSample(i,j));
    
    MSE = MSE + distance(i,j)^2; 

    end
end

MSE = MSE/sampleAmt;
end