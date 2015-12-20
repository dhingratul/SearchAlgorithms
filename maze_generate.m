function [maze,target,n_start] = maze_generate
maze = ones(101,101);
for i = 1:3000  %30 percent
maze(randi([1,101],1,1),randi([1,101],1,1))=0;
end
target = (randi([1,101],1,2) )
n_start = (randi([1,101],1,2) )
if(maze(n_start(1,1),n_start(1,2))==0)
     error('Start_node blocked. Cannot find the path')
    quit;
end
if(maze(target(1,1),target(1,2))==0)
    error('Goal blocked. Cannot find the path')
    quit;
end
end
