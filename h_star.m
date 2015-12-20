% clear all;
% close all;
% clc;

for i=1:101
    for j=1:101
             h_adaptive(i,j)=h(i,j)+g_s_goal-g_s(i,j);
    end
end
imshow(maze); hold on;
% save h_data h_adaptive g_s_goal g_s maze n_start target loop h