% Question 4 : 

clear;
clc;

qi = [-pi/2; 0;    -pi/2; -pi/2; -pi/2; -pi/2];
qf = [0;     pi/4; 0;     pi/2;   pi/2; 0];

[alpha, d, theta, r]     = InitValuesTP1(qi);
[alphaf, df, thetaf, rf] = InitValuesTP1(qf);

g_0Ei = CalculMGD(alpha, d, theta, r);
g_0Ef = CalculMGD(alphaf, df, thetaf, rf);

% Vecteur de Position
P_0Ei = g_0Ei(1:3,4)
P_0Ef = g_0Ef(1:3,4)

R_0Ei = g_0Ei(1:3, 1:3);
R_0Ef = g_0Ef(1:3, 1:3);

% Slide 55

% Valeurs Initiales
[ni, qi] = AxeAngleRot(R_0Ei)

% Valeurs Finales
[nf, qf] = AxeAngleRot(R_0Ef)

