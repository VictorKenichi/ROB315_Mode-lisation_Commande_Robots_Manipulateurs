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
ex = 1e-3;
alpha_step = 5e-3;
kmax = 100;

dX = (Xdf - Xdi)/(V*Te);
n = round((Xdf(1,1) - Xdi(1,1))/dX(1,1));
qd = zeros(len(q0),nt);
qd(:,1) = qi;
Xd = Xdi;
for i = 2:n
    Xd = Xd + dX;
    qd(:,i) = MGI(Xd, qd(:,i-1), kmax, ex, alpha_step);
end


end