function [n, q] = AxeAngleRot(R)
%%% Calcule la direction et l'angle de rotation correspondant à la matrice
%%% R
% Arguments :
% R           - Matrice de Rotatio 3x3
% Sorties :
% n           - Axe de Rotation 1x3
% q           - Angle de Rotation

q = atan2(0.5*sqrt((R(3, 2) - R(2,3))^2 + ...
    (R(1, 3) - R(3, 1))^2 + (R(2,1) - R(1, 2))^2), ...
    0.5*(R(1, 1)+ R(2, 2) + R(3, 3)-1));

n = [(R(3, 2) - R(2, 3))/(2*sin(q)), ...
    (R(1, 3) - R(3, 1))/(2*sin(q)), ...
    (R(2, 1) - R(1, 2))/(2*sin(q))];

end