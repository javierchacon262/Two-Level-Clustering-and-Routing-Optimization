close all
clear
clc
%% Parametros de corrida:
%       npob: numero de poblacion inicial
npob = 100;
%% Lectura y limpieza de datos de la instancia:
%       x:    coordenadas en x de deposito, satelites y clientes
%       y:    coordenadas en y de deposito, satelites y clientes
%       init: tiempos de inicio de las ventanas en clientes
%       fini: tiempos de finalizacion de las ventanas en clientes
%       dems: demandas en los clientes
%       serv: tiempo de servicio en clientes
%       path: ruta de la instancia (absoluta o relativa)

path = './Data/instancia.xlsx';
[x, y, init, fini, dems, serv] = data_read(path);
init = init(init ~= 0);
fini = fini(fini ~= 0);
dems = dems(dems ~= 0);
serv = serv(serv ~= 0);

%% Generacion de poblacion inicial y matrices de distancia
%       scli: tamaño del cromosoma de clientes
%       ssat: tamaño del vector de satelites
%       sats: vector de satelites
%       pob:  matriz de cromosomas inicial (poblacion inicial)
%       matsc: matriz de distancias incluyendo satelites y clientes
%       matds: matriz de distancias incluyendo deposito y satelites

% Poblacion incial
scli     = size(init, 1);
ssat     = size(x, 1) - scli - 1;
sats     = 1:ssat;
cdep     = 300;
csat     = 70*ones(ssat, 1);
cveh2    = 50;
cveh1    = 100;
velp     = 30;
cost_t2  = 1000;
cost_t1  = 1500;
cost_s   = 500;
cost_v2  = 100;
cost_v1  = 120;
pob      = init_pob(scli, npob);

% Matrices de distancias
dmats    = distances_calc(x, y, scli, ssat);
matsc    = dmats.matsc;
matds    = dmats.matds;

%% Evaluacion inicial del problema
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
