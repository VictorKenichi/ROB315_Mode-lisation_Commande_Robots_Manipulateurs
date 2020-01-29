% Script 7

clear;
clc;

qi = [-pi/2; 0;    -pi/2; -pi/2; -pi/2; -pi/2];
qf = [0;     pi/4; 0;     pi/2;   pi/2; 0];

[Ui, Si] = ChampdeVitesse(qi, 'i')
hold on

[Uf, Sf] = ChampdeVitesse(qf, 'f')
title('Champs de vitesse du organe terminale initial et final')
hold off
