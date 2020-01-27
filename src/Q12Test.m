% Script 12
clear;
clc;

G1 = [0; 0; -0.25];
G2 = [0.35; 0; 0];
G3 = [0; -0.1; 0];
G4 = [0; 0; 0];
G5 = [0; 0; 0];
G6 = [0; 0; 0];
q = [-pi/2; 0;    -pi/2; -pi/2; -pi/2; -pi/2];

[alpha, d, theta, r] = InitValuesTP1(q);

[J_vG1, J_wG1] = CalculMatriceJacobienneGi(alpha(1,1), d(1,1), theta(1,1), r(1,1), G1(1,1), G1(2,1), G1(3,1))
[J_vG2, J_wG2] = CalculMatriceJacobienneGi(alpha(1:2,1), d(1:2,1), theta(1:2,1), r(1:2,1), G2(1,1), G2(2,1), G2(3,1))
[J_vG3, J_wG3] = CalculMatriceJacobienneGi(alpha(1:3,1), d(1:3,1), theta(1:3,1), r(1:3,1), G3(1,1), G3(2,1), G3(3,1))
[J_vG4, J_wG4] = CalculMatriceJacobienneGi(alpha(1:4,1), d(1:4,1), theta(1:4,1), r(1:4,1), G4(1,1), G4(2,1), G4(3,1))
[J_vG5, J_wG5] = CalculMatriceJacobienneGi(alpha(1:5,1), d(1:5,1), theta(1:5,1), r(1:5,1), G5(1,1), G5(2,1), G5(3,1))
[J_vG6, J_wG6] = CalculMatriceJacobienneGi(alpha(1:6,1), d(1:6,1), theta(1:6,1), r(1:6,1), G6(1,1), G6(2,1), G6(3,1))

