function ChampsdeVitesse(q, dq_dt)
%%%
% Arguments :
% q           - coordonnées articulaires
% dq_dt       - vitesses articulaires

if nargin < 2
    q = zeros(6,1);
    dq_dt = zeros(6,1);
end

[alpha, d, theta, r] = InitValuesTP1(q);
J = CalculJacobienne(alpha, d, theta, r);
dXE_dt = J*dq_dt;

g0E = CalculMGD(alpha, d, theta, r);
pE = g0E(1:3,4);

[xelps, yelps, zelps] = ellipsoid(pE(1,1), pE(2,1), pE(3,1), dXE_dt(1,1), dXE_dt(2,1), dXE_dt(3,1), 100);
surf(xelps, yelps, zelps, 'EdgeColor', 'interp', 'FaceColor', 'none')
hold on;
VisualisationRepere(q)
hold off;

end