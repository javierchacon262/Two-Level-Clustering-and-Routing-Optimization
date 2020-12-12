function selected2 = selection_ext(pob, nsel)
sp           = size(pob, 1);
sc           = size(pob, 2);
idx          = 1:sp;
nselected    = round(sp*nsel);
selected     = [];
for i = 1:nselected
    sel_i    = selection_int(idx);
    selected = [selected, sel_i];
end
selected2    = pob(selected, :);
end

