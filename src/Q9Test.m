% Script Question 9
clear;
clc;

%% Paramètres
V  = 1;                                                  % 1 m/s
Te = 1e-3;                                               % 0.001 s
qi = [    0; 0.30; -1.26; -1.26; -1.16; -1.26];          % coordonnées articulaires initiales
qf = [-1.20; 0.25; -1.10; -1.35; -1.20; -1.30];          % exemple de coordonnées articulaires finales

qi = [0.3; 0.2; 0.3; -0.2; 0.25; -0.3];
qf = qi + 0.02*[1; -1; 1; -1; 1; 1];
[alpha, d, theta, r] = InitValuesTP1(qi);
g_0Ei = CalculMGD(alpha, d, theta, r);
Xdi = g_0Ei(1:3,4);                                      % coordonnées opérationneles initiales
[alpha, d, theta, r] = InitValuesTP1(qf);
g_0Ef = CalculMGD(alpha, d, theta, r);
Xdf = g_0Ef(1:3,4);                                      % coordonnées opérationneles finales


%% Calculate consignes qd
qd = MCI(Xdi, Xdf, V, Te, qi);


%% Afficher la trajectoire
[~, n] = size(qd);

figure(2)
VisualisationRepere(qd(:,1), 0.1)
hold on
VisualisationChaine(qd(:,1))
hold on
plot3([Xdi(1,1)],[Xdi(2,1)],[Xdi(3,1)],'ro')

for i = 1:n
    if (mod(i,3) == 0)
        [alpha, d, theta, r] = InitValuesTP1(qd(:,i));
        g0E = CalculMGD(alpha, d, theta, r);
        pE = g0E(1:3,4);
        VisualisationChaine(qd(:,i))
        hold on
        plot3([pE(1,1)],[pE(2,1)],[pE(3,1)],'b.')
    end
end

VisualisationRepere(qd(:,n), 0.1)
hold on
VisualisationChaine(qd(:,n))
hold on
plot3([Xdf(1,1)],[Xdf(2,1)],[Xdf(3,1)],'ro')
hold off



