function [ X, evidence] = LAP_SBL_estimate_1e_6epsilon( Y,A )
%   Detailed explanation goes here

% Model: Y = A*X + epsilon.
% Dimension of the inverse problem
[n,T] = size(Y);
m = size(A,2);

% Default Control Parameters
lamda = 1+rand();
gamma = ones(m,1); 
beta = ones(n,1);

%% iteration                                                                                                                                                                                                                         
count = 0;
cost = 1;
max_iters = 2000;
prune_gama = 1e-5;
prune_beta = 1e-5;
epsilon = 1e-6;
prune_hyperparameter = 1;
keep_list = (1:m)';
keep_list_beta = 1:n;

while (1)
    
    % *** Prune weights as their hyperparameters go to zero ***
    if ( prune_hyperparameter )
        %index = find(gamma > PRUNE_GAMMA);
        index = find(gamma > max(gamma)*prune_gama); %prue-gamma的方式为根据gamma相对值prune
        gamma = gamma(index);  % use all the elements larger than MIN_GAMMA to form new 'gamma'
        A = A(:,index);       % corresponding columns in A
        keep_list = keep_list(index);
        if (isempty(gamma)) 
            break;   
        end
        
        index1 = find(beta > max(beta)*prune_beta); %prue-beta的方式为根据beta相对值prune
        beta = beta(index1);  % use all the elements larger than MIN_GAMMA to form new 'beta'
        A = A(index1,:);       % corresponding rows in A
        Y = Y(index1,:);
        keep_list_beta = keep_list_beta(index1);
        if (isempty(beta)) 
            break;   
        end   
    end
%         s = length(gamma);
        
     Gamma = diag(gamma);
     Beta  = diag(beta);
     
    % ****** estimate the solution matrix *****
    Sigma_y = Beta + A*Gamma*A';    % the marginal covariance of Y
%     Sigma = Gamma - Gamma*A'/Sigma_y*A*Gamma;%inv(A'*pinv(Beta)*A + inv(Gamma)); %posterior covariance of MVAR parameters
    Mu = Gamma*A'/Sigma_y*Y;     
  
    count = count + 1;
    cost_old = cost;
    
    % cost function
    cost = lamda^2*trace(Beta) - 2*n*T*log(lamda) + T*log(det(Sigma_y/Beta)) + trace(Y'/Sigma_y*Y); 
    evidence(count,1) = cost;
    %% *** Update hyperparameters***
    lamda = sqrt(n*T/sum(beta));    % update lamda
    Res = Y-A*Mu;

    beta = sqrt(sum(Res.^2,2))./ lamda;
    beta(beta < eps) = eps;
    
    Z = diag(A'/Sigma_y*A);   % upadte z
    
    gamma  = sqrt(sum(Mu.^2,2)) ./ sqrt(T*Z);
    
    % print
    disp(['LAP_SBL_iters: ',num2str(count),'   cost',num2str(cost)]);
    disp(['LAP_SBL_iters: ',num2str(count),'   cost change: ',num2str(abs((cost-cost_old)/cost_old))]);
    
    % *** Check stopping conditions
    if (count >= max_iters)
        break;
    end
    
    if ( abs((cost-cost_old)/cost_old) < epsilon )
        break;
    end

end

X = zeros(m,T);
X(keep_list,:) = Mu; 

% Expand hyperparameters 
% gamma_ind = sort(keep_list);
% gamma_est = zeros(m,1);
% gamma_est(keep_list,1) = gamma;  
% 
% beta_ind = sort(keep_list_beta);
% beta_est = zeros(n,1);
% beta_est(keep_list_beta,1) = beta;  

% expand the final solution


