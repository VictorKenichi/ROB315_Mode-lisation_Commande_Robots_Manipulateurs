function VisualisationRepere(q)
%%% Affiche le repère de la base fixe 0 en noir et le repère du organe
%%% terminale E en vert
% Arguments :
% q           - coordonnées articulaires

if nargin < 1
    q = zeros(1,6);
end

[alpha, d, theta, r] = InitValuesTP1(q);

g0E = CalculMGD(alpha, d, theta, r);

pE = g0E(1:3,4);

iE = [1;0;0;1];
jE = [0;1;0;1];
kE = [0;0;1;1];

i0 = g0E*iE;
j0 = g0E*jE;
k0 = g0E*kE;

% Projection du répère fixe
plot3([0,iE(1,1)],[0,iE(2,1)],[0,iE(3,1)],'k--');
hold on
plot3([iE(1,1)],[iE(2,1)],[iE(3,1)],'kd');
plot3([0,jE(1,1)],[0,jE(2,1)],[0,jE(3,1)],'k--');
plot3([jE(1,1)],[jE(2,1)],[jE(3,1)],'kd');
plot3([0,kE(1,1)],[0,kE(2,1)],[0,kE(3,1)],'k--');
plot3([kE(1,1)],[kE(2,1)],[kE(3,1)],'kd');
plot3([0],[0],[0],'ko');

% Projection du répère terminale
plot3([pE(1,1),i0(1,1)],[pE(2,1),i0(2,1)],[pE(3,1),i0(3,1)],'g-');
plot3([i0(1,1)],[i0(2,1)],[i0(3,1)],'kx');
plot3([pE(1,1),j0(1,1)],[pE(2,1),j0(2,1)],[pE(3,1),j0(3,1)],'g-');
plot3([j0(1,1)],[j0(2,1)],[j0(3,1)],'kv');
plot3([pE(1,1),k0(1,1)],[pE(2,1),k0(2,1)],[pE(3,1),k0(3,1)],'g-');
plot3([k0(1,1)],[k0(2,1)],[k0(3,1)],'ks');
plot3([pE(1,1)],[pE(2,1)],[pE(3,1)],'ko');
xlabel('x')
ylabel('y')
zlabel('z')
hold off

end