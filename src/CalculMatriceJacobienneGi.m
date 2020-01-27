function [J_vGi, J_wGi] = CalculMatriceJacobienneGi(alpha, d, theta, r, xG, yG, zG)
%%% Calcul de Matrice Jacobienne
%% Arguments :
% alpha       - ix1 - angles autour de l’axe Xi?1 entre les axes Zi?1 et Zi ;
% d           - ix1 - distances le long de l’axe Xi?1 entre les axes Zi?1 et Zi ;
% theta       - ix1 -  angles autour de l’axe Zi entre les axes Xi?1 et Xi.
% r           - ix1 - distances le long de l’axe Zi entre les axes Xi?1 et Xi ;
% xG          - coordonnée x de Gi dans Ri ;
% yG          - coordonnée y de Gi dans Ri ;
% zG          - coordonnée z de Gi dans Ri ;
%% Sorties :
% J_vGi      - 3x6 - matrice Jacobienne de vitesse du centre de masse du corps Ci
% J_wGi      - 3x6 - matrice Jacobienne de vitesse de rotation du corps Ci

i = length(alpha);

alpha_ext = zeros(i+1,1);
d_ext     = zeros(i+1,1);
theta_ext = zeros(i+1,1);
r_ext     = zeros(i+1,1);

alpha_ext(1:i,1) = alpha;
d_ext(1:i,1)     = d;
theta_ext(1:i,1) = theta;
r_ext(1:i,1)     = r;

alpha_ext(i+1,1) = atan2(-yG,zG);
d_ext(i+1,1)     = xG;
r_ext(i+1,1)     = sqrt(yG^2 + zG^2);

J_Gi = CalculJacobienne(alpha_ext, d_ext, theta_ext, r_ext);
J_vGi = J_Gi(1:3,:);
J_wGi = J_Gi(4:6,:);


end