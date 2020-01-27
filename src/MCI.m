function qd = MCI(Xdi, Xdf, V, Te, qi)
%%% Calcule les coordonn�es articulaires d�sir�es qd pour r�aliser une
%%% trajectoire rectiligne entre les positions Xdi et Xdf
% Arguments :
% Xdi         - 3x1 - coordonn�es op�rationneles de position d�sir�es initiales
% Xdf         - 3x1 - coordonn�es op�rationneles de position d�sir�es finales
% V           - vitesse constante de l'organe terminale (m/s)
% Te          - pas de temps (s)
% qi          - 6x1 - coordonn�es articulaires initiales
% Sortie :
% qd          - 6xn - coordonn�es articulaires d�sir�es

%% Param�tres :
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