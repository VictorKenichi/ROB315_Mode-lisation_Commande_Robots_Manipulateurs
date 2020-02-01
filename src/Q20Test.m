%% Question 20
clear;
clc;

%% Teste le modèle simulink
q_di = [-1.00; 0.00; -1.00; -1.00; -1.00; -1.00];   % coordonnées articulaires initiales
q_df = [ 0.00; 1.00;  0.00;  0.00;  0.00;  0.00];   % coordonnées articulaires finales

dq_dt_0 = zeros(6,1);
q_0     = q_di;

Kp = diag([59.6, 38.225, 204.4, 190, 190, 190]);
Kd = diag([176, 157.573, 246.1, 227.5, 227.5, 227.5]);

Tsimu = 10;                               % s - temps de simulation
e_max = 0.05;                             % rad - erreur maximal
tau_max = 5;                              % N.m - couple maximal des moteurs
red = [100; 100; 100; 70; 70; 70];        % rapport de réduction

%% Lancer une simulation
SimOutput = sim('Commande_en_position', 'ReturnWorkspaceOutputs', 'on');

t  = SimOutput.q.Time';         % nx1 - temps
q  = SimOutput.q.Data';         % 6xn - coordonnées articulaires
qc = SimOutput.qc.Data';        % 6xn - coordonnées articulaires désirées
Gamma = SimOutput.Gamma.Data';  % 6xn - couple de actioneurs
e  = qc - q;                    % 6xn - erreur de coordonnées articulaires
n  = length(t);

Gamma_m = zeros(6,n);
for i=1:n
    Gamma_m(:,i) = Gamma(:,i) .* red .^ (-1);
end

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

figure(3)
for i = 1:6
    subplot(3,2,i)
    plot(t, e_max * ones(1,n), 'm--', 'DisplayName', 'e_{max}')
    hold on
    plot(t, - e_max * ones(1,n), 'm--', 'DisplayName', '-e_{max}')
    hold on
    plot(t, e(i,:), 'r', 'DisplayName', 'e')
    ylabel(['erreur de la coordonée articulaire ', num2str(i,'%1d'), ' (rad)'])
    xlabel('time (s)')
    hold off
    legend()
end


figure(4)
for i = 1:6
    subplot(3,2,i)
    plot(t, tau_max * ones(1,n), 'r--', 'DisplayName', 'tau_{max}')
    hold on
    plot(t, - tau_max * ones(1,n), 'r--', 'DisplayName', '-tau_{max}')
    hold on
    plot(t, Gamma_m(i,:), 'g', 'DisplayName', 'tau')
    ylabel(['couple du moteur ', num2str(i,'%1d'), ' (N.m)'])
    xlabel('time (s)')
    hold off
    legend()
end

