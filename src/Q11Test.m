% Script Question 11
clear;
clc;

%% Paramètres
V  = 1;                                                  % 1 m/s
Te = 1e-3;                                               % 0.001 s
qi = [-pi/2;    0;  -pi/2; -pi/2; -pi/2; -pi/2];          % coordonnées articulaires initiales
qf = [    0; pi/4;      0;  pi/2;  pi/2; 0];              % coordonnées articulaires finales

% qi = [0.3; 0.2; 0.3; -0.2; 0.25; -0.3];
% qf = qi + 0.05*[1; -1; 1; -1; 1; 1];
[alpha, d, theta, r] = InitValuesTP1(qi);
g_0Ei = CalculMGD(alpha, d, theta, r);
Xdi = g_0Ei(1:3,4);                                      % coordonnées opérationneles initiales
[alpha, d, theta, r] = InitValuesTP1(qf);
g_0Ef = CalculMGD(alpha, d, theta, r);
Xdf = g_0Ef(1:3,4);                                      % coordonnées opérationneles finales
q_min = [-pi; -pi/2;  -pi;  -pi; -pi/2;  -pi];           % coordonnées articulaires minimales
q_max = [  0;  pi/2; pi/2; pi/2;  pi/2; pi/2];           % coordonnées articulaires maximales

%% Calculate consignes qd
qd = MCIbutees(Xdi, Xdf, V, Te, qi, q_min, q_max, 2);

%% Afficher la trajectoire
[~, n] = size(qd);

figure(1)
VisualisationRepere(qd(:,1), 0.1, 'i')
hold on
VisualisationChaine(qd(:,1))
hold on
title('Trajectoire rectiligne du robot 6R')
plot3([Xdi(1,1)],[Xdi(2,1)],[Xdi(3,1)],'r*')
text([Xdi(1,1)],[Xdi(2,1)],[Xdi(3,1)], '     X_{di}')
t = 1:n;
t = t * Te;
Xd_hat = zeros(3,n);
Xd = zeros(3,n);
dX_dt = V * (Xdf - Xdi) / norm(Xdf - Xdi);
erreur = zeros(1,n);

for i = 1:n
    [alpha, d, theta, r] = InitValuesTP1(qd(:,i));
    g0E = CalculMGD(alpha, d, theta, r);
    pE = g0E(1:3,4);
    Xd_hat(:,i) = pE;
    Xd(:,i) = Xdi + dX_dt * (t(i) - Te);
    erreur(i) = norm(Xd(:,i) - Xd_hat(:,i));
    if (mod(i,30) == 0)
        VisualisationChaine(qd(:,i))
        hold on
        plot3([pE(1,1)],[pE(2,1)],[pE(3,1)],'b.')
    end
end

VisualisationRepere(qd(:,n), 0.1, 'f')
hold on
VisualisationChaine(qd(:,n))
hold on
plot3([Xdf(1,1)],[Xdf(2,1)],[Xdf(3,1)],'g*')
text([Xdf(1,1)],[Xdf(2,1)],[Xdf(3,1)], '     X_{df}')
hold off

figure(2)
for i = 1:length(qi)
    subplot(3,2,i)
    plot(t, ones(1,n)*q_min(i,1), 'r--', 'DisplayName', 'q_{min}')
    hold on
    plot(t, ones(1,n)*q_max(i,1), 'r--', 'DisplayName', 'q_{max}')
    plot(t, qd(i,:), 'b', 'DisplayName', 'q')
    ylabel(['coordonée articulaire ', num2str(i,'%1d'), ' (rad)'])
    xlabel('time (s)')
    legend()
    hold off
end

figure(3)
plot(t,erreur);
ylabel(['erreur (m)'])
xlabel('time (s)')


