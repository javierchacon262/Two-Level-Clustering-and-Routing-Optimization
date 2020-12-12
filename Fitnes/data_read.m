function [x, y, init_t, fini_t, dems, serv_t] = data_read(path)
%data_read parameters:
%   path: absolute or relative path of the data file to be readed
raw_data = xlsread(path);
x        = raw_data(:, 1);
y        = raw_data(:, 2);
init_t   = raw_data(:, 3);
fini_t   = raw_data(:, 4);
dems     = raw_data(:, 5);
serv_t   = raw_data(:, 6);
end

