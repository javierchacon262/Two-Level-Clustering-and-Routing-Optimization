function [h1, h2] = crossover_int(p1, p2)
ss    = size(p1, 2);
cont1 = 0;
cont2 = 0;
h1    = zeros(1, ss);
h2    = zeros(1, ss);
% Seleccion de los puntos de corte
for j = 1:ss
    if p1(j) == p2(j)
        cont1 = cont1 + 1;
    else
        cont2 = cont1;
        cont1 = 0;
        if cont2 >= 2
            h1(j-cont2:j-1) = p1(j-cont2:j-1);
            h2(j-cont2:j-1) = p1(j-cont2:j-1);
            cont2 = 0;
        end
    end
end
r1 = randi([1, ss-3]);
r2 = randi([3, ss]);
while r2 <= r1
    r2 = randi([3, ss]);
end
%Heredar genes de los padres en los cortes aleatorios
h1(r1:r2) = p1(r1:r2);
h2(r1:r2) = p2(r1:r2);

%Rellenado hijo 1
j = 1;
while nnz(~h1) > 0
    if ~ismember(p2(j), h1)
        k = find(~h1);
        k1 = k(1);
        h1(k1) = p2(j);
    end
    j = j + 1;
end

%Rellenado hijo 2
j = 1;
while nnz(~h2) > 0
    if ~ismember(p1(j), h2)
        k = find(~h2);
        k2 = k(1);
        h2(k2) = p1(j);
    end
    j = j + 1;
end
end