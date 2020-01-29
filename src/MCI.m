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