%% Question 14
clear;
clc;

%% Paramètres à régler
k_stoq = 10000;                  % numéro max d'itérations de la recherche stochastique
k_grad = 1000;                    % numéro max d'itérations de la recherche pour gradiant
alpha_step = 3;                 % taux d'apprentissage initial
tol = 1e-6;                     % tolérance
affiche = false;

%% Valeurs de q
q_min = [-pi; -pi/2;  -pi;  -pi; -pi/2;  -pi];   % coordonnées articulaires minimales
q_max = [  0;  pi/2; pi/2; pi/2;  pi/2; pi/2];   % coordonnées articulaires maximales

n_tests = 10;
alpha_min = zeros(1,n_tests);
alpha_max = zeros(1,n_tests);
q_alpha_min = zeros(6,n_tests);
q_alpha_max = zeros(6,n_tests);

disp(['En lançant ', num2str(n_tests), ' testes...'])
for i = 1:n_tests
    disp(['Teste ', num2str(i)]);
    [alpha_min(1,i), alpha_max(1,i), q_alpha_min(:,i), q_alpha_max(:,i)] = CalculBornesMatriceInertie(q_min, q_max, k_stoq, k_grad, alpha_step, tol, affiche);
end


%% Statistiques
disp('Résultats :')
% alpha_min
alpha_min_mean = mean(alpha_min);
alpha_min_std  = std(alpha_min);
disp('Borne minimale mu_1')
disp(['moyenne : ', num2str(alpha_min_mean)])
disp(['écart   : ', num2str(alpha_min_std)])
% alpha_max
alpha_max_mean = mean(alpha_max);
alpha_max_std  = std(alpha_max);
disp('Borne maximale mu_2')
disp(['moyenne : ', num2str(alpha_max_mean)])
disp(['écart   : ', num2str(alpha_max_std)])
% q_alpha_min
q_alpha_min_mean = mean(q_alpha_min,2);
q_alpha_min_std  = std(q_alpha_min,0,2);
% q_alpha_max
q_alpha_max_mean = mean(q_alpha_max,2);
q_alpha_max_std  = std(q_alpha_max,0,2);


