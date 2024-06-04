 function ret= Net_Esitmate(Data,Data_origin,flag,NLAGS)

Defined_GC = [
        NaN   0   0   1   0   0
          1 NaN   0   0   0   0
          0   1 NaN   0   0   0
          1   0   1 NaN   0   0 
          0   0   0   1 NaN   1 
          1   0   0   0   0 NaN];

At = zeros(18,6);
At(1,1) = 0.22;
At(10,1) = 0.56;
At(1,2) = 0.55;
At(2,2) = -0.22;
At(14,3) = 0.48;
At(7,4) = 0.51;
At(15,4) = 0.85;
At(4,5) = 0.42;
At(12,5) = 0.40;
At(7,6) = 0.65;


ret = GrangerNet_Estimate(Data,flag,NLAGS);
% coefficient bias
bia = norm(At-ret.MVAR,1)/norm(At,1);
ret.bia = bia;

% number of correctly recovered linkages (NCRL) 
Estimate_GC = ret.gc_by;
ret.Rnum = GC_change(Defined_GC,Estimate_GC);



for ii=1:size(Defined_GC,2)
    xvec = Data_origin(ii,:)';
    xdep = xvec(NLAGS+1:end);
    y_origin(:,ii) = xdep;
end
ret.y_origin = y_origin;