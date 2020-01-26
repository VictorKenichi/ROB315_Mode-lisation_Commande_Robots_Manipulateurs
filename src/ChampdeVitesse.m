function [U,S] = ChampdeVitesse(q)
%%% Afficher le champ de vitesse du organe terminale
% Arguments :
% q           - 6x1 - coordonnées articulaires
% Sortie :
% U           - 3x3 - chaque colonne est une direction de vitesse
% S           - 3x3 - importance de la vitesse en chaque direction

npoints = 30; % racine du nombre de points de la surface du ellipsoid

if nargin < 1
    q = zeros(6,1);
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

% Calcul de la matrice de rotation à appliquer sur l'ellipsoid
I3 = eye(3);
Rot = zeros(3,3);
for i=1:3
    for j=1:3
        Rot(i,j) = dot(U(:,j),I3(i,:));
    end
end

[xelps, yelps, zelps] = ellipsoid(0, 0, 0, S(1,1), S(2,2), S(3,3), npoints);

for i=1:npoints+1
    for j=1:npoints+1
        aux = [xelps(i,j); yelps(i,j); zelps(i,j)];
        aux = Rot * aux;
        xelps(i,j) = aux(1,1) + pE(1,1);
        yelps(i,j) = aux(2,1) + pE(2,1);
        zelps(i,j) = aux(3,1) + pE(3,1);
    end
end

% Afficher l'ellipsoid
surf(xelps, yelps, zelps, 'EdgeColor', 'interp', 'FaceColor', 'none')
hold on;
% Afficher les repères de base et du organe terminale
VisualisationRepere(q)
hold off;

end