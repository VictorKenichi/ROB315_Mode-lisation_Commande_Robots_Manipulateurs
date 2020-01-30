%% Question 19
clear;
clc;


%% Teste le modèle simulink
q_di = [-1.00; 0.00; -1.00; -1.00; -1.00; -1.00];   % coordonnées articulaires initiales
q_df = [ 0.00; 1.00;  0.00;  0.00;  0.00;  0.00];

SimOutput = sim('Generation_de_trajectoire', 'ReturnWorkspaceOutputs', 'on');

