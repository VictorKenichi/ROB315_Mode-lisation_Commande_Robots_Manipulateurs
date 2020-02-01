function [alpha_min, alpha_max, q_alpha_min, q_alpha_max] = CalculBornesMatriceInertie(q_min, q_max, k_stoq, k_grad, alpha_step0, tol, affiche)
%%% Calcule les bornes de la Matrice d'Inertie avec une tolérance spécifiée
% Arguments :
% qmin          - 6x1 - coordonnées articulaires minimales
% qmax          - 6x1 - coordonnées articulaires maximales
% k_stoq        - numéro max d'itérations de la recherche stocastique
% k_grad        - numéro max d'itérations de la recherche pour gradiant
% alpha_step0   - taux d'apprentissage initial
% tol           - tolérance
% affiche       - affichage
% Sortie :
% alpha_min     - born inférieur de la matrice d'inertie
% alpha_max     - born supérieur de la matrice d'inertie
% q_alpha_min   - 6x1 - coordonnées articulaires du born inférieur
% q_alpha_max   - 6x1 - coordonnées articulaires du born supérieur

if nargin < 7
    affiche = false;
end

alpha_step = alpha_step0;

A_min = CalculMatriceInertie(q_min);
A_max = CalculMatriceInertie(q_max);

S_min = eig(A_min);
S_max = eig(A_max);

%% Valeurs singulières plus petite et plus grande entre les borns
s_min = min([S_min; S_max]);
s_max = max([S_min; S_max]);
if min(S_min) <= min(S_max)
    q_s_min = q_min;
    q_s_min_i = q_min;
    q_s_min_1 = q_max;
    s_min_1 = min(S_max);
else
    q_s_min = q_max;
    q_s_min_i = q_max;
    q_s_min_1 = q_min;
    s_min_1 = min(S_min);
end
if max(S_max) >= max(S_min)
    q_s_max = q_max;
    q_s_max_i = q_max;
    q_s_max_1 = q_min;
    s_max_1 = max(S_min);
else
    q_s_max = q_min;
    q_s_max_i = q_min;
    q_s_max_1 = q_max;
    s_max_1 = max(S_max);
end

S_max_t = zeros(k_stoq + 2 * k_grad);
S_min_t = zeros(k_stoq + 2 * k_grad);
Q_max_t = zeros(6, k_stoq + 2 * k_grad);
Q_min_t = zeros(6, k_stoq + 2 * k_grad);


%%   Recherche stochastique des valeurs initiales
%  afin d'éviter les minimales et maximales locaux
for k = 1:k_stoq
    q_rand = rand(6,1) .* (q_max - q_min) + q_min;
    A = CalculMatriceInertie(q_rand);
    S = eig(A);
    s_min_r = min(S);
    s_max_r = max(S);
    if(s_min_r < s_min)
        s_min_1 = s_min;
        q_s_min_1 = q_s_min;
        s_min = s_min_r;
        q_s_min = q_rand;
    end
    if(s_max_r > s_max)
        s_max_1 = s_max;
        q_s_max_1 = q_s_max;
        s_max = s_max_r;
        q_s_max = q_rand;
    end
    Q_min_t(:,k) = q_s_min;
    Q_max_t(:,k) = q_s_max;
    S_min_t(k) = s_min;
    S_max_t(k) = s_max;
end

time = k;

%% Recherche du minimum global par Gradiant
k = 0;
while s_min_1 - s_min > tol && k < k_grad
    k = k+1;
    % Estimer la dérivée
    q_rand = q_s_min - alpha_step * (q_s_min_1 - q_s_min) * ...
        ((s_min_1 - s_min) / (norm(q_s_min - q_s_min_1)));
    % Vérification si q_rand est dedans [q_min, q_max]
    out = false;
    for i = 1:6
        if q_rand(i,1) < q_min(i,1) || q_rand(i,1) > q_max(i,1)
            out = true;
        end
    end
    if out
        alpha_step = alpha_step / 2;
        q_rand = (q_s_min_1 - q_s_min)/3 + q_s_min;
    end
    % Calculer les valeurs propres
    S = eig(CalculMatriceInertie(q_rand));
    s_min_r = min(S);
    if s_min_r <= s_min
        s_min_1 = s_min;
        q_s_min_1 = q_s_min;
        s_min = s_min_r;
        q_s_min = q_rand;
    else
        alpha_step = alpha_step/2;
    end
    S_max_t(time+k-1) = s_max;
    S_min_t(time+k-1) = s_min;
    Q_min_t(:,time+k-1) = q_s_min;
    Q_max_t(:,time+k-1) = q_s_max;
end

time_min = k;
time = time + k;

q_rand = rand(6,1);
q_rand = q_rand / norm(q_rand);
q_rand = q_s_max + alpha_step * q_rand;
S = eig(CalculMatriceInertie(q_rand));

%% Recherche du maximum global par Gradiant
alpha_step = alpha_step0;
k = 0;
while s_max - s_max_1 > tol && k < k_grad
    k = k+1;
    % Estimer la dérivée
    q_rand = q_s_max + alpha_step * (q_s_max_1 - q_s_max) * ...
        ((s_max_1 - s_max) / (norm(q_s_max - q_s_max_1)));
    % Vérification si q_rand est dedans [q_min, q_max]
    out = false;
    for i = 1:6
        if q_rand(i,1) < q_min(i,1) || q_rand(i,1) > q_max(i,1)
            out = true;
        end
    end
    if out
        alpha_step = alpha_step / 2;
        q_rand = (q_s_max_1 - q_s_max)/3 + q_s_max;
    end
    % Calculer les valeurs propres
    S = eig(CalculMatriceInertie(q_rand));
    s_max_r = max(S);
    if s_max_r >= s_max
        s_max_1 = s_max;
        q_s_max_1 = q_s_max;
        s_max = s_max_r;
        q_s_max = q_rand;
    else
        alpha_step = alpha_step/2;
    end
    S_min_t(time+k-1) = s_min;
    S_max_t(time+k-1) = s_max;
    Q_min_t(:,time+k-1) = q_s_min;
    Q_max_t(:,time+k-1) = q_s_max;
end

time = time + k -1;

alpha_min = s_min - tol;
alpha_max = s_max + tol;
q_alpha_min = q_s_min;
q_alpha_max = q_s_max;
%% Affichage

if affiche == true
    
    figure(1)
    VisualisationRepere(q_s_min_i, 0.05, 'i')
    hold on
    VisualisationChaine(q_s_min_i)
    hold on
    VisualisationRepere(q_s_min, 0.05, 'f')
    hold on
    VisualisationChaine(q_s_min)
    title(['Configuration dont A(q) est minimal s = ',num2str(s_min) ,...
        ' q = [', num2str(q_s_min(1,1)), ', ', num2str(q_s_min(2,1)), ', ',...
        num2str(q_s_min(3,1)), ', ', num2str(q_s_min(4,1)), ', ', ...
        num2str(q_s_min(5,1)), ', ', num2str(q_s_min(6,1)), '] t'])
    hold off


    figure(2)
    VisualisationRepere(q_s_max_i, 0.05, 'i')
    hold on
    VisualisationChaine(q_s_max_i)
    hold on
    VisualisationRepere(q_s_max, 0.05, 'f')
    hold on
    VisualisationChaine(q_s_max)
    title(['Configuration dont A(q) est maximal s = ',num2str(s_max) ,...
        ' et q = [', num2str(q_s_max(1,1)), ', ', num2str(q_s_max(2,1)), ', ',...
        num2str(q_s_max(3,1)), ', ', num2str(q_s_max(4,1)), ', ', ...
        num2str(q_s_max(5,1)), ', ', num2str(q_s_max(6,1)), '] t'])
    hold off

    figure(3)
    subplot(2,1,1)
    plot(1:time, S_min_t(1:time));
    title('Valeurs propes minimales au cours des itérations')
    xlim([1 time])
    subplot(2,1,2)
    plot(1:time, S_max_t(1:time));
    title('Valeurs propes maximales au cours des itérations')
    xlim([1 time])

    figure(4)
    subplot(6,1,1)
    for i = 1:6
        subplot(3,2,i)
        plot(1:time, ones(1,time)*q_min(i,1), 'r', 'DisplayName', 'q_{min}')
        hold on
        plot(1:time, ones(1,time)*q_max(i,1), 'm', 'DisplayName', 'q_{max}')
        plot(1:time, Q_min_t(i,1:time), 'c--', 'DisplayName', 'qs_{min}')
        plot(1:time, Q_max_t(i,1:time), 'b--', 'DisplayName', 'qs_{max}')
        plot([k_stoq, k_stoq], [q_min(i,1), q_max(i,1)], 'k-.', 'DisplayName', 'Sthocastique vs Gradient')
        plot([k_stoq+time_min, k_stoq+time_min], [q_min(i,1), q_max(i,1)], 'k:', 'DisplayName', 'Gradient Min vs Max')
        title(['Coordonnée articulaire q_', num2str(i), ' pour les valeurs propes minimales et maximales'])
        ylabel(['coordonée articulaire ', num2str(i,'%1d'), ' (rad)'])
        xlabel('time (s)')
        legend()
        hold off
    end
end

end