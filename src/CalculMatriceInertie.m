function A = CalculMatriceInertie(q)
%%% Calcul de Matrice de Inertie
% Arguments :
% q           - 6x1 - coordonnées articulaires
% Sortie :
% A           - 3x3 - Matrice d'Inertie

n = length(q);
A = zeros(n,n);

%% Initialization des paramètres
I1 = zeros(3,3);
I2 = zeros(3,3);
I3 = zeros(3,3);
I4 = zeros(3,3);
I5 = zeros(3,3);
I6 = zeros(3,3);
I1(1,1) = 0.80;
I1(1,3) = 0.05;
I1(2,2) = 0.80;
I1(3,1) = 0.05;
I1(1,1) = 0.80;




end