function [alpha, d, theta, r] = InitValuesTP1(q)
%% Crée la matrice de paramètres du robot
%  Argument : q coordonnées articulaires

d3 = 0.7;
r1 = 0.5;
r4 = 0.2;
rE = 0.1;

if nargin < 1
    q = zeros(1,6);
end

alpha = [0,pi/2,0,pi/2,-pi/2,pi/2,0]';
d     = [0,0,d3,0,0,0,0]';
theta = zeros(7,1);
theta(1:6,1) = q(:,1);
theta(3,1) = theta(3,1) + pi/2;
r     = [r1,0,0,r4,0,0,rE]';

end