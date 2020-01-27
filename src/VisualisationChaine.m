function VisualisationChaine(q)
%%% Affiche la chaîne articulaire
% Arguments :
% q           - coordonnées articulaires

if nargin < 1
    q = zeros(1,6);
end

[alpha, d, theta, r] = InitValuesTP1(q);

G0_E = eye(4);
p0_E = zeros(3,8);
for i=1:7
    G0_E = G0_E * CalculTransformationElem(alpha(i,1), d(i,1), theta(i,1), r(i,1));
    p0_E(1:3,i+1) = G0_E(1:3,4);
    plot3([p0_E(1,i),p0_E(1,i+1)],[p0_E(2,i),p0_E(2,i+1)],[p0_E(3,i),p0_E(3,i+1)],'c-', 'LineWidth', 2)
    hold on
end

hold off

end