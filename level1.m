function costo = level1(matds, dems, cveh1, cost_t)
%LEVEL1 Summary of this function goes here
ss               = size(dems, 1);
costo.ruta       = [0];
costo.cost       = [];
i                = 1;
vis              = [];
while i <= ss
    [dist, next] = cercano(matds, vis, costo.ruta(i)+1);
    costo.ruta   = [costo.ruta, next];
    costo.cost   = [costo.cost, dist*cost_t];
    i            = i + 1;
    vis          = [vis, costo.ruta(end)+1];
end
idx              = vis(end);
dist             = matds(idx, 1);
costo.cost       = [costo.cost, dist*cost_t];
costo.ruta       = [costo.ruta, 0];
end

