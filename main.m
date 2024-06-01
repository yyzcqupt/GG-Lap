clc;
clear;
load('simulate_data.mat');
% MVAR估计参数方法选择
% Method_flag = [1,2,3,4,5,6,7,8];
Method_flag = [8];
% 模型阶数
NLAGS = 3;
% NLAGS = 6;
% 实验重复次数
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
    end
    
end
T = toc;
fprintf("实验计算结束\n");

bia_mean = mean(result.bia);
bia_std = std(result.bia);
Rnum_mean = mean(result.Rnum);
Rnum_std = std(result.Rnum);

% save('F:\EEG数据集与代码\GGD_MVAR\result_all-第二次实验-200循环\1.受干扰通道\受干扰通道数为5\result（p=0.4）.mat');

save('F:\EEG数据集与代码\GGD_MVAR\result_all-第二次实验-200循环\1.受干扰通道\受干扰通道数为2\result（补充Lap_SBL1.5e-6）.mat');