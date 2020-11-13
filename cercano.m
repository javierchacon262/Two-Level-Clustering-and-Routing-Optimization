function [dist, idx] = cercano(matds, vis, ci)
%NEAREST Summary of this function goes here

vec_i = matds(ci, 2:end);
%vec_i = vec_i(vec_i ~= 0);
if ~isempty(vis)
    j = 1;
    for i = 1:length(vis)
        val   = vec_i(vis(i)-j);
        vec_i = vec_i(vec_i ~= val);
    end
end
dist  = min(vec_i);
vec_i = matds(ci, 1:end);
idx   = find(vec_i == dist) - 1;
end

