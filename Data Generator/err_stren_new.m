%% add outliear to simulated data
function [ S_err] = err_stren_new( S )
    %% ȷ���ܸ���ʱ�����еĸ���channel_num
    channels = randperm(6); %�ܹ�6��ͨ��
    channel_num = 5; %�ܸ���ʱ�����еĸ���channel_num
 
    %% ȷ���쳣ֵǿ�ȣ��쳣ֵΪ����ʱ��Ķ��ٱ���,����Ϊ8����
    strength = 6;
    
    for i = 1:channel_num
    %% ȷ���쳣ֵ��Ƶ�ʣ����ｫ�쳣ֵ��һ������Ϊ6��ʱ���ĸ�˹����������Ƶ��ָ���������Ķ�����
        frequnecy = 3;
        A = 10:10:(size(S,2)-10);
        randIndex_A = randperm(size(A,2));
        index = A(randIndex_A);
        for j = 1:frequnecy
            % ����һ���쳣ֵӰ��6��ʱ���
            outlier_num = 6;
            % ��������
%             outlier = 1:1:outlier_num;
            outlier = randperm(outlier_num);
            outlier = gaussmf(outlier,[2 5]);
            S(channels(i),index(j):index(j) + outlier_num-1) = S(channels(i),index(j):index(j) + outlier_num-1) + strength*outlier;
        end
%         samples = randperm(size(S,2));
%         for j = 1:outlier_num
%             % �쳣ֵ����
%             outlier = max(abs(S(channel(i),:)));  % ����ͨ����ֵ���쳣ֵ
%             % outlier = gaussmf(j,[2 5]);  % ���ڸ�˹�������쳣ֵ
%             S(channel(i),samples(j)) = S(channel(i),samples(j)) + strength*outlier;
%         end
    end
    S_err = S;
end

