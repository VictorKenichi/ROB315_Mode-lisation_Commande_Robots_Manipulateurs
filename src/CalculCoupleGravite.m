function G = CalculCoupleGravite(q)
%%% Calcul du vecteur des couples articulaires de gravité
% Arguments :
% q           - 6x1 - coordonnées articulaires
% Sortie :
% G           - 6x1 - Matrice d'Inertie

g = [0; 0; -9.81];                      % m/s^2 - accélération de la gravité
m = [15.0, 10.0, 1.0, 7.0, 1.0, 0.5];   % kg - Masse de chaque corps
[JvG, ~] = CalculJacobienneCentresMasse(q);

G = zeros(6,1);

for i = 1:6
    G = G - JvG(3*(i-1)+1:3*i,:)' * m(i) * g;
end

end