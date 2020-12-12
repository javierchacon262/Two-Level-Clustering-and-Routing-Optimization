function mutated = mutation(crossed, nswap)

sp = size(crossed, 1); % Tamaño de la poblacion
sc = size(crossed, 2); % Tamaño del cromosoma
mutated = zeros(sp, sc);
swapped = round(sc*nswap);
for i = 1:sp % Itera la poblacion
    mutated(i, :) = crossed(i, :);
    for j = 1:swapped
        r1 = randi(sc);
        r2 = randi(sc);
        while r2 == r1
            r2 = randi(sc);
        end
        temp = mutated(i, r1);
        mutated(i, r1) = mutated(i, r2);
        mutated(i, r2) = temp;
    end
end
end

