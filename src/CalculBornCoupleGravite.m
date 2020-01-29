function [gb, qb] = CalculBornCoupleGravite(q_min, q_max, k_stoq, k_grad, alpha_step, tol, affiche)
%%% Calcule le borne de la norme de la Matrice Couple de Gravité avec une 
%%% tolérance spécifiée
% Arguments :
% qmin          - 6x1 - coordonnées articulaires minimales
% qmax          - 6x1 - coordonnées articulaires maximales
% k_stoq        - numéro max d'itérations de la recherche stocastique
% k_grad        - numéro max d'itérations de la recherche pour gradiant
% alpha_step    - taux d'apprentissage (initial)
% tol           - tolérance
% affiche       - affichage
% Sortie :
% gb           - born supérieur de la matrice couple de gravité
% qb           - 6x1 - coordonnées articulaires du born supérieur

if nargin < 7
    affiche = false;
end

G_min = CalculCoupleGravite(q_min);
G_max = CalculCoupleGravite(q_max);

g_q_min = norm(G_min,1);
g_q_max = norm(G_max,1);

%% Valeurs singulières plus petite et plus grande entre les borns
g_max = max(g_q_min, g_q_max);
if g_q_min >= g_q_max
    q_g_max = q_min;
    q_g_max_i = q_min;
    q_g_max_1 = q_max;
    g_max_1 = g_q_max;
else
    q_g_max = q_max;
    q_g_max_i = q_max;
    q_g_max_1 = q_min;
    g_max_1 = g_q_min;
end

G_b_t   = zeros(k_stoq + 2 * k_grad);
Q_max_t = zeros(6, k_stoq + 2 * k_grad);

%%   Recherche stocastique de la valeur initiale
%  afin d'éviter les maximales locaux
for k = 1:k_stoq
    q_rand = rand(6,1) .* (q_max - q_min) + q_min;
    G = CalculCoupleGravite(q_rand);
    g_max_r = norm(G,1);
    if(g_max_r > g_max)
        g_max_1 = g_max;
        q_g_max_1 = q_g_max;
        g_max = g_max_r;
        q_g_max = q_rand;
    end
    Q_max_t(:,k) = q_g_max;
    G_b_t(k) = g_max;
end

time = k;

%% Recherche du maximum global par Gradiant
k = 0;
while g_max - g_max_1 > tol && k < k_grad
    k = k+1;
    % Estimer la dérivée
    q_rand = q_g_max + alpha_step * (q_g_max_1 - q_g_max) * ...
        ((g_max_1 - g_max) / (norm(q_g_max - q_g_max_1)));
    % Vérification si q_rand est dedans [q_min, q_max]
    out = false;
    for i = 1:6
        if q_rand(i,1) < q_min(i,1) || q_rand(i,1) > q_max(i,1)
            out = true;
        end
    end
    if out
        alpha_step = alpha_step / 2;
        q_rand = (q_g_max_1 - q_g_max)/3 + q_g_max;
    end
    % Calculer les valeurs propres
    g_max_r = norm(CalculCoupleGravite(q_rand),1);
    if g_max_r >= g_max
        g_max_1 = g_max;
        q_g_max_1 = q_g_max;
        g_max = g_max_r;
        q_g_max = q_rand;
    else
        alpha_step = alpha_step/2;
    end
    G_b_t(time+k-1) = g_max;
    Q_max_t(:,time+k-1) = q_g_max;
end

time = time + k -1;

gb = g_max + tol;
qb = q_g_max;
%% Affichage

if affiche == true
    
    figure(1)
    VisualisationRepere(q_g_max_i, 0.05, 'i')
    hold on
    VisualisationChaine(q_g_max_i)
    hold on
    VisualisationRepere(qb, 0.05, 'f')
    hold on
    VisualisationChaine(qb)
    title(['Configuration dont ||G(q)||1 est maximal g_b = ',num2str(gb) ,...
        ' et q = [', num2str(qb(1,1)), ', ', num2str(qb(2,1)), ', ',...
        num2str(qb(3,1)), ', ', num2str(qb(4,1)), ', ', ...
        num2str(qb(5,1)), ', ', num2str(qb(6,1)), '] t'])
    hold off

    figure(2)
    plot(1:time, G_b_t(1:time));
    title('Born supérieur de ||G(q)||1 au cours des itérations')
    xlim([1 time])

    figure(3)
    subplot(6,1,1)
    for i = 1:6
        subplot(3,2,i)
        plot(1:time, ones(1,time)*q_min(i,1), 'r', 'DisplayName', 'q_{min}')
        hold on
        plot(1:time, ones(1,time)*q_max(i,1), 'm', 'DisplayName', 'q_{max}')
        plot(1:time, Q_max_t(i,1:time), 'b--', 'DisplayName', 'q_b')
        plot([k_stoq, k_stoq], [q_min(i,1), q_max(i,1)], 'k-.', 'DisplayName', 'Sthocastique vs Gradient')
        title(['Coordonnée articulaire q_', num2str(i), ' pour les born supérieur g_b'])
        ylabel(['coordonée articulaire ', num2str(i,'%1d'), ' (rad)'])
        xlabel('time (s)')
        legend()
        hold off
    end
end

end