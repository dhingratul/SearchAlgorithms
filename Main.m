clear all ;close all; clc
 
%% Variable Declaration
loop=1;
% loop=2;
if(loop==2)
 
   h_star;
   clearvars -except maze n_start target h_adaptive loop 
end
% h_star;
index =[0,0];
offset_ol=[];
t=[];

%% Priority Queue Implementation
mex pq_create.cpp; 
mex pq_push.cpp; 
mex pq_pop.cpp; 
mex pq_size.cpp; 
mex pq_top.cpp;
mex pq_delete.cpp;
ol = pq_create( 10000 ); 

%% Maze generation
if(loop==1)
[maze,target,n_start]=maze_generate;
end
imshow(maze)
% set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
hold on;
tree_ptr= n_start;

n = n_start;
closelist = n_start;
openlist =[];
g_s=zeros(101,101);
discover=[];
ctr =1;

%% A* or Adaptive A* selection
if(loop==1)
[h]=heuristic(target);

end
if(loop==2)
    
    h=h_adaptive;

end

%% 
for iterator =1: 10000 % Max number of steps
    
    if(tree_ptr(size(tree_ptr,1),:)== target)
        disp('sucessful')
        break
    end
     if(openlist(:,:)==0)
         disp('cannot find a path');
         break
     end
     
        t = neighbours(n);
        if(n==n_start)
        for k= 1:size(t,1) % gs calc for starting point neighbour
        g_s(t(k,1),t(k,2))=1;
        end
        else
                   offset_gs = gs(n,g_s(n(1),n(2)),closelist);
                   offset_gs(end + 1:size(g_s, 1), end + 1:size(g_s, 1)) = 0;
                   g_s = g_s + offset_gs;
            
        end


for i=1:size(t,1)
       
       [a0,b0]= ismember(t(i,:),closelist,'rows'); % Do not add already explored members in openlist
       if(b0==0)
       
            offset_ol(i,:)= t(i,:);
       else
           offset_ol(i,:)=[0,0];
           
       end
    
end
openlist=vertcat(openlist,offset_ol); %Possible positions for agent to go
%% Priority Queue Implementation
nn=neighbours(n);
for k=1:size(nn,1)
    if(maze(nn(k,1),nn(k,2))==1)
       f_s_p(1,k)=   g_s(nn(k,1),nn(k,2)) + h(nn(k,1),nn(k,2)); 
       
       pq_push(ol, k, -f_s_p(1,k));
       
       [idx,cost] = pq_top(ol);
    newsize = pq_size(ol);
%     disp(sprintf('*** |queue| = %d, TOP=[%d,%f]', newsize, idx, cost ));
    end
end
%% Checking for blocked positions

for k=1:size(openlist,1)
    if(openlist(k,:)~=0)
        if(maze(openlist(k,1),openlist(k,2))==0)
            discover(ctr,1) = openlist(k,1);
            discover(ctr,2) = openlist(k,2);
            
            [sz_d,temp]=size(discover);
            
            d_last_row= discover(sz_d,:);
             
             ctr= ctr+1;
             [a,b]=ismember(d_last_row, discover, 'rows');
             
              
             if(b==size(discover,1))

                   g_s = zeros(101,101);
                  if( size(closelist,1)==1)
                      
                     for it1= 1:size(t,1) % gs calc for starting point neighbour
                        g_s(t(it1,1),t(it1,2))=1;
                     end
                      
                  else
                   offset_gs = gs(n,g_s(n(1),n(2)),closelist);
                   offset_gs(101*ceil(end/101),101*ceil(end/101))=0;
                   g_s = g_s + offset_gs;    % unequal size matrices add.
                  end
                 
             end

            
            
            g_s_goal=g_s(target(1),target(2));
            openlist(k,:)=0; % All blocked successors removed from the oppenlist. 
        
        
        end
        
    end
end
%% f(s): Find total cost of all remaining nodes in openlist 
for k= 4*(ceil(index(1)/4))+1: size(openlist,1)
    if(openlist(k,:)~=0)
         f_s(1,k)=   g_s(openlist(k,1),openlist(k,2)) + h(openlist(k,1),openlist(k,2));
    end

end                                                                   
%% Removing element with min f(s) from the openlist, EXPLORE and adding it to closedlist

f_s(f_s ==0) = NaN;
index=find(f_s==min(f_s)); % found minimum f_s corresponding element in openlist
f_s(index(1))=NaN;
%added min element to closelist
tree_ptr = vertcat(tree_ptr, openlist(index(1),:));
closelist = vertcat(closelist,openlist(index(1),:));

%remove minimum elememt from openlist
openlist(index(1),:) =0;

sz=size(closelist);
tree_ptr = vertcat(tree_ptr,closelist(sz(1),:) );
n = closelist(sz(1),:);


end

%% Drawing the path
route_find;
lindraw;

%%Debug
% for k = size(tree_ptr,1):size(tree_ptr,2)
%    maze(tree_ptr(k,1), tree_ptr(k,2)) = 0.5;
% end
% %%
% end

save maze g_s g_s_goal maze n_start target loop h