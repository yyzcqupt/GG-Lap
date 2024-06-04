function [X] = LAPPS_estimate(Y, A)


    
    ita = 1;
    p = 0.7;

    % ADMM
    rho = 2.8;
   %  alpha = 1.1;
    tol = 1e-6;
    max_iter = 90;
    L = 1;

    [m, n]=size(A);
    % initialize B，X，u
    B = zeros(m,1);
    X = zeros(n,1);
    u = zeros(m,1);    % Lagrange multiplier

    for iter = 1:max_iter
        L_old = L;
        % update B
        B_old = B;
        C = A*X - Y + u;
        B = soft_threshold(C, 1/rho);

        % update X
        X_old = X;
        D = Y + B - u;
        X = GISA(A, D, ita*rho, X_old, p);
        



        % Judgment convergence condition
        primerror = norm(A*X - Y - B,2);
        dualerror = norm(rho*(A')*(B-B_old));
        
        tol_prim = tol*max(norm(B,2),norm(A*X-Y,2));
        tol_dual = tol*rho*norm(A'*u);
        
       %  Rprimerror = primerror/max(norm(B,2),norm(A*X-Y,2));
       %  Rdualerror = dualerror/norm(rho*A'*u,2);
        
        if primerror < tol_prim && dualerror < tol_dual
            break;
        end
        
        % Rprimerror tol_prim
        disp(['primerror < tol_prim ',num2str(iter),'  primerror：',num2str(primerror),'  tol_prim:',num2str(tol_prim)]);
        disp(['dualerror < tol_dual ',num2str(iter),'  dualerror：',num2str(dualerror),'  tol_dual:',num2str(tol_dual)]);
        
        
        % update u
        u = u + A*X - Y - B;
        
        
        % update rho
%         if norm(B - B_old,1)/m > 10 * norm(X - X_old,1)/n
%             rho = alpha * rho;
%         elseif norm(X - X_old,1)/n > 10 * norm(B - B_old,1)/m
%             rho = rho / alpha;
%         end
% 
%         ratio = -1;
%         if Rdualerror~=0
%                 ratio = sqrt(Rprimerror/Rdualerror);
%         end
%         
%         tau_max = 2;
%         if ratio>=1 && ratio<tau_max, tau = ratio;
%         elseif ratio>1/tau_max && ratio<1, tau = 1/ratio;
%         else tau = tau_max;
%         end
%         
%         if Rprimerror > 10 * Rdualerror
%             rho = tau*rho; u = u./tau;
%         elseif Rdualerror > 10 * Rprimerror
%             rho = rho/tau; u = u./tau;
%         end
%         
        
        
        
        
        L = norm(B, 1) + ita*sum(abs(X).^p)^(1/p) + u'*(A*X - Y - B) + rho/2*norm((A*X - Y - B),2);

        disp(['LAPPS_iters: ',num2str(iter),'   Lagrange function：',num2str(L)]);
        disp(['LAPPS_iters: ',num2str(iter),'   Lagrange function change: ',num2str(abs((L-L_old)/L_old))]);
        

        disp(['LAPPS_iters: ',num2str(iter),'   X change: ',num2str(norm(X-X_old,2))]);
        

        disp(['LAPPS_iters: ',num2str(iter),'   B change: ',num2str(norm(B-B_old,2))]);
        

        disp(['LAPPS_iters: ',num2str(iter),'   rho: ',num2str(rho)]);
        
    end
end


function Z = soft_threshold(y, lam)
    Z = abs(y);
    Z(Z<=lam) = 0;
    ind = find(Z>0);
    Z(ind) = abs(y(ind)) - lam;
    Z = sign(y).*Z;
end


% Generalized iterated shrinkage algorithm
function X = GISA(A, y, lam, X_old, p)
    iter = 0;
    tol = 1e-4;
    t = (max(svd(A)))^(-2); % t is the power of -2 to spectral norm of the matrix A.
    while true
        E = X_old - t*(A')*(A*X_old - y);
        X = G_soft_threshold(E,t*lam, p);
        iter = iter + 1;
        % disp(['X子问题更新次数: ',num2str(iter),'   X变化: ',num2str(norm(X-X_old,2))]);
        if norm(X - X_old,2)<tol
            break;
        elseif norm(X - X_old,2)>=tol
            X_old = X;
        end
    end
end

% Generalization of soft-thresholding
function Z = G_soft_threshold(y, lam, p)
    k = 3;
    thr = (2*lam*(1-p))^(1/(2-p)) + lam*p*(2*lam*(1-p))^((p-1)/(2-p));
    Z = abs(y);
    Z(Z<=thr) = 0;
    ind = find(Z>0);
    for j = 1:k
        Z(ind) = abs(y(ind)) - lam*p*Z(ind).^(p-1);
    end
    Z = sign(y).*Z;
end


% function Z = prox(Y,p,lam,rou)
% if p == 1
%     thr = lam/rou;
%     Z = abs(Y);
%     Z(Z<=thr) = 0;
%     ind = find(Z>0);
%     Z(ind) = abs(Y(ind)) - thr;
%     Z = sign(Y).*Z;
% elseif p < 1 && p > 0
%     k = 3;
%     temp = lam/rou;
%     thr = (2*temp*(1-p))^(1/(2-p)) + temp*p*(2*temp*(1-p))^((p-1)/(2-p));
%     Z = abs(Y);
%     Z(Z<=thr) = 0;
%     ind = find(Z>0);
%     for i = 1:k
%         Z(ind) = abs(Y(ind)) - temp*p*Z(ind).^(p-1);
%     end
%     Z = sign(Y).*Z;
% end


