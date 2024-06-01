function ret = GrangerNet_Estimate(Data,flag,NLAGS)

switch flag
    case 1
        ret = LS_granger_regress(Data,NLAGS);%%least square
    case 2
        ret = LASSO_granger_regress(Data,NLAGS);%% LASSO
    case 3
        ret = SBL_granger_regress(Data,NLAGS);%% SBL
    case 4
        ret = DLap_granger_regress(Data,NLAGS);%% DLap
    case 5
        ret = LAP_SBL_granger_regress_1e_6epsilon(Data,NLAGS);%% LAP_SBL epsilon = 1e-6
    case 6
        ret = LAP_SBL_granger_regress(Data,NLAGS);%% LAP_SBL epsilon = 2e-6
    case 7
        ret = GGD_estimate_002_granger_regress(Data,NLAGS);%% GGD_estimate_002
    case 8
        ret = LAP_SBL_granger_regress_4e_6epsilon(Data,NLAGS);%% LAP_SBL epsilon = 1.5e-6
end

end

