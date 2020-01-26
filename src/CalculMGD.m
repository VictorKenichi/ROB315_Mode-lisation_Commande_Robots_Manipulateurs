function [g_0E] = CalculMGD(alpha, d, theta, r)
%%% Calcule la matrice de transformation homogène g d'une chaîne
%%% articulaire
% Arguments :
% alpha       - nx1 - angles autour de l’axe Xi?1 entre les axes Zi?1 et Zi ;
% d           - nx1 - distances le long de l’axe Xi?1 entre les axes Zi?1 et Zi ;
% theta       - nx1 -  angles autour de l’axe Zi entre les axes Xi?1 et Xi.
% r           - nx1 - distances le long de l’axe Zi entre les axes Xi?1 et Xi ;
% Sortie :
% gi           - 4x4 - matrice de transformation homogène

g_0E     = eye(4);
N        = length(alpha);

for i=1:N
    g_0E = g_0E * CalculTransformationElem(alpha(i,1), d(i,1), theta(i,1), r(i,1));
end

end
