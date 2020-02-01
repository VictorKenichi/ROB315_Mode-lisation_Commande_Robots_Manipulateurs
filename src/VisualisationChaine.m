function VisualisationChaine(q, rep, n)
%%% Affiche la chaîne articulaire
% Arguments :
% q           - coordonnées articulaires
% rep         - affiche de repère ?
% n           - taille du vecteur de repères

if nargin < 1
    q = zeros(1,6);
    rep = false;
    n = 0.05;
elseif nargin < 2
    rep = false;
    n = 0.05;
elseif nargin < 3
    n = 0.05;
end

Xi = [n; 0; 0; 1];
Yi = [0; n; 0; 1];
Zi = [0; 0; n; 1];

[alpha, d, theta, r] = InitValuesTP1(q);

space1 = '   ';
space = '';

G0_E = eye(4);
p0_E = zeros(3,8);
for i=1:7
    G0_E = G0_E * CalculTransformationElem(alpha(i,1), d(i,1), theta(i,1), r(i,1));
    p0_E(1:3,i+1) = G0_E(1:3,4);
    plot3([p0_E(1,i),p0_E(1,i+1)],[p0_E(2,i),p0_E(2,i+1)],[p0_E(3,i),p0_E(3,i+1)],'c-', 'LineWidth', 2)
    hold on
    if rep && i < 7
        space = [space, space1];
        if i == 3 || i == 4
            space = ' ';
        end
        i0_E = p0_E + G0_E(1:3,:) * Xi;
        j0_E = p0_E + G0_E(1:3,:) * Yi;
        k0_E = p0_E + G0_E(1:3,:) * Zi;
        i0_E = i0_E(1:3,1);
        j0_E = j0_E(1:3,1);
        k0_E = k0_E(1:3,1);
        plot3([p0_E(1,i+1),i0_E(1,1)],[p0_E(2,i+1),i0_E(2,1)],[p0_E(3,i+1),i0_E(3,1)],'r-', 'LineWidth', 3, 'HandleVisibility', 'off');
        plot3([p0_E(1,i+1),j0_E(1,1)],[p0_E(2,i+1),j0_E(2,1)],[p0_E(3,i+1),j0_E(3,1)],'g-', 'LineWidth', 3, 'HandleVisibility', 'off');
        plot3([p0_E(1,i+1),k0_E(1,1)],[p0_E(2,i+1),k0_E(2,1)],[p0_E(3,i+1),k0_E(3,1)],'b-', 'LineWidth', 3, 'HandleVisibility', 'off');
        plot3([i0_E(1,1)],[i0_E(2,1)],[i0_E(3,1)],'rx', 'DisplayName', ['x_', num2str(i)]);
        plot3([j0_E(1,1)],[j0_E(2,1)],[j0_E(3,1)],'gv', 'DisplayName', ['y_', num2str(i)]);
        plot3([k0_E(1,1)],[k0_E(2,1)],[k0_E(3,1)],'bs', 'DisplayName', ['z_', num2str(i)]);
        plot3([p0_E(1,i+1)], [p0_E(2,i+1)], [p0_E(3,i+1)], 'ko', 'DisplayName', ' O_0');
        text([i0_E(1,1)],[i0_E(2,1)],[i0_E(3,1)], [space, 'x_', num2str(i)])
        text([j0_E(1,1)],[j0_E(2,1)],[j0_E(3,1)], [space, 'y_', num2str(i)])
        text([k0_E(1,1)],[k0_E(2,1)],[k0_E(3,1)], [space, 'z_', num2str(i)])
        text([p0_E(1,i+1)], [p0_E(2,i+1)], [p0_E(3,i+1)], [space, 'O_', num2str(i)])
    end
end

hold off

end