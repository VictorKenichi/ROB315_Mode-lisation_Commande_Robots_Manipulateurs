function [JvG, JwG] = CalculJacobienneCentresMasse(q)
%%% Calcul de la Matrice Jacobienne de chaque corps de la chaîne
%%% articulaire 6R
% Arguments :
% q           - 6x1 - coordonnées articulaires
% Sortie :
% JvG       - 18x6 - matrice Jacobienne de vitesse des centres de masse Gis
%           - JvGi - 3x6 - matrice Jacobienne de vitesse du centre de masse Gi
% JwG       - 18x6 - matrice Jacobienne de vitesse de rotation des Cis
%           - JwGi - 3x6 - matrice Jacobienne de vitesse de rotation de Ci

%% Définition des centre de masse par rapport le repère Ri du corps Ci
G = zeros(3,6);
G(3,1) = -0.25;
G(1,2) = 0.35;
G(2,3) = -0.1;

[alpha, d, theta, r] = InitValuesTP1(q);

%% Calcul des matrices Jacobiennes
JvG = zeros(3*6,6);
JwG = zeros(3*6,6);

for i = 1:6
    [JvG(3*(i-1)+1:3*i,:), JwG(3*(i-1)+1:3*i,:)] = CalculMatriceJacobienneGi(alpha(1:i,1), d(1:i,1), theta(1:i,1), r(1:i,1), G(1,i), G(2,i), G(3,i));
end


end