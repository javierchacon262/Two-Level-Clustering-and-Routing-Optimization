function costo = level1(matds, dems, cveh1, cost_t, cost_v)
%LEVEL1 Summary of this function goes here

ss                      = size(dems, 1);
costo.ruta              = [0];
costo.cost              = [];
i                       = 1;
vis                     = [];
cap                     = cveh1;
vehs                    = 1;
while i <= ss
    if cap >= dems(i)
        [dist, next]    = cercano(matds, vis, costo.ruta(end)+1);
        costo.ruta      = [costo.ruta, next];
        costo.cost      = [costo.cost, dist*cost_t];
        vis             = [vis, costo.ruta(end)+1];
        cap             = cap - dems(i);
        i               = i + 1;        
    else
        cap             = cveh1;
        vehs            = vehs + 1;
        costo.ruta      = [costo.ruta, 0];
        costo.cost(i-1) = costo.cost(i-1) + (matds(i-1, 1)*cost_t);
    end
end

idx                     = costo.ruta(end);
dist                    = matds(idx+1, 1);
costo.cost              = [costo.cost, dist*cost_t];
costo.ruta              = [costo.ruta, 0];
costo.vehs              = vehs;
costo.cost              = [costo.cost, vehs*cost_v];
costo.dems              = dems;
end

