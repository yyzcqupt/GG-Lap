function [ret] = DLap_granger_regress(Data,nlags)

nvar = size(Data,1);
[ Y,A ] = X_Y( Data,nlags );
for ii=1:nvar
    xdep = Y(:,ii);
    X(:,ii) = DLap_Estimate(A,xdep);
    Y_hat(:,ii) = A*X(:,ii);
end
% ͳ�Ƽ���ɾ����������
[gc,gc_by] = NetEstSig(X);  %ǰ��Ϊ��������ǿ����Ϣ�����ӣ�����Ϊ��ֵ��������
ret.gc = gc;
ret.gc_by = gc_by;
ret.MVAR = X;
ret.y_outlier = Y;
ret.y_outlier_MVAR = Y_hat;
end
