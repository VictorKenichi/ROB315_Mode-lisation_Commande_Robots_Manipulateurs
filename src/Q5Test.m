% Script 5

clear;
clc;

qi = [-pi/2; 0;    -pi/2; -pi/2; -pi/2; -pi/2];
qf = [0;     pi/4; 0;     pi/2;   pi/2; 0];

VisualisationRepere(qi)
hold on

VisualisationRepere(qf)
hold off
