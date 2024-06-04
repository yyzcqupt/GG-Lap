%% This code is used to generate simulation data

clc;
clear;
Experience_Time = 30; % 200 in the paper

for i = 1:Experience_Time
    X0 = cca_testData(200,5);
    X1 = err_stren_new(X0);  % Add outliers
    data(:,:,i) = X0;
    data_outlier(:,:,i) = X1;
end

save('simulate_data.mat', 'data', 'data_outlier');