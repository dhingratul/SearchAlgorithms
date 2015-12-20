function [n_adj] = neighbours(n)

%% Variable Declaration
r=n(1,1);
c=n(1,2);
L=[r, c-1]; 
R=[r,c+1];
T=[r-1, c];
D=[r+1,c];
bool=0;
%% Fringe conditions
    if(r==1)
        if(c==1)
            n_adj= [R; D]; bool=1;
        end
        if(c==101)
            n_adj=[L;D]; bool=1;
        end
    end
    
    
    if(r==101)
        if(c==1)
            n_adj=[T;R]; bool=1;
        end
       
         if(c==101)
            n_adj=[L;T]; bool=1;
         end
    end     
    if(r==101 && c~=1 && c~=101)
        n_adj=[L;T;R];bool=1;
    end
    
    
    if(c==101 && r~=1 && r~=101)
        n_adj=[D;L;T]; bool=1;
    end
    
    if(r==1 && c~=1 && c~=101)
        n_adj=[L;D;R]; bool=1;
    end 
     if(c==1 && r~=1 && r~=101)
        n_adj=[T;R;D]; bool=1;
     end
    if(bool==0)
        n_adj= [L; T; R; D];
    end
end
