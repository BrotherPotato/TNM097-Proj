function [meanDeltaE, maxDeltaE] = calcDeltaE(XYZ_ref, XYZ_est)



[L_est, a_est, b_est] = xyz2lab(XYZ_est(:,1),XYZ_est(:,2),XYZ_est(:,3));

[L_ref, a_ref, b_ref] = xyz2lab(XYZ_ref(:,1), XYZ_ref(:,2),XYZ_ref(:,3));

L_diff = L_ref - L_est;
a_diff = a_ref - a_est;
b_diff = b_ref - b_est;
distance = sqrt(L_diff.^2 + a_diff.^2 + b_diff.^2);
maxDeltaE = max(distance);
meanDeltaE = mean(distance);