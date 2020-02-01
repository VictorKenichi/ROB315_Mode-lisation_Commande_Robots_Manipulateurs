function VisualisationRepere(q, n, s)
%%% Affiche le repère de la base fixe 0 en noir et le repère du organe
%%% terminale E en vert
% Arguments :
% q           - 6x1 - coordonnées articulaires
% n           - taille du vecteur de repères
% s           - symbole de l'origin 

if nargin < 1
    q = zeros(1,6);
    n = 0.1;
    s = ' ';
elseif nargin < 2
    n = 0.1;
    s = ' ';
elseif nargin < 3
    s = ' ';
end

[alpha, d, theta, r] = InitValuesTP1(q);

g0E = CalculMGD(alpha, d, theta, r);

pE = g0E(1:3,4);

iE = [n;0;0;1];
jE = [0;n;0;1];
kE = [0;0;n;1];

i0 = g0E*iE;
j0 = g0E*jE;
k0 = g0E*kE;

% Projection du répère fixe
plot3([0,iE(1,1)],[0,iE(2,1)],[0,iE(3,1)],'r--', 'LineWidth', 3, 'HandleVisibility', 'off');
hold on
plot3([0,jE(1,1)],[0,jE(2,1)],[0,jE(3,1)],'g--', 'LineWidth', 3, 'HandleVisibility', 'off');
plot3([0,kE(1,1)],[0,kE(2,1)],[0,kE(3,1)],'b--', 'LineWidth', 3, 'HandleVisibility', 'off');
plot3([iE(1,1)],[iE(2,1)],[iE(3,1)],'rx', 'DisplayName', 'x_0');
plot3([jE(1,1)],[jE(2,1)],[jE(3,1)],'gv', 'DisplayName', 'y_0');
plot3([kE(1,1)],[kE(2,1)],[kE(3,1)],'bs', 'DisplayName', 'z_0');
plot3([0], [0], [0], 'ko', 'DisplayName', ' O_0');
text([iE(1,1)],[iE(2,1)],[iE(3,1)], '  x_0')
text([jE(1,1)],[jE(2,1)],[jE(3,1)], '  y_0')
text([kE(1,1)],[kE(2,1)],[kE(3,1)], '  z_0')
text([0], [0], [0], ' O_0')

% Projection du répère terminale
if s == 'i'
    plot3([pE(1,1),i0(1,1)],[pE(2,1),i0(2,1)],[pE(3,1),i0(3,1)],'r-', 'LineWidth', 1.8, 'HandleVisibility', 'off');
    plot3([pE(1,1),j0(1,1)],[pE(2,1),j0(2,1)],[pE(3,1),j0(3,1)],'r-', 'LineWidth', 1.8, 'HandleVisibility', 'off');
    plot3([pE(1,1),k0(1,1)],[pE(2,1),k0(2,1)],[pE(3,1),k0(3,1)],'r-', 'LineWidth', 1.8, 'HandleVisibility', 'off');
    plot3([pE(1,1)],[pE(2,1)],[pE(3,1)], 'r*', 'DisplayName', 'O_{Ei}');
    plot3([i0(1,1)],[i0(2,1)],[i0(3,1)], 'rx', 'DisplayName', 'x_{Ei}');
    plot3([j0(1,1)],[j0(2,1)],[j0(3,1)], 'rv', 'DisplayName', 'y_{Ei}');
    plot3([k0(1,1)],[k0(2,1)],[k0(3,1)], 'rs', 'DisplayName', 'z_{Ei}');
    text([pE(1,1)],[pE(2,1)],[pE(3,1)], ' O_{Ei}')
    text([i0(1,1)],[i0(2,1)],[i0(3,1)], '  x_{Ei}')
    text([j0(1,1)],[j0(2,1)],[j0(3,1)], '  y_{Ei}')
    text([k0(1,1)],[k0(2,1)],[k0(3,1)], '  z_{Ei}')
elseif s == 'f'
    plot3([pE(1,1),i0(1,1)],[pE(2,1),i0(2,1)],[pE(3,1),i0(3,1)],'g-', 'LineWidth', 1.8, 'HandleVisibility', 'off');
    plot3([pE(1,1),j0(1,1)],[pE(2,1),j0(2,1)],[pE(3,1),j0(3,1)],'g-', 'LineWidth', 1.8, 'HandleVisibility', 'off');
    plot3([pE(1,1),k0(1,1)],[pE(2,1),k0(2,1)],[pE(3,1),k0(3,1)],'g-', 'LineWidth', 1.8, 'HandleVisibility', 'off');
    plot3([pE(1,1)],[pE(2,1)],[pE(3,1)], 'g*', 'DisplayName', 'O_{Ef}');
    plot3([i0(1,1)],[i0(2,1)],[i0(3,1)], 'gx', 'DisplayName', 'x_{Ef}');
    plot3([j0(1,1)],[j0(2,1)],[j0(3,1)], 'gv', 'DisplayName', 'y_{Ef}');
    plot3([k0(1,1)],[k0(2,1)],[k0(3,1)], 'gs', 'DisplayName', 'z_{Ef}');
    text([pE(1,1)],[pE(2,1)],[pE(3,1)], ' O_{Ef}')
    text([i0(1,1)],[i0(2,1)],[i0(3,1)], '  x_{Ef}')
    text([j0(1,1)],[j0(2,1)],[j0(3,1)], '  y_{Ef}')
    text([k0(1,1)],[k0(2,1)],[k0(3,1)], '  z_{Ef}')
elseif s ~= 'n'
    plot3([pE(1,1),i0(1,1)],[pE(2,1),i0(2,1)],[pE(3,1),i0(3,1)],'k-', 'LineWidth', 1.8, 'HandleVisibility', 'off');
    plot3([pE(1,1),j0(1,1)],[pE(2,1),j0(2,1)],[pE(3,1),j0(3,1)],'k-', 'LineWidth', 1.8, 'HandleVisibility', 'off');
    plot3([pE(1,1),k0(1,1)],[pE(2,1),k0(2,1)],[pE(3,1),k0(3,1)],'k-', 'LineWidth', 1.8, 'HandleVisibility', 'off');
    plot3([pE(1,1)],[pE(2,1)],[pE(3,1)], 'ko', 'HandleVisibility', 'off');
    plot3([i0(1,1)],[i0(2,1)],[i0(3,1)], 'kx', 'HandleVisibility', 'off');
    plot3([j0(1,1)],[j0(2,1)],[j0(3,1)], 'kv', 'HandleVisibility', 'off');
    plot3([k0(1,1)],[k0(2,1)],[k0(3,1)], 'ks', 'HandleVisibility', 'off');
end
xlabel('x')
ylabel('y')
zlabel('z')
hold off

end