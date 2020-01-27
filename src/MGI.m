function qf = MGI(Xd, q0, k_max, epsilon_x, alpha_step)
%% Modèle Géométrique Inverse (MGI) par la matrice 
% Arguments :
% Xd           - 3x1 - Position opérationelle désirée 3x1
% q0           - 6x1 - Condition initiale 6x1
% k_max        - Nombre maximal d'itérations
% alpha_step   - Taille de pas
% epsilon      - Erreur cartésienne tolérée
% Sortie :
% qf           - 6x1 - coordonnées articulaires désirées
 
[alpha, d, theta, r] = InitValuesTP1(q0);
J = CalculJacobienne(alpha, d, theta, r);
J = J((1:3),:);
g0E  = CalculMGD(alpha, d, theta, r);
fp   = g0E(1:3, 4);

k = 0;
q = q0;

while(norm(J') > epsilon_x && k < k_max)
% while(norm(Xd - fp) > epsilon_x && k < kmax)
    k  = k + 1;
    % Méthode du Gradient
    q  = q + alpha_step * J' * (Xd - fp);

    [alpha, d, theta, r] = InitValuesTP1(q);
    J  = CalculJacobienne(alpha, d, theta, r);
    J  = J(1:3,:);
    g0E  = CalculMGD(alpha, d, theta, r);
    fp   = g0E(1:3, 4);
end
    
qf = q;

end
