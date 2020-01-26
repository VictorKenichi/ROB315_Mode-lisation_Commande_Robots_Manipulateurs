% Script Question 9
clear;
clc;

V  = 1;                                                  % 1 m/s
Te = 1e-3;                                               % 0.001 s
qi = [-pi/2; 0;    -pi/2; -pi/2; -pi/2; -pi/2];          % coordonnées articulaires initiales
g_0Ei = CalculMGD(qi);
Xdi = g_0Ei(1:3,4);
qf = [0;     pi/4; 0;     pi/2;   pi/2; 0];              % exemple de coordonnées articulaires finales
g_0Ef = CalculMGD(qf);
Xdf = g_0Ef(1:3,4);

qd = MCI(Xdi, Xdf, V, Te, qi);

[l, c] = size(qd);

