function qd = MCI(Xdi, Xdf, V, Te, qi)
%%% Calcule les coordonnées articulaires désirées qd pour réaliser une
%%% trajectoire rectiligne entre les positions Xdi et Xdf
% Arguments :
% Xdi         - 3x1 - coordonnées opérationneles de position désirées initiales
% Xdf         - 3x1 - coordonnées opérationneles de position désirées finales
% V           - vitesse constante de l'organe terminale (m/s)
% Te          - pas de temps (s)
% qi          - 6x1 - coordonnées articulaires initiales
% Sortie :
% qd          - 6xn - coordonnées articulaires désirées

%% Paramètres :
epsilon_x = 1e-3;
alpha_step = 5e-3;
k_max = 1000;

n = round(norm(Xdf - Xdi)/(V*Te));
dX_dt = ((Xdf - Xdi) * V)/norm(Xdf - Xdi);
qd = zeros(length(qi),n);
Xd = zeros(3,n);
qd(:,1) = qi;
Xd(:,1) = Xdi;

for i = 2:n
    Xd(:,i) = Xd(:,i-1) + dX_dt * Te;
    qd(:,i) = MGI(Xd(:,i), qd(:,i-1), k_max, epsilon_x, alpha_step);
    [alpha, d, theta, r] = InitValuesTP1(qd(:,i));
end

end