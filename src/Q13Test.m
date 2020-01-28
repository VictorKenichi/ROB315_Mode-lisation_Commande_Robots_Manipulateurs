%% Question 13
clear;
clc;

q = zeros(6,1);
% Essayer des valeurs différents de q
q = [-pi/2; 0; -pi/2; -pi/2; -pi/2; -pi/2];

A = CalculMatriceInertie(q)
