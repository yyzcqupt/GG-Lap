clc;
clear;
load('simulate_data.mat');

% MVAR estimation method selection
Method_flag = [1,2,3,4,5,6,7];

% Model order
NLAGS = 3;

% Number of experiments
Experience_Time = size(data_outlier,3);
tic
for Cycle_i = 1:1:Experience_Time
    fprintf('\n---------------------------------------count = %d\n',Cycle_i);
    Data = data_outlier(:,:,Cycle_i);
    Data_origin = data(:,:,Cycle_i);
    for Flag_i = 1:1:length(Method_flag)
        ret = Net_Esitmate(Data,Data_origin,Method_flag(Flag_i),NLAGS);
        result.bia(Cycle_i,Flag_i)=ret.bia;
        result.Rnum(Cycle_i,Flag_i)=ret.Rnum;
        result.y_outlier(Cycle_i,Flag_i,:,:)=ret.y_outlier; 
        result.y_outlier_MVAR(Cycle_i,Flag_i,:,:)=ret.y_outlier_MVAR; 
        result.y_origin(Cycle_i,Flag_i,:,:)=ret.y_origin; 
        result.gc_by(Cycle_i,Flag_i,:,:)=ret.gc_by; 
        result.gc(Cycle_i,Flag_i,:,:)=ret.gc; 
        result.gc_origin(Cycle_i,Flag_i,:,:)=ret.gc_origin; 
    end
    
end
T = toc;
fprintf("End of experiment calculation \n");

bia_mean = mean(result.bia);
bia_std = std(result.bia);
Rnum_mean = mean(result.Rnum);
Rnum_std = std(result.Rnum);


% save('E:\code_GGD\result_all.mat');
