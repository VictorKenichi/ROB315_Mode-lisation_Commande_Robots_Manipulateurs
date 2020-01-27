clear;
clc;

% Paramètres
cas = 2;

% Cas 1
if cas == 1
    q0         = [-1.57; 0.00; -1.47; -1.47; -1.47; -1.47];
    Xd         = [-0.1; -0.7; 0.3];
    kmax       = 100;
    alpha_step = 0.005;
    epsilon_x  = 0.001;

    qf = MGI(Xd, q0, kmax, epsilon_x, alpha_step)
elseif cas == 2
    q0         = [0.00; 0.80; 0.00; 1.00; 2.00; 0.00];
    Xd         = [0.64; -0.10; 1.14];
    kmax       = 100;
    alpha_step = 0.005;
    epsilon_x  = 0.001;

    qf = MGI(Xd, q0, kmax, epsilon_x, alpha_step)
else
    % Essayer d'autres points ici
    q0         = [0.05; 0.35; 0.05; 0.45; 0.25; 0.05];
    [alpha, d, theta, r] = InitValuesTP1(q0 + 0.004*[1;-1;1;-1;-1;1]);
    Xd         = CalculMGD(alpha, d, theta, r);
    Xd         = Xd(1:3,:);
    kmax       = 100; 
    alpha_step = 0.005;
    epsilon_x  = 0.001;

    qf = MGI(Xd, q0, kmax, epsilon_x, alpha_step)
end

[alpha, d, theta, r] = InitValuesTP1(q0);
g_0E = CalculMGD(alpha, d, theta, r);
Xdi  = g_0E(1:3, 4)

[alpha, d, theta, r] = InitValuesTP1(qf);
g_0E = CalculMGD(alpha, d, theta, r);
Xdf  = g_0E(1:3, 4)

% Error
errori = norm(Xd - Xdi)
errorf = norm(Xd - Xdf)

VisualisationRepere(q0, 0.01)
hold on
VisualisationChaine(q0)
hold on
VisualisationRepere(qf, 0.01)
hold on
VisualisationChaine(qf)
hold on
plot3([Xdf(1,1)],[Xdf(2,1)],[Xdf(3,1)],'rh')
hold on
plot3([Xd(1,1)],[Xd(2,1)],[Xd(3,1)],'ro')
hold off
