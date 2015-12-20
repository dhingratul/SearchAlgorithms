% if loop==1
% hold on;     figure(1); hold off;
% end
% if loop==2
% hold on;    figure(2); hold off;
% end
xp=route(:,1);
yp=route(:,2);
line(yp,xp,'color',[1 0 0], 'LineWidth',1.5);