%% IDENTIFICATION OF STRICTLY CAUSAL MVAR MODEL: Y(n)=A(1)Y(n-1)+...+A(p)Y(n-p)+U(n)
% makes use of autocovariance method (vector least squares)
%  Y = A*X;
%%% input:
%       S: M*N matrix of time series (each time series is in a row)
%       nlags: model order

%%% output:
%       X: [A(1)...A(p)], M*pM matrix of the estimated MVAR model coefficients 
%       Ye: estimated time series----M*(N-p) 

function [X] = LS_estimate(Y, A)

X = (pinv(A'*A))*A'*Y;

end




%     [M,N]=size(Y);
%     [ Yt,Phi ] = X_Y( Y,p );
%     Yt = Yt(:,1);
% 
%     Am = (inv(Phi'*Phi))*Phi'*Yt; % least squares!  15x5
% 
%     Yt = Yt';
%     Ye = (Phi*Am)';
% 
%     Up = Yt-Ye; 
%     S = (Up*Up')/(N-p-1);
%     
%  %  还原成三维数据
%     A = Am';   % 5x15
%     Ar = zeros(M,M,p);
%     for i=1:p
%         Ar(:,:,i) = A(:,1+((i-1)*M):M*i);
%     end

