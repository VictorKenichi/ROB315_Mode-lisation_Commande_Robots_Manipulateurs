%% Question 16
clear;
clc;

%% Param�tres � r�gler
k_stoq = 1000;                  % num�ro max d'it�rations de la recherche stocastique
k_grad = 30;                    % num�ro max d'it�rations de la recherche pour gradiant
alpha_step = 3;                 % taux d'apprentissage initial
tol = 1e-6;                     % tol�rance
affiche = true;

%% Valeurs de q
q_min = [-pi; -pi/2;  -pi;  -pi; -pi/2;  -pi];   % coordonn�es articulaires minimales
q_max = [  0;  pi/2; pi/2; pi/2;  pi/2; pi/2];   % coordonn�es articulaires maximales

[gb, qb] = CalculBornCoupleGravite(q_min, q_max, k_stoq, k_grad, alpha_step, tol, affiche)

