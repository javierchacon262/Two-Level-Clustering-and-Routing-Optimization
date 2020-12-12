function dmats = distances_calc(x, y, scli, ssat)
%distances
%   x: vector de coordenadas en x
%   y: vector de coordenadas en y
%   scli: tamaño vector cromosoma
%   ssat: tamaño vector satelites
xs = x(1:ssat+1);
ys = y(1:ssat+1);
xr = x(2:end);
yr = y(2:end);
matsc = zeros(scli+ssat);
matds = zeros(ssat+1);
for i = 1:scli+ssat
    for j = 1:scli+ssat
        matsc(i, j) = euclidean(xr(i), yr(i), xr(j), yr(j));
    end
end
for i = 1:ssat+1
    for j = 1:ssat+1
        matds(i, j) = euclidean(xs(i), ys(i), xs(j), ys(j));
    end
end
dmats.matsc = matsc;
dmats.matds = matds;
end

