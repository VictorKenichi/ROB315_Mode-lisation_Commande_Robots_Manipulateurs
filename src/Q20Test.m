%% Question 20
clear;
clc;

%% Teste le modèle simulink
q_di = [-1.00; 0.00; -1.00; -1.00; -1.00; -1.00];   % coordonnées articulaires initiales
q_df = [ 0.00; 1.00;  0.00;  0.00;  0.00;  0.00];

dq_dt_0 = zeros(6,1);
q_0     = zeros(6,1);

Kp = 1;
Kd = 0.2; 

sim('Commande_en_position', 'ReturnWorkspaceOutputs', 'on');
