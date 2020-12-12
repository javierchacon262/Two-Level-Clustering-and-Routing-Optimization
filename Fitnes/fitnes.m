function [costo_l2, costo_l1] = fitnes(pob, matsc, dems, init, fini, serv, csat, cveh2, ssat, velp, cost_t2, cost_s, matds, cveh1, cost_t1, cost_v1)

costo_l2 = level2(pob, matsc, dems, init, fini, serv, csat, cveh2, ssat, velp, cost_t2, cost_s);
scost    = size(costo_l2, 1);
cost_i   = zeros([scost, 1]);
ruta_i   = [];
dems_i   = zeros([scost, 1]);
for i = 1:scost
    cost_i(i) = sum(costo_l2(i).cost);
    dems_i(i) = sum(costo_l2(i).dems);
end
costo_l1 = level1(matds, dems_i, cveh1, cost_t1, cost_v1);

end