% Question 4 : 

clear;
clc;

qi = [-pi/2; 0;    -pi/2; -pi/2; -pi/2; -pi/2];
qf = [0;     pi/4; 0;     pi/2;   pi/2; 0];

[alpha, d, theta, r]     = InitValuesTP1(qi);
[alphaf, df, thetaf, rf] = InitValuesTP1(qf);

g_0E = CalculMGD(alpha, d, theta, r);
g_0Ef = CalculMGD(alphaf, df, thetaf, rf);

% Vecteur de Position
P_0Ei = g_0E(1:3,4);
P_0Ef = g_0Ef(1:3,4);

R_0E = g_0E(1:3, 1:3);
R_0Ef = g_0Ef(1:3, 1:3);

% Slide 55

% Valeurs Initiales
qi = atan2(0.5*sqrt((R_0E(3, 2) - R_0E(2,3))^2 + ...
    (R_0E(1, 3) - R_0E(3, 1))^2 + (R_0E(2,1) - R_0E(1, 2))^2), ...
    0.5*(R_0E(1, 1)+ R_0E(2, 2) + R_0E(3, 3)-1));

ni = [(R_0E(3, 2) - R_0E(2, 3))/(2*sin(qi)), ...
    (R_0E(1, 3) - R_0E(3, 1))/(2*sin(qi)), ...
    (R_0E(2, 1) - R_0E(1, 2))/(2*sin(qi))];

% Valeurs Finales
qf = atan2(0.5*sqrt((R_0Ef(3, 2) - R_0Ef(2,3))^2 + ...
    (R_0Ef(1, 3) - R_0Ef(3, 1))^2 + (R_0Ef(2,1) - R_0Ef(1, 2))^2), ...
    0.5*(R_0Ef(1, 1)+ R_0Ef(2, 2) + R_0Ef(3, 3)-1));

nf = [(R_0Ef(3, 2) - R_0Ef(2, 3))/(2*sin(qf)), ...
    (R_0Ef(1, 3) - R_0Ef(3, 1))/(2*sin(qf)), ...
    (R_0Ef(2, 1) - R_0Ef(1, 2))/(2*sin(qf))];

