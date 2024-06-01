%% add outliear to simulated data
function [ S_err] = err_stren( S )
 
    % 随机顺序的一段范围的数
%     load('F:\MatlabWork\MVAR\noise13.mat');
    x = 0:1:6;
    y = gaussmf(x,[2 5]);
    
    A = 10:10:90;
    randIndex_A = randperm(9);
    index = A(randIndex_A);
    
    S(1,index(1):index(1) + 6) = S(1,index(1):index(1) + 6) + 8*y;   
    S(1,index(2):index(2) + 6) = S(1,index(2):index(2) + 6) + 8*y;
%      S(1,index(5):index(5) + 6) = S(1,index(5):index(5) + 6) + 8*y;
%      S(1,index(7):index(7) + 6) = S(1,index(7):index(7) + 6) + 8*y;
% 
%     
    S(2,index(3):index(3) + 6) = S(2,index(3):index(3) + 6) + 8*y;  
    S(2,index(4):index(4) + 6) = S(2,index(4):index(4) + 6) + 8*y;
%     S(2,index(6):index(6) + 6) = S(2,index(6):index(6) + 6) + 8*y;
%     S(2,index(8):index(8) + 6) = S(2,index(8):index(8) + 6) + 8*y;

% % 
%     S(3,index(5):index(5) + 6) = S(3,index(5):index(5) + 6) + 8*y;
%     S(3,index(6):index(6) + 6) = S(3,index(6):index(6) + 6) + 8*y;
% %     
%     S(4,index(7):index(7) + 6) = S(4,index(7):index(7) + 6) + 8*y;
%     S(4,index(8):index(8) + 6) = S(4,index(8):index(8) + 6) + 8*y;
    

    S_err = S;
end

