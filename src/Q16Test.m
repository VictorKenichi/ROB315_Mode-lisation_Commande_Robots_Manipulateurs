%% Question 16
clear;
clc;

%% Param�tres � r�gler
k_stoq = 10000;                  % num�ro max d'it�rations de la recherche stocastique
k_grad = 1000;                    % num�ro max d'it�rations de la recherche pour gradiant
alpha_step = 3;                 % taux d'apprentissage initial
tol = 1e-6;                     % tol�rance
affiche = false;

%% Valeurs de q
q_min = [-pi; -pi/2;  -pi;  -pi; -pi/2;  -pi];   % coordonn�es articulaires minimales
q_max = [  0;  pi/2; pi/2; pi/2;  pi/2; pi/2];   % coordonn�es articulaires maximales

n_tests = 10;
gb = zeros(1,n_tests);
qb = zeros(6,n_tests);

disp(['En lan�ant ', num2str(n_tests), ' testes...'])
for i = 1:n_tests
    disp(['Teste ', num2str(i)]);
    [gb(1,i), qb(:,i)] = CalculBornCoupleGravite(q_min, q_max, k_stoq, k_grad, alpha_step, tol, affiche);
end

%% Statistiques
disp('R�sultats :')
% gb
gb_mean = mean(gb);
gb_std  = std(gb);
disp('Borne maximale g_b')
disp(['moyenne : ', num2str(gb_mean)])
disp(['�cart   : ', num2str(gb_std)])
% q_alpha_min
qb_mean = mean(qb,2);
qb_std  = std(qb,0,2);


