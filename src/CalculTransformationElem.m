function [gi] = CalculTransformationElem(alpha_i, d_i, theta_i, r_i)
%%% Calcule la matrice de transformation homogène g entre deux repères consécutifs
% Arguments :
% alpha       - angle autour de l’axe Xi?1 entre les axes Zi?1 et Zi ;
% d           - distance le long de l’axe Xi?1 entre les axes Zi?1 et Zi ;
% theta       -  angle autour de l’axe Zi entre les axes Xi?1 et Xi.
% r           - distance le long de l’axe Zi entre les axes Xi?1 et Xi ;
% Sortie :
% gi           - 4x4 - matrice de transformation homogène

gi = [cos(theta_i),              -sin(theta_i),             0,            d_i;
      cos(alpha_i)*sin(theta_i), cos(alpha_i)*cos(theta_i), -sin(alpha_i), -r_i*sin(alpha_i);
      sin(alpha_i)*sin(theta_i), sin(alpha_i)*cos(theta_i), cos(alpha_i), r_i*cos(alpha_i);
      0,                         0,                         0,            1];

end