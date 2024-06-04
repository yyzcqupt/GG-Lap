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


