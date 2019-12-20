function q = MGI(Xd, q0, k_max, epsilon_x, alpha_step)
%% Mod�le G�om�trique Inverse (MGI) par la matrice 
% Autheur : Gabriel H. Riqueti
% 
% Arguments :
%
% Xd           - position op�rationelle d�sir�e
% q0           - condition initiale
% k_max        - nombre maximal d'it�rations
% alpha_step   - taille de pas
% epsilon      - l'erreur cart�sienne tol�r�e
% le  kmax de l'algorithme, ainsi que la norme de l'erreur cart�sienne tol�r�e
    
    n = size(q0(:,1));
    In = eye(n);
    
    J = CalculJacobienne(alpha_max, Xd, );
    J_pseudo = pinv(J, epsilon_x);
    Nj = In - J_pseudo*J;

    dq_dt = J_pseudo*dXd_dt + Nj*dq0_dt;

end
