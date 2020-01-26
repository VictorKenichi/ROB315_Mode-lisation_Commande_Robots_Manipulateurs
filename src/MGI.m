function qf = MGI(Xd, q0, kmax, epsilon_x, alpha_step)
%% Modèle Géométrique Inverse (MGI) par la matrice 
% Arguments :
%
% Xd           - Position opérationelle désirée 3x1
% q0           - Condition initiale 6x1
% k_max        - Nombre maximal d'itérations
% alpha_step   - Taille de pas
% epsilon      - Erreur cartésienne tolérée
% le  kmax de l'algorithme, ainsi que la norme de l'erreur cartésienne tolérée
 
[alpha, d, theta, r] = InitValuesTP1(q0);
J = CalculJacobienne(alpha, d, theta, r);
J = J((1:3),:);

% Méthode du Gradient
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
