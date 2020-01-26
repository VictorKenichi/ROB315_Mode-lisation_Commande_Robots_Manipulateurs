% Centre de Masse
GR1 = [0, 0, -0.25]';
GR2 = [0.35, 0, 0]';
GR3 = [0, -0.1 0]';
GR4 = [0, 0, 0]';
GR5 = [0, 0, 0]';
GR6 = [0, 0, 0]';

% Masse
m1 = 15;
m2 = 10;
m3 = 1; 
m4 = 7; 
m5 = 1;
m6 = 0.5;

% Tenseurs


for i=1:6
    Jm(i)      = 10^e-6;
    Fv(i)      = 10;
    tal_max(i) = 5;
end

Gammared(1:3) = 100;
Gammared(4:6) = 70;
