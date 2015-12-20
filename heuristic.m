function [heuristic_dist]=heuristic(target,n)
%target = (randi([1,101],1,2) );
for i= 1:101
    for j=1:101
       x= [target(1,1),target(1,2); i,j]; 
       heuristic_dist(i,j)=  pdist(x,'cityblock');
%        neighbors=[n(1,1)-1, n(1,2); n(1,1), n(1,2)+1; n(1,1)+1,n(1,2); n(1,1),n(1,2)-1]
     
    end
end
