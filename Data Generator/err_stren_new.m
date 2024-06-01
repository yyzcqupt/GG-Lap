%% add outliear to simulated data
function [ S_err] = err_stren_new( S )
    %% 确定受干扰时间序列的个数channel_num
    channels = randperm(6); %总共6个通道
    channel_num = 5; %受干扰时间序列的个数channel_num
 
    %% 确定异常值强度（异常值为定义时候的多少倍数,这里为8倍）
    strength = 6;
    
    for i = 1:channel_num
    %% 确定异常值的频率（这里将异常值的一段设置为6个时间点的高斯函数噪声，频率指的是噪声的段数）
        frequnecy = 3;
        A = 10:10:(size(S,2)-10);
        randIndex_A = randperm(size(A,2));
        index = A(randIndex_A);
        for j = 1:frequnecy
            % 这里一段异常值影响6个时间点
            outlier_num = 6;
            % 产生噪声
%             outlier = 1:1:outlier_num;
            outlier = randperm(outlier_num);
            outlier = gaussmf(outlier,[2 5]);
            S(channels(i),index(j):index(j) + outlier_num-1) = S(channels(i),index(j):index(j) + outlier_num-1) + strength*outlier;
        end
%         samples = randperm(size(S,2));
%         for j = 1:outlier_num
%             % 异常值种类
%             outlier = max(abs(S(channel(i),:)));  % 基于通道最值的异常值
%             % outlier = gaussmf(j,[2 5]);  % 基于高斯函数的异常值
%             S(channel(i),samples(j)) = S(channel(i),samples(j)) + strength*outlier;
%         end
    end
    S_err = S;
end

