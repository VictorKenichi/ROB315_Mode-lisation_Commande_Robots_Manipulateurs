function A = CalculMatriceInertie(q)
%%% Calcul de Matrice de Inertie
% Arguments :
% q           - 6x1 - coordonnées articulaires
% Sortie :
% A           - 6x6 - Matrice d'Inertie

A = zeros(6,6);
[alpha, d, theta, r] = InitValuesTP1(q);
g0i = eye(4);
OGi = zeros(3,1);

%% Initialization des paramètres
% Coordonnées des centres de masse
pOi = zeros(3,6);
% Coordonnées des centres de masse
G = zeros(3,6);
G(3,1) = -0.25;
G(1,2) = 0.35;
G(2,3) = -0.1;

% Torseurs d'Inertie
I = zeros(3*6,3);
% Matrice I1 par rapport RO1
I(1,1) = 0.80;
I(1,3) = 0.05;
I(2,2) = 0.80;
I(3,1) = 0.05;
I(3,3) = 0.10;
% Matrice I2 par rapport RO2
I(4,1) = 0.10;
I(4,3) = 0.10;
I(5,2) = 1.50;
I(6,1) = 0.10;
I(6,3) = 1.50;
% Matrice I3 par rapport RO3
I(7,1) = 0.05;
I(8,2) = 0.01;
I(9,3) = 0.05;
% Matrice I4 par rapport RO4
I(10,1) = 0.50;
I(11,2) = 0.50;
I(12,3) = 0.05;
% Matrice I5 par rapport RO5
I(13,1) = 0.01;
I(14,2) = 0.01;
I(15,3) = 0.01;
% Matrice I6 par rapport RO6
I(16,1) = 0.01;
I(17,2) = 0.01;
I(18,3) = 0.01;

% D'autres paramètres
m = [15.0, 10.0, 1.0, 7.0, 1.0, 0.5]; % kg - Masse de chaque corps
Jm = 1e-6;                            % kg.m2 - Moment d'Inertie des rotors
r_red = [100, 100, 100, 70, 70, 70];  % Rapport de réduction


%% Calcul de A
[JvG, JwG] = CalculJacobienneCentresMasse(q);

for i = 1:6
    g0i = g0i * CalculTransformationElem(alpha(i,1), d(i,1), theta(i,1), r(i,1));
    R0i = g0i(1:3,1:3);
    % Changement de repère des Tenseurs d'Inertie
    I(3*(i-1)+1:3*i,:) = R0i * I(3*(i-1)+1:3*i,:) * R0i';
    % Calcul de la Matrice d'Inertie
    A = A + m(i) * JvG(3*(i-1)+1:3*i,:)' * JvG(3*(i-1)+1:3*i,:) + ...
        JwG(3*(i-1)+1:3*i,:)' * I(3*(i-1)+1:3*i,:) * JwG(3*(i-1)+1:3*i,:);
    % Prise en compte des roteurs
    A(i,i) = A(i,i) + r_red(i)^2 * Jm;
end

end