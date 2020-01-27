function [J] = CalculJacobienne(alpha, d, theta, r)
%%% Calcul de Matrice Jacobienne
% Arguments :
% alpha       - 7x1 - angles autour de l’axe Xi?1 entre les axes Zi?1 et Zi ;
% d           - 7x1 - distances le long de l’axe Xi?1 entre les axes Zi?1 et Zi ;
% theta       - 7x1 -  angles autour de l’axe Zi entre les axes Xi?1 et Xi.
% r           - 7x1 - distances le long de l’axe Zi entre les axes Xi?1 et Xi ;
% Sortie :
% J           - 6x6 - matrice Jacobienne

m = 6;
n = length(alpha);
J = zeros(m,6);
Z = [0;0;1];
g_init_i = eye(4,4);
g_i_end = CalculTransformationElem(alpha(n,1),d(n,1),theta(n,1),r(n,1));

for i=1:n-1
    g_init_i = g_init_i*CalculTransformationElem(alpha(i,1),d(i,1),theta(i,1),r(i,1));
    g_i_end = CalculTransformationElem(alpha(n-i,1),d(n-i,1),theta(n-i,1),r(n-i,1))*g_i_end;
    p = g_i_end(1:3,4);
    R = g_init_i(1:3,1:3);
    J(1:3,i) = R*cross(Z,p);
    J(4:6,i) = R*Z;
end


end
