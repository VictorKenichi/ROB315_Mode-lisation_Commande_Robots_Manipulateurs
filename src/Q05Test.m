% Script 5

clear;
clc;

qi = [-pi/2; 0;    -pi/2; -pi/2; -pi/2; -pi/2];
qf = [0;     pi/4; 0;     pi/2;   pi/2; 0];

figure(1)
VisualisationRepere(qi, 1, 'i')
hold on

VisualisationRepere(qf, 1, 'f')
title('Repères de base et du terminal initial et final')
xlim([-1.25 1.25])
ylim([-1.25 1.25])
zlim([-1 1.5])
hold off
