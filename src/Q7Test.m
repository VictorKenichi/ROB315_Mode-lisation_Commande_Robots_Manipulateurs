% Script 7

clear;
clc;

qi = [-pi/2; 0;    -pi/2; -pi/2; -pi/2; -pi/2];
qf = [0;     pi/4; 0;     pi/2;   pi/2; 0];
dq_dt = [0.5; 1.0; -0.5; 0.5; 1.0; -0.5];

ChampsdeVitesse(qi, dq_dt)
hold on

ChampsdeVitesse(qf, dq_dt)
hold off
