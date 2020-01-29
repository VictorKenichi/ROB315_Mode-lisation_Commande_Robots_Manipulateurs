%% Question 14
clear;
clc;

%% Paramètres à régler
k_stoq = 10000;                  % numéro max d'itérations de la recherche stocastique
k_grad = 1000;                    % numéro max d'itérations de la recherche pour gradiant
alpha_step = 3;                 % taux d'apprentissage initial
tol = 1e-6;                     % tolérance
affiche = false;

%% Valeurs de q
q_min = [-pi; -pi/2;  -pi;  -pi; -pi/2;  -pi];   % coordonnées articulaires minimales
q_max = [  0;  pi/2; pi/2; pi/2;  pi/2; pi/2];   % coordonnées articulaires maximales

[alpha_min, alpha_max, q_alpha_min, q_alpha_max] = CalculBornesMatriceInertie(q_min, q_max, k_stoq, k_grad, alpha_step, tol, affiche)

