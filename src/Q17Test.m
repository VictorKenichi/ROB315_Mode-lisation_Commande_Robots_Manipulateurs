%% Question 17
clear;
clc;

% dq_dt = zeros(6,1);
% Essayer des valeurs différents de dq_dt
dq_dt = [0.5; 1.0; -0.5; 0.5; 1.0; -0.5];

Gamma_f = CalculCoupleFrottement(dq_dt)
    