function [ret] = LAPPS_granger_regress(Data,nlags)

nvar = size(Data,1);
[ Y,A ] = X_Y( Data,nlags );
for ii=1:nvar
    xdep = Y(:,ii);
    X(:,ii) = LAPPS_estimate(xdep, A);
    Y_hat(:,ii) = A*X(:,ii);
end

[gc,gc_by,gc_origin] = NetEstSig(X);  
ret.gc = gc;
ret.gc_by = gc_by;
ret.MVAR = X;
ret.y_outlier = Y;
ret.y_outlier_MVAR = Y_hat;
ret.gc_origin = gc_origin;
end

