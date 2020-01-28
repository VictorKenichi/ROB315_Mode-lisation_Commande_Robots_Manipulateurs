% Script 12
clear;
clc;

q = zeros(6,1);
% Essayer des valeurs différents de q
% q = [-pi/2; 0; -pi/2; -pi/2; -pi/2; -pi/2];

[JvG, JwG] = CalculJacobienneCentresMasse(q);

J_vG1 = JvG(1:3,:)
J_vG2 = JvG(4:6,:)
J_vG3 = JvG(7:9,:)
J_vG4 = JvG(10:12,:)
J_vG5 = JvG(13:15,:)
J_vG6 = JvG(16:18,:)

J_wG1 = JwG(1:3,:)
J_wG2 = JwG(4:6,:)
J_wG3 = JwG(7:9,:)
J_wG4 = JwG(10:12,:)
J_wG5 = JwG(13:15,:)
J_wG6 = JwG(16:18,:)
