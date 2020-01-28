function [U,S] = ChampdeVitesse(q, s)
%%% Afficher le champ de vitesse du organe terminale
% Arguments :
% q           - 6x1 - coordonnées articulaires
% Sortie :
% U           - 3x3 - chaque colonne est une direction de vitesse
% S           - 3x3 - importance de la vitesse en chaque direction

npoints = 30; % racine du nombre de points de la surface du ellipsoid

if nargin < 1
    q = zeros(6,1);
elseif nargin < 2
    q = zeros(6,1);
    s = ' ';
end

[alpha, d, theta, r] = InitValuesTP1(q);
J = CalculJacobienne(alpha, d, theta, r);
Jv = J(1:3,:); % pour n'utliser que la vitesse linéaire

% Diréctions sont les autovaleus ou colonnes de U
% Rayon sont les autovaleurs : diagonale principale de S
[U,S,~] = svd(Jv*Jv');

% Calcul du point du organe terminale
g0E = CalculMGD(alpha, d, theta, r);
pE = g0E(1:3,4);

[xelps, yelps, zelps] = ellipsoid(0, 0, 0, S(1,1), S(2,2), S(3,3), npoints);

% U est la matrice de rotation
for i=1:npoints+1
    for j=1:npoints+1
        aux = [xelps(i,j); yelps(i,j); zelps(i,j)];
        aux = U * aux;
        xelps(i,j) = aux(1,1) + pE(1,1);
        yelps(i,j) = aux(2,1) + pE(2,1);
        zelps(i,j) = aux(3,1) + pE(3,1);
    end
end

% Afficher l'ellipsoid
if s == 'i'
    surf(xelps, yelps, zelps, 'EdgeColor', 'm', 'FaceColor', 'none')
elseif s == 'f'
    surf(xelps, yelps, zelps, 'EdgeColor', 'y', 'FaceColor', 'none')
else
    surf(xelps, yelps, zelps, 'EdgeColor', 'interp', 'FaceColor', 'none')
end
hold on;
% Afficher la chaîne articulaire
VisualisationChaine(q)
hold on;
% Afficher les repères de base et du organe terminale
VisualisationRepere(q, 0.1, s)
hold off;

end