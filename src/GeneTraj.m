function qc = GeneTraj(qdi, qdf, t)

tf = 0.5;                         % Temps final de suivi de la trajectoire

if t < tf 
    qc = qdi + (6*(t/tf)^5 - 15*(t/tf)^4 + 10*(t/tf)^3) * (qdf - qdi);
else
    qc = qdf;
end

%qc = qdi;
end