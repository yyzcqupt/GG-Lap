% IDENTIFICATION OF STRICTLY CAUSAL MVAR MODEL: Y(n)=A(1)Y(n-1)+...+A(p)Y(n-p)+U(n)
%% get solutions colume by colume with matlab toolbox lasso


function [X] = LASSO_estimate(Y,A)

lambda = 0:.01:.5;
%  [X,Info] = lasso(A,Y,'Lambda',lambda,'CV',10,'Intercept',false,'Standardize',false);
 %X = B(:,Info.IndexMinMSE);
% X = lasso(A,Y,'Lambda',0.01);


% lasso(A, Y,'Lambda',lambda);
X = lasso(A,Y);
end


% [M,N] = size(Y);
% [ Yt,Phi ] = X_Y( Y, p );
% 
% Am = zeros(M*p,M);
% for i = 1 : M
%     % �?列一列地求解
%     lambda = 0:.01:.5;
%     [B,Info] = lasso(Phi,Yt(:,i),'Lambda',lambda,'CV',10,'Intercept',false,'Standardize',false);
%     s_lasso = B(:,Info.IndexMinMSE);
%     %[a,~] = lasso(Phi,Yt(:,i),'Lambda',0.01);
%     Am(:,i) = s_lasso;
% end
% 
% A = Am';
% Ar = zeros(M,M,p);
% for j=1:p
%     Ar(:,:,j) = A(:,1+((j-1)*M):M*j);
% end
% 
% Yt = Yt';
% Ye = (Phi*Am)';
% Up = Yt - Ye;
% S = (Up*Up')/(N-p-1);


