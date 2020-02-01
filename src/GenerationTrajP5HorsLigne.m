function [qd, tf] = GenerationTrajP5HorsLigne(qi, qf, dq_dti, dq_dtf, d2q_dt2i, d2q_dt2f, ka, Te)
%%% Calcule les coordonn�es articulaires d�sir�es qd pour r�aliser une
%%% trajectoire entre les positions Xdi et Xdf en respectant les consignes
%%% de acc�l�rations avec une trajectoire polymoniale de d�gr� 5.
% Arguments :
% qi          - 6x1 - coordonn�es articulaires initiales
% qf          - 6x1 - coordonn�es articulaires finales
% dq_dti      - 6x1 - vitesses articulaires initiales
% dq_dtf      - 6x1 - vitesses articulaires finales
% d2q_dt2i    - 6x1 - acc�l�rations articulaires initiales
% d2q_dt2i    - 6x1 - acc�l�rations articulaires finales
% ka          - 6x1 - rad/s^2 - acc�l�rations articulaires maximales
% Te          - s - pas de temps
% Sortie :
% qd          - 6xn - coordonn�es articulaires d�sir�es
% tf          - 6x1 - s - temps finals d'ex�cution de chaque articulation

tf = zeros(6,1);
for i=1:6
    tf(i,1) = sqrt((10 * abs(qf(i,1) - qi(i,1)))/(sqrt(3) * ka(i,1)));
end
tf_total = max(tf);
qd = zeros(6, round(tf_total / Te));

ATraj = [0,  0,  0, 0, 0, 1;...
         1,  1,  1, 1, 1, 1;...
         0,  0,  0, 0, 1, 0;...
         5,  4,  3, 2, 1, 0;...
         0,  0,  0, 2, 0, 0;...
         20, 12, 6, 2, 0, 0];

bTraj = [0; 1; norm(dq_dti / (qf - qi)); norm(dq_dtf / (qf - qi)); norm(d2q_dt2i / (qf - qi)); norm(d2q_dt2f / (qf - qi))];

p5 = ATraj \ bTraj;
% p5 = [6; -15; 10; 0; 0; 0]; slide 198

for k = 1:round(tf_total / Te)
    t = k * Te;
    T = [(t/tf_total)^5; (t/tf_total)^4; (t/tf_total)^3; (t/tf_total)^2; (t/tf_total); 0];
    qd(:,k) = qi + dot(p5, T) * (qf - qi);
end


end