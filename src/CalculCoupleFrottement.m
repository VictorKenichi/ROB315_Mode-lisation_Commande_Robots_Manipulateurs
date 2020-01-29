function Gamma_f = CalculCoupleFrottement(dq_dt)
%%% Calcul du vecteur des couples articulaires produit par les forces de
%%% frottement
% Arguments :
% dq_dt              - 6x1 - vitesses articulaires
% Sortie :
% Gamma_f            - 6x1 - N.m.s/rad couples articulaires produit par les 
%%% forces de frottement

Fv = 10;                            % Frottement visceaux articulaire i=1:6
Gamma_f = zeros(6,1);
for i = 1:6
    Gamma_f(i,1) = dq_dt(i,1) * Fv;
end

end