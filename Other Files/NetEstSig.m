function [SigCoeff,SIG,gc_origin] = NetEstSig(Coefficient,p)
if nargin < 2
    p = 0.05;
end
[row,column] = size(Coefficient);
CoeffVector = reshape(Coefficient,1,row*column);%reshapeÊÇ°´ÁÐÉ¨Ãè
CoeffVector = abs(CoeffVector);
MCoefV = mean(CoeffVector);
StdCoefV = std(CoeffVector);
T_transform = (sqrt(length(CoeffVector))*(CoeffVector-MCoefV))./StdCoefV;
T_p = tinv(1-p,length(CoeffVector));
Significance = (T_transform>T_p);
Significance = reshape(Significance,row,column);
SigniffCoeff = abs(Significance.*Coefficient);

[np,N] = size(Significance);
SIG = zeros(N,N);
Ar = zeros(N,N,np/N);
A = Significance';
for lag=1:np/N
    Ar(:,:,lag) = A(:,1+((lag-1)*N):N*lag);
end

for i = 1:np/N
    SIG = SIG + Ar(:,:,i);
end
 
for i = 1:N
    for j = 1:N
        if SIG(i,j) > 0
            SIG(i,j) = 1;
        end
    end
end

for nvar = 1:N
    SIG(nvar,nvar) = 0;
end

%-------------------------------
[np,N] = size(SigniffCoeff);
SigCoeff = zeros(N,N);
Ar1 = zeros(N,N,np/N);
A1 = SigniffCoeff';
for lag=1:np/N
    Ar1(:,:,lag) = A1(:,1+((lag-1)*N):N*lag);
end

for i = 1:np/N
    SigCoeff = SigCoeff + Ar1(:,:,i);
end
 
for nvar = 1:N
    SigCoeff(nvar,nvar) = 0;
end



% gc_origin
Coefficient_abs = abs(Coefficient);
A2 = Coefficient_abs';
Ar2 = zeros(N,N,np/N);
gc_origin = zeros(N,N);
for lag=1:np/N
    Ar2(:,:,lag) = A2(:,1+((lag-1)*N):N*lag);
end
for i = 1:np/N
    gc_origin = gc_origin + Ar2(:,:,i);
end

for nvar = 1:N
    gc_origin(nvar,nvar) = 0;
end

end