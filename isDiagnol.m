function [boo] = isDiagnol(n1, n2)
x = [n1;n2];
dist = pdist(x,'euclidean');
if(dist>1)
    boo = 1;
else 
    boo =0;
end