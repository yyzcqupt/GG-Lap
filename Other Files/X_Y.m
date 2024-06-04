
%% 由数据 S 得到模型 Y = A*X 中的 Y 和 A
function [ Y,A ] = X_Y( S,p )

%  p: model order
[N,n]=size(S);
temp = NaN*ones(p*N,n-p); 
    for j=1:p
        for i=1:N
            temp((j-1)*N+i,1:n-p)=S(i, p+1-j:n-j);
        end
    end
A = temp';

Y = S(:,p+1:n)';
end
