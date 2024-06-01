function [ret] = LS_granger_regress(Data,nlags)

nvar = size(Data,1);
[ Y,A ] = X_Y( Data,nlags );
for ii=1:nvar
    xdep = Y(:,ii);
    X(:,ii) = LS_estimate(xdep, A);
    Y_hat(:,ii) = A*X(:,ii);
end
% 统计检验删除部分连接
[gc,gc_by] = NetEstSig(X);  %前面为保留连接强度信息的连接，后面为二值化的连接
ret.gc = gc;
ret.gc_by = gc_by;
ret.MVAR = X;
ret.y_outlier = Y;
ret.y_outlier_MVAR = Y_hat;
end

