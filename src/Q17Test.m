%% Question 17
clear;
clc;

teste = 0;

if teste == 1
    %% Teste la fonction CalculCoupleFrottement
    % dq_dt = zeros(6,1);
    % Essayer des valeurs différents de dq_dt
    dq_dt = [0.5; 1.0; -0.5; 0.5; 1.0; -0.5];

    Gamma_f = CalculCoupleFrottement(dq_dt);
else
    %% Teste le modèle simulink
    qi = [-pi/2; 0;    -pi/2; -pi/2; -pi/2; -pi/2];
    qf = [0;     pi/4; 0;     pi/2;   pi/2; 0];
    q_min = [-pi; -pi/2;  -pi;  -pi; -pi/2;  -pi];
    q_max = [  0;  pi/2; pi/2; pi/2;  pi/2; pi/2];
    q_0 = qi;
    dq_dt_0 = [0.5; 1.0; -0.5; 0.5; 1.0; -0.5];
    
    SimOutput = sim('Modele_dynamique_direct', 'ReturnWorkspaceOutputs', 'on');

end