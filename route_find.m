route=[];

k = size(closelist,1);
for p = 1:size(closelist,1)-1
%     if(closelist(k,:)==0)
%         continue
%     end
if(k>1)
      
    if(isDiagnol(closelist(k,:),closelist(k-1,:)))
        i=1;
        while(isDiagnol(closelist(k,:),closelist(k-i,:)))
%         closelist(k-i,:)=0;
        i=i+1;
        end
        route= vertcat(route,closelist(k,:));
        k = k-i;
        continue
        
    else
        route = vertcat(route,closelist(k,:));
         k = k-1;
        
    end
    
end
    
end
route(size(route,1),:)= n_start;
% for p = 1: size(closelist-1)
%     if(closelist(p,:)==0)
%         closelist(p,:)=[];
%     end
% end