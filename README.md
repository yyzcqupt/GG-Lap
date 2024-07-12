# GG-Lap: Robust EEG Causal Brain Networks Based on Generalized Gaussian Prior and Laplace Noise
1. Granger causality based on multivariate autoregressive (MVAR) models offers a robust technical basis for building effective brain networks, representing hidden brain activity data, and exploring neural information processing mechanisms. Nonetheless, in real-world applications, MVAR parameter estimation is highly vulnerable to the impact of unavoidable outliers in EEG signals, such as those caused by muscle movements and eye artifacts. To accurately construct sparse causal brain networks under significant outlier contamination within short time windows, we introduce a novel MVAR parameter estimation method called GG-Lap, which utilizes the generalized Gaussian prior for MVAR parameters and the Laplace distribution for the fitting error within a Bayesian probabilistic framework.
![Figure](Framework.jpg)
3. This code is for our simulation experiment. Making sure all folders have been added to the MATLAB working path before running the code. You can generate simulation data through simulate_networks_data.m. Running the main.m file in the command line window to start the simulation experiment.
4. The DLap_Estimate.p file comes from [https://github.com/Gaitxh/DLap-GCA-Granger-causal-inference-based-on-dual-Laplacian-distribution](https://github.com/Gaitxh/DLap-GCA-Granger-causal-inference-based-on-dual-Laplacian-distribution)
