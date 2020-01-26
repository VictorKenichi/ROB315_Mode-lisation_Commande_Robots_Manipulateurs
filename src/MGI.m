function qf = MGI(Xd, q0, kmax, epsilon_x, alpha_step)
%% Mod�le G�om�trique Inverse (MGI) par la matrice 
% Arguments :
%
% Xd           - Position op�rationelle d�sir�e 3x1
% q0           - Condition initiale 6x1
% k_max        - Nombre maximal d'it�rations
% alpha_step   - Taille de pas
% epsilon      - Erreur cart�sienne tol�r�e
% le  kmax de l'algorithme, ainsi que la norme de l'erreur cart�sienne tol�r�e
 
[alpha, d, theta, r] = InitValuesTP1(q0);
J = CalculJacobienne(alpha, d, theta, r);
J = J((1:3),:);

% M�thode du Gradient
k = 0;
q = q0

    while(norm(J') > epsilon_x && k < kmax)
        k  = k + 1
        J  = CalculJacobienne(alpha, d, theta, r);
        J  = J((1:3),:);
        
        g0E  = CalculMGD(alpha, d, theta, r);
        fp   = g0E(1:3, 4)
         
        q  = q + alpha_step*J'*(Xd - fp);
        
        [alpha, d, theta, r] = InitValuesTP1(q);
    end
    
qf = q;

end
