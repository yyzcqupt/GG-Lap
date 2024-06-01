clc;
clear;
Experience_Time = 200;

for i = 1:Experience_Time
    X0 = cca_testData(200,6);
    X1 = err_stren_new(X0);
    data(:,:,i) = X0;
    data_outlier(:,:,i) = X1;
end

save('simulate_data.mat', 'data', 'data_outlier');