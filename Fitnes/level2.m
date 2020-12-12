function costo = level2(pob, matsc, dems, init, fini, serv, csat, cveh, ssat, velp, cost_t, cost_s)
%LEVEL2 Summary of this function goes here
%   Detailed explanation goes here
ssc  = size(matsc, 1);
sc   = size(pob, 2);
sp   = size(pob, 1);
ss   = ssat;
scap = csat;
vcap = cveh;
% Clustering y ruteo por demanda y capacidad
clust = [];
idx_j = 1;
costo = [];
for i = 1:ss
    
    % Clustering
    clust_i.clients = [];
    for j = idx_j:sc
        if dems(j) <= scap(i)
            clust_i.clients = [clust_i.clients, j];
            scap(i) = scap(i) - dems(j);
        else
            clust = [clust; clust_i];
            idx_j  = j;
            break;
        end
    end
    
    % Ruteo
    sr          = length(clust(i).clients);
    vcap_i      = vcap;
    cost_i.cost = []; % Costos relacionados al satelite(cluster) i
    cost_i.ruta = [0];
    cost_i.dems = [0];
    j           = 1;
    time_js     = 0;
    time_jt     = 0;
    dist_j      = 0;
    cost_j      = 0;
    while j <= sr        
        cl_j    = clust(i).clients(j);
        dem_j   = dems(cl_j);
        init_j  = init(cl_j);
        fini_j  = fini(cl_j);
        serv_j  = serv(cl_j);        
        if dem_j <= vcap_i
            
            % Ruta
            cost_i.ruta = [cost_i.ruta, cl_j];
            
            % Demanda
            cost_i.dems = [cost_i.dems, dem_j];
            
            % Restar capacida al vehiculo
            vcap_i = vcap_i - dem_j;
            
            % Calculo de la distancia al siguiente nodo j
            if j == 1
                dist_j  = matsc(i, cl_j+ss);
            else
                dist_j  = matsc(cl_j+ss-1, cl_j+ss);
            end
            
            % Calculo del tiempo de transporte al nodo j
            time_jt     = time_jt + (dist_j / velp);
            
            % Verificacion de las ventanas de tiempo
            if time_js+time_jt >= init_j && time_js+time_jt <= fini_j
                % No hay penalizacion
                time_js = time_js + serv_j;                               
            end    
            if time_js+time_jt > fini_j
                % Penalizacion por llegar despues de la ventana de tiempo
                time_js = time_js + serv_j + (0.5 * serv_j);
            end
            if time_js+time_jt < init_j
                % Penalizacion por llegar antes
                time_js = time_js + serv_j + (init_j - time_js+time_jt);
            end
            cost_j      = (time_jt * cost_t) + (time_js * cost_s);
            j           = j + 1;
        else
            cost_i.cost = [cost_i.cost, cost_j];
            cost_i.ruta = [cost_i.ruta, 0];
            cost_i.dems = [cost_i.dems, 0];
            time_js     = 0;
            time_jt     = 0;
            cost_j      = 0;
            vcap_i      = vcap;
        end        
    end
    cost_i.cost         = [cost_i.cost, cost_j];
    cost_i.ruta         = [cost_i.ruta, 0];
    cost_i.dems         = [cost_i.dems, 0];
    costo               = [costo; cost_i];
    disp(['Cluster: ', num2str(i), ' atendido con costo total igual a:', num2str(sum(cost_i.cost))])
end
end

