% Script 6
clear;
clc;

qi = [-pi/2; 0;    -pi/2; -pi/2; -pi/2; -pi/2];
qf = [0;     pi/4; 0;     pi/2;   pi/2; 0];
dq_dt = [0.5; 1.0; -0.5; 0.5; 1.0; -0.5];

[alpha, d, theta, r] = InitValuesTP1(qi);
Ji = CalculJacobienne(alpha, d, theta, r);
dXE_dti = Ji * dq_dt

[alpha, d, theta, r] = InitValuesTP1(qf);
Jf = CalculJacobienne(alpha, d, theta, r);
dXE_dtf = Jf * dq_dt

