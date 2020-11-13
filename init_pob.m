function pob = init_pob(scli, npob)
%init_pob:
%   scli: tama�o de los cromosomas
%   npob: cantidad de poblacion a generar

pob  = zeros(npob, scli);

for i = 1:npob
    pob(i, :) = randperm(scli);
end
end

