% Script 6

clear;
clc;

qi = [-pi/2, 0,    -pi/2, -pi/2, -pi/2, -pi/2];
qf = [0,     pi/4, 0,     pi/2,   pi/2, 0];
dq_dt = [0.5, 1.0, -0.5, 0.5, 1.0, -0.5];

q = qi;
[alpha, d, theta, r] = InitValuesTP1(q);
J = CalculJacobienne(alpha, d, theta, r);
% dXE_dt = J*q

q = qf;
[alpha, d, theta, r] = InitValuesTP1(q);
J = CalculJacobienne(alpha, d, theta, r);
% dXE_dt = J*q

