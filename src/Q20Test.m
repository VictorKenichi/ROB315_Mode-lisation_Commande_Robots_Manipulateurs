%% Question 20
clear;
clc;

%% Teste le modèle simulink
q_di = [-1.00; 0.00; -1.00; -1.00; -1.00; -1.00];   % coordonnées articulaires initiales
q_df = [ 0.00; 1.00;  0.00;  0.00;  0.00;  0.00];

dq_dt_0 = zeros(6,1);
q_0     = q_di;

Kp = 5 * diag([1, 1, 1, 1, 1, 1]);
Kd = 3 * diag([1, 1, 1, 1, 1, 1]);
Tsimu = 30;

SimOutput = sim('Commande_en_position', 'ReturnWorkspaceOutputs', 'on');

t  = SimOutput.q.Time';      % nx1 - temps
q  = SimOutput.q.Data';      % 6xn - coordonnées articulaires
qc = SimOutput.qc.Data';     % 6xn - coordonnées articulaires désirées
n  = length(t);

%% Affichage
figure(1)

% Point de départ
VisualisationRepere(q(:,1), 0.1, 'i')
hold on
VisualisationChaine(q(:,1))
hold on
title('Trajectoire rectiligne du robot 6R')

% Point initial désiré
[alpha, d, theta, r] = InitValuesTP1(qc(:,1));
g0Ei = CalculMGD(alpha, d, theta, r);
Xdi = g0Ei(1:3,4);
plot3([Xdi(1,1)],[Xdi(2,1)],[Xdi(3,1)],'r*')
text([Xdi(1,1)],[Xdi(2,1)],[Xdi(3,1)], '     X_{ci}')
hold on

for i = 1:n
    [alpha, d, theta, r] = InitValuesTP1(q(:,i));
    g0E = CalculMGD(alpha, d, theta, r);
    pE = g0E(1:3,4);
    [alpha, d, theta, r] = InitValuesTP1(qc(:,i));
    g0Ec = CalculMGD(alpha, d, theta, r);
    pEc = g0Ec(1:3,4);
    if (mod(i,3) == 0)
        VisualisationChaine(q(:,i))
        hold on
        plot3([pE(1,1)],[pE(2,1)],[pE(3,1)],'b.')
        hold on
        plot3([pEc(1,1)],[pEc(2,1)],[pEc(3,1)],'mo')
    end
end

% Point final désiré
[alpha, d, theta, r] = InitValuesTP1(qc(:,i));
g0Ef = CalculMGD(alpha, d, theta, r);
Xdf = g0Ef(1:3,4);
plot3([Xdf(1,1)],[Xdf(2,1)],[Xdf(3,1)],'r*')
text([Xdf(1,1)],[Xdf(2,1)],[Xdf(3,1)], '     X_{cf}')

% Point final arrivé
VisualisationRepere(q(:,n), 0.1, 'f')
hold on
VisualisationChaine(q(:,n))
hold off


figure(2)
for i = 1:6
    subplot(3,2,i)
    plot(t, qc(i,:), 'c', 'DisplayName', 'qc')
    hold on
    plot(t, q(i,:), 'b', 'DisplayName', 'q')
    ylabel(['coordonée articulaire ', num2str(i,'%1d'), ' (rad)'])
    xlabel('time (s)')
    hold off
    legend()
end

