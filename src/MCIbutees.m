function qd = MCIbutees(Xdi, Xdf, V, Te, qi, q_min, q_max)
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
% Sortie :
% qd          - 6xn - coordonnées articulaires désirées

%% Paramètres :
epsilon_x = 1e-3;
alpha_step = 5e-4;
k_max = 1000;
q_mean = (q_min + q_max)/2;

n = round(norm(Xdf - Xdi)/(V*Te));
dX_dt_1 = (Xdf - Xdi)/norm(Xdf - Xdi);
qd = zeros(length(qi),n);
Xd = zeros(3,n);
qd(:,1) = qi;
Xd(:,1) = Xdi;
error = zeros(n);
Xd_hat = Xdi;
dq0_dt = zeros(length(qi),1);

for i = 2:n
    Xd(:,i) = Xd(:,i-1) + dX_dt_1 * V * Te;
    k = 0;
    qd(:,i) = qd(:,i-1);
%     while(norm(J_pseudo') > epsilon_x && k < k_max)
    while(norm(Xd - Xd_hat) > epsilon_x && k < k_max)
        k  = k + 1;
        % Méthode du Gradient
        for j = 1:length(qi)
            dq0_dt(j,1) = - alpha_step * (qd(j,i) - q_mean(j,1)) / (q_max(j,1) - q_min(j,1));
        end
        [alpha, d, theta, r] = InitValuesTP1(qd(:,i));
        J  = CalculJacobienne(alpha, d, theta, r);
        J  = J(1:3,:);
        J_pseudo = J'/(J*J');
        dq_dt = J_pseudo * V * dX_dt_1 + (eye(6) - J_pseudo * J) * dq0_dt;
        qd(:,i)  = qd(:,i-1) +  dq_dt * Te;
        g0E  = CalculMGD(alpha, d, theta, r);
        Xd_hat   = g0E(1:3, 4);
    end
    error(i) = norm(Xd_hat(:,1) - Xd(:,i));
end

% figure(1)
% plot(error);

end