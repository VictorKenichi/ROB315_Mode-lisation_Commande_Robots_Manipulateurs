% Question 1
clear;
clc;

q = zeros(6,1);
% Essayer différentes valeurs de q
% q = rand(6,1) * pi - pi/2;


%% Affichage
figure(1)
VisualisationRepere(q, 0.15, 'n')
title('Description de la géométrie du robot 6R')
hold on
VisualisationChaine(q, true, 0.1)
hold off
% Commenter cette partir pour changer l'affichage
xlim([0 1.4])
ylim([-0.7 0.7])
zlim([0 1.4])

