function crossed = crossover_ext(selected)
sp = size(selected, 1); %Tamaño de la poblacion
sc = size(selected, 2); %Tamaño del cromosoma
cros_idx = zeros(1, sp);
crossed = zeros(2*sp, sc);
j = 1;
for i = 1:2:sp
    % Seleccion del primer padre
    r1            = randi(sp);
    while sum(cros_idx == r1)
        r1        = randi(sp);
    end
    cros_idx(i)   = r1;
    p1            = selected(r1, :);
    crossed(j, :) = p1;
    j             = j + 1;
    
    % Seleccion del segundo padre
    r2            = randi(sp);
    while sum(cros_idx == r2)
        r2        = randi(sp);
    end
    cros_idx(i+1) = r2;
    p2            = selected(r2, :);
    crossed(j, :) = p2;
    j             = j + 1;
    
    % Generacion de los hijos
    [h1, h2]      = crossover_int(p1, p2);
    crossed(j, :) = h1;
    j             = j + 1;
    crossed(j, :) = h2;
    j             = j + 1;
end
end