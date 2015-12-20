function [g_s,h_star] = gs(n,gs_at_n,closelist)
start_adj= neighbours(n);
sz_c=size(closelist,1);

for k =1:size(start_adj,1) %for k = 1:4 except the k corresponding to where its parent
      if(start_adj(k,1)==closelist((sz_c-1),1)&&start_adj(k,2)==closelist((sz_c-1),2)) 
             g_s (start_adj(k,1))= 0;
             g_s (start_adj(k,2))=0;
             
      else
          g_s (start_adj(k,1), start_adj(k,2))= gs_at_n +1;
          
          
      end
end



end
