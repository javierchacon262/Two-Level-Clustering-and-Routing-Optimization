% Based on Roulette wheel selection
% input is an array of any real number values
% output is the selection of one of the elements marked by its index
% location
function [index] =  selection_int(arrayInput)
len = length(arrayInput);
% if input is one element then just return rightaway
if len ==1
    index =1;
    return;
end
if (~isempty(find(arrayInput<1, 1)))
    if (min(arrayInput) ~=0)
    arrayInput = 1/min(arrayInput)*arrayInput;
    else
    temp= arrayInput;
    temp(arrayInput==0) = inf;
    arrayInput = 1/min(temp)*arrayInput;
    end
end
temp = 0;
tempProb = zeros(1,len);
for i= 1:len
    tempProb(i) = temp + arrayInput(i);
    temp = tempProb(i);
end
i = fix(rand*floor(tempProb(end)))+1;
index = find(tempProb >= i, 1 );
end

