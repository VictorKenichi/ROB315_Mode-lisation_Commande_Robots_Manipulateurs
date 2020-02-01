% Question 18
clear;
clc;


qdi = [-1.00; 0.00; -1.00; -1.00; -1.00; -1.00];   % coordonnées articulaires initiales
qdf = [ 0.00; 1.00;  0.00;  0.00;  0.00;  0.00];   % coordonnées articulaires finales
dq_dt = zeros(6,1);                    % vitesses articulaires initiales et finales
d2q_dt2 = zeros(6,1);                  % accélérations articulaires initiales et finales
Tau_max = 5;                           % N.m - couple maximal des moteurs
red = [100, 100, 100, 70, 70, 70];     % rédutions de chaque moteur
alpha_max = 11.289679;                 % Born supérieur obtenu de la Question 14
Te = 0.001;                             % s - pas de temps

%% Calcul de ka
ka = Tau_max * red / alpha_max;
ka = ka'

[qd, tf] = GenerationTrajP5HorsLigne(qdi, qdf, dq_dt, dq_dt, d2q_dt2, d2q_dt2, ka, Te)


%% Affichage
figure(1)
VisualisationRepere(qdi, 0.1, 'i')
hold on
VisualisationChaine(qdi)
hold on
VisualisationRepere(qdf, 0.1, 'f')
hold on
VisualisationChaine(qdf)
hold on
title('Trajectoire polynomiale de 5ème dégré du robot 6R')

for i = 1:round(max(tf)/Te)
    [alpha, d, theta, r] = InitValuesTP1(qd(:,i));
    g0E = CalculMGD(alpha, d, theta, r);
    pE = g0E(1:3,4);
    if (mod(i,10) == 0)
        plot3([pE(1,1)],[pE(2,1)],[pE(3,1)],'mo')
    end
end

hold off



