function ret = GrangerNet_Estimate(Data,flag,NLAGS)

switch flag
    case 1
        ret = LS_granger_regress(Data,NLAGS);%% least square
    case 2
        ret = LASSO_granger_regress(Data,NLAGS);%% LASSO
    case 3
        ret = SBL_granger_regress(Data,NLAGS);%% SBL
    case 4
        ret = DLap_granger_regress(Data,NLAGS);%% DLap
    case 5
        ret = LAP_SBL_granger_regress(Data,NLAGS);%% LAP_SBL 
    case 6
        ret = LAPPS_granger_regress(Data,NLAGS);%% LAP_SBL 
    case 7
        ret = GGD_granger_regress(Data,NLAGS);%% GGD
end

end

