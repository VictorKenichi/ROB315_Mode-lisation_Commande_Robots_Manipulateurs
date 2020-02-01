%% Question 13
clear;
clc;

q = zeros(6,1);
% Essayer des valeurs différents de q
q = [-pi/2; 0; -pi/2; -pi/2; -pi/2; -pi/2];
q = - ones(6,1);
q(2,1) = 0;

A = CalculMatriceInertie(q)
