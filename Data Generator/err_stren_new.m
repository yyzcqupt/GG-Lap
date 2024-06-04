%% add outliear to simulated data
function [ S_err] = err_stren_new( S )
    %% Specifies the number of interfered time series channel_num
    channels = randperm(6); % There are six channels in total
    channel_num = 3; % Number of disturbed time series channel_num
 
    %% Determine outlier strength (how many multiples the outlier is at the time of definition)
    strength = 6;
    
    for i = 1:channel_num
    %% Determine the frequency of the outlier (here a segment of the outlier is set to Gaussian function noise at 6 points in time, and the frequency refers to the number of segments of noise)
        frequnecy = 3;
        A = 10:10:(size(S,2)-10);
        randIndex_A = randperm(size(A,2));
        index = A(randIndex_A);
        for j = 1:frequnecy
            % An outlier affects six points in time
            outlier_num = 6;
            % generate outliers
%             outlier = 1:1:outlier_num;
            outlier = randperm(outlier_num);
            outlier = gaussmf(outlier,[2 5]);
            S(channels(i),index(j):index(j) + outlier_num-1) = S(channels(i),index(j):index(j) + outlier_num-1) + strength*outlier;
        end
    end
    S_err = S;
end

