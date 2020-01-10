% Script 2 - 
function [g_0E] = CalculMGD(alpha, d, theta, r)

g_0E     = eye(4);
N        = length(alpha);
g_elemen = cell(1, N);

for i=1:N
    g_elemen{i} = CalculTransformationElem(alpha(i,1), d(i,1), theta(i,1), r(i,1));
    g_0E        = g_0E * g_element{i};
end

end
