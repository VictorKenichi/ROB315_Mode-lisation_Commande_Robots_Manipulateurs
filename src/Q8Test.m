clear;
clc;

% Cas 1
q0         = [-1.57; 0.00; -1.47; -1.47; -1.47; -1.47];
Xd         = [-0.1; -0.7; 0.3];
kmax       = 100;
epsilon_x  = 0.001;
alpha_step = 0.005;

qf = MGI(Xd, q0, kmax, epsilon_x, alpha_step)

% Cas 2
% q0         = [0; 0.80; 0; 1; 2; 0];
% Xd         = [0.64; -0.1; 1.14];
% kmax       = 100; 
% alpha_step = 0.005;
% epsilon_x  = 0.001
% 
% qf = MGI(Xd, q0, kmax, epsilon_x, alpha_step)

[alpha, d, theta, r] = InitValuesTP1(qf);
g_0E = CalculMGD(alpha, d, theta, r);
Xdf  = g_0E(1:3, 4)

% Error
error = 0;
for i=1:3
    error = error + ((Xd(i,1) - Xdf(i,1))^2);
end

error = sqrt(error/3)
