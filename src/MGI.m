function qf = MGI(Xd, q0, k_max, epsilon_x, alpha_step)
%% Mod�le G�om�trique Inverse (MGI) par la matrice 
% Arguments :
% Xd           - 3x1 - Position op�rationelle d�sir�e 3x1
% q0           - 6x1 - Condition initiale 6x1
% k_max        - Nombre maximal d'it�rations
% alpha_step   - Taille de pas
% epsilon      - Erreur cart�sienne tol�r�e
% Sortie :
% qf           - 6x1 - coordonn�es articulaires d�sir�es
 
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
    % M�thode du Gradient
    q  = q + alpha_step * J' * (Xd - fp);

    [alpha, d, theta, r] = InitValuesTP1(q);
    J  = CalculJacobienne(alpha, d, theta, r);
    J  = J(1:3,:);
    g0E  = CalculMGD(alpha, d, theta, r);
    fp   = g0E(1:3, 4);
end
    
qf = q;

end
