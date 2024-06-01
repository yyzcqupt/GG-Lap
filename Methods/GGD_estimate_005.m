function [X] = GGD_estimate_005(Y,A)

% Model: Y = A*X + epsilon.


[n,T] = size(Y);
m = size(A,2);


%% Default Control Parameters
lamda = 1+rand();
gamma = ones(m,1); 
beta = ones(n,1);
w = ones(m,1);
p = 0.4;
X = zeros(m,T);
% X = LS_estimate(Y, A);

% fix alpha
% tmp = sqrt(sum((A'*Y).^2,2));
alpha = 0.05;

%% iteration parameter setting                                                                                                                                                                                                                        
count = 0;
cost = 1;
max_iters = 1000;
prune_gama = 1e-5;
prune_beta = 1e-5;
prune_w = 1e-5;
% epsilon = 1e-4;
epsilon = 5e-5;
prune_hyperparameter = 1;
keep_list = (1:m)';
keep_list_beta = 1:n;
keep_list_w = (1:m)';

while (1)
   
    
    Gamma = diag(gamma);
    Beta  = diag(beta);
    
    % ****** estimate the solution matrix *****
    count = count + 1;
    cost_old = cost;
    
    %% *** Update hyperparameters***
    % update lamda
    lamda = sqrt(n*T/sum(beta));    
    
    % updata kesai
    kesai = diag(pinv(Gamma+A'*pinv(Beta)*A));
    
    % update X
    h = T*kesai + sum(X.^2,2);
      
    w = alpha^(-p)*sqrt(sum(h.^(p-2),2));
    w(w<max(w)*1e-6) = max(w)*1e-6;
    W = diag(w);
    X_inter_old = X;
    X = pinv(A'*(pinv(Beta)+(pinv(Beta))')*A + 2*W + 2*W')*A'*(pinv(Beta)+pinv(Beta)')*Y;
    
%     if  norm((X - X_inter_old),'fro')/norm(X,'fro') < 1e-6 
%         disp('X promble\n');
%         break;
%     end
    
%     if sum(w) == 0
%         disp('w promble');
%         break;
%     end
    
    % update Beta
    Res = Y-A*X;
    beta = sqrt(sum(Res.^2,2))./ lamda;
    
    % update Gamma
    h = T*kesai + sum(X.^2,2);
    gamma = p*alpha^(-p)*sqrt(sum(h.^(p-2),2));
%     gamma = p*lamda^(-p)*(T*kesai + sum(T*kesai + sum(X.^2,2)));
    
    gamma(gamma<max(gamma)*1e-6) = max(gamma)*1e-6;
    beta(beta<max(beta)*1e-6) = max(beta)*1e-6;
    Gamma = diag(gamma);
    Beta  = diag(beta);
    %% Calculate the loss function and its change
    % cost function
    rr = sqrt(sum(X.^2,2)+kesai);
%     cost = T*log(det(Gamma + A'*pinv(Beta)*A)) + 2*T*n*log(lamda) + lamda^2*trace(Beta) + trace((Y - A*X)'*pinv(Beta)*(Y - A*X)) + trace(X'*Gamma*X) - sum((p-2)*alpha^(-p)*rr.^p) + 2*size(X,1)*log(alpha);
    cost = T*log(det(Gamma + A'*pinv(Beta)*A)) - 2*T*n*log(lamda) + lamda^2*trace(Beta) + trace((Y - A*X)'*pinv(Beta)*(Y - A*X)) + trace(X'*Gamma*X) - sum((p-2)*alpha^(-p)*rr.^p) + 2*size(X,1)*log(alpha);
    % print
    disp(['GGD_estimate_005_iters: ',num2str(count),'   cost',num2str(cost)]);
    disp(['GGD_estimate_005_iters: ',num2str(count),'   cost change: ',num2str(abs((cost-cost_old)/cost_old))]);
    
    %% Check stopping conditions
    if (count >= max_iters)
        disp('over max_iters\n');
        break;
    end
    
    if ( abs((cost-cost_old)/cost_old) < epsilon )
        disp('cost enough low\n');
        break;
    end
%     if  norm((X - X_inter_old),'fro')/norm(X,'fro') < 1e-4 
%                 break;
%     end
end