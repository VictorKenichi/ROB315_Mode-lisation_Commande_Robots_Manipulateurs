function qd = MCIbutees(Xdi, Xdf, V, Te, qi, q_min, q_max, p)
%%% Calcule les coordonnées articulaires désirées qd pour réaliser une
%%% trajectoire rectiligne entre les positions Xdi et Xdf
% Arguments :
% Xdi         - 3x1 - coordonnées opérationneles de position désirées initiales
% Xdf         - 3x1 - coordonnées opérationneles de position désirées finales
% V           - vitesse constante de l'organe terminale (m/s)
% Te          - pas de temps (s)
% qi          - 6x1 - coordonnées articulaires initiales
% qmin        - 6x1 - coordonnées articulaires minimales
% qmax        - 6x1 - coordonnées articulaires maximales
% p           - p de la distance Lp de la fonction de coût
% Sortie :
% qd          - 6xn - coordonnées articulaires désirées

if nargin < 8
    p = 0;
end

q_mean = (q_min + q_max)/2;
n = length(qi);
m = round(norm(Xdf - Xdi)/(V*Te));
dX_dt = ((Xdf - Xdi) * V)/norm(Xdf - Xdi);
qd = zeros(length(qi),m);
Xd = zeros(3,m);
qd(:,1) = qi;
Xd(:,1) = Xdi;
error = zeros(m);
v = zeros(length(qi),1);
[alpha, d, theta, r] = InitValuesTP1(qd(:,1));

for i = 2:m
    Xd(:,i) = Xd(:,i-1) + dX_dt * Te;
    % Fonction de coût : distance Lp
    % PHI(q) = || (qd(:,i) - q_mean(:,1)) / (q_max(:,1) - q_min(:,1)) || p
    phi_p = 0;
    for j = 1:length(qi)
        phi_p = phi_p + ((qd(j,i-1) - q_mean(j,1))  / (q_max(j,1) - q_min(j,1))) ^ p;
    end
    for j = 1:length(qi)
        if p < 1 % L2 carré
            v(j,1) = - 2 * (qd(j,i-1) - q_mean(j,1)) / (q_max(j,1) - q_min(j,1));
        else % Lp
        v(j,1) = - (phi_p ^ (1 - 1/p) / (q_max(j,1) - q_min(j,1))) * ...
            ((qd(j,i-1) - q_mean(j,1)) / (q_max(j,1) - q_min(j,1)))^(p-1) ;
        end
    end
    J  = CalculJacobienne(alpha, d, theta, r);
    J  = J(1:3,:);
    J_pinv = pinv(J);
    dq_dt = J_pinv * dX_dt + (eye(n) - J_pinv * J) * v;
    qd(:,i)  = qd(:,i-1) +  dq_dt * Te;
    [alpha, d, theta, r] = InitValuesTP1(qd(:,i));
    g0E  = CalculMGD(alpha, d, theta, r);
    Xd_hat   = g0E(1:3, 4);
end

end