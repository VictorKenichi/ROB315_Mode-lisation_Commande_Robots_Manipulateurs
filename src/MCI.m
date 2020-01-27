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
alpha_step = 1e-4;
kmax = 10000;

n = round(norm(Xdf - Xdi)/(V*Te));
dX = ((Xdf - Xdi)*(V*Te))/norm(Xdf - Xdi);
qd = zeros(length(qi),n);
Xd = zeros(3,n);
qd(:,1) = qi;
Xd(:,1) = Xdi;
error = zeros(n);
time = 1:n;
for i = 2:n
    Xd(:,i) = Xd(:,i-1) + dX;
    qd(:,i) = MGI(Xd(:,i), qd(:,i-1), kmax, epsilon_x, alpha_step);
    [alpha, d, theta, r] = InitValuesTP1(qd(:,i));
    g0E = CalculMGD(alpha, d, theta, r);
    Xd_hat = g0E(1:3,4);
    error(i) = norm(Xd_hat(:,1) - Xd(:,i));
end

figure(1)
plot(error);

end