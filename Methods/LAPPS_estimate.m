function [X] = LAPPS_estimate( Y,A )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
X = lq_l1_admm(A,Y,10,20,0.001,0.2,0.5);  % 8 nods




% [ Y,Phi ] = X_Y( signal,p );
% Yt = Y';
% [n,m] = size(signal);
% Am = zeros(n*p,n);
% 
% for i = 1:n
% %     [x] = lq_l1_admm(Phi,Y(:,i),400,1000,0.99,2*1e-4,0.5); % furong
%     [x] = lq_l1_admm(Phi,Y(:,i),10,20,0.001,0.2,0.5);  % 8 nods
% %     [x] = lq_l1_admm(Phi,Y(:,i),20,10,0.001,0.2,0.5); % 5 nods
%     Am(:,i) = x;
% end
% A = Am';
% 
% Ar = zeros(n,n,p);
% for k=1:p
%     Ar(:,:,k) = A(:,1+((k-1)*n):n*k);
% end
% 
% Ye = (Phi*Am)';
% Up = Yt - Ye;
% S = (Up*Up')/(m-p-1);


