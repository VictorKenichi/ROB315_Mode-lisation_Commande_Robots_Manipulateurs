% Script 2 - 
function [g_06, g_elemen] = CalculMGD(alpha, d, theta, r)

g_06     = eye(4);
N        = length(alpha);
g_elemen = cell(1, N);

for i=1:N
    g_elemen{i} = CalculTransformationElem(alpha(i), d(i), theta(i), r(i));
    g_06        = g_06 * g_element{i};
end

end
