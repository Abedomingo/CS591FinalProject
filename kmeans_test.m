T = readtable('testdata.csv','NumHeaderLines',1);

X = table2array(T(:,5:17));

k = 5;

[idx,C] = kmeans(X,k);

figure;
plot3(X(idx==1,13),X(idx==1,12),X(idx==1,11),'r.','MarkerSize',12)
hold on
plot3(X(idx==2,13),X(idx==2,12),X(idx==2,11),'b.','MarkerSize',12)
plot3(X(idx==3,13),X(idx==3,12),X(idx==3,11),'g.','MarkerSize',12)
plot3(X(idx==4,13),X(idx==4,12),X(idx==4,11),'c.','MarkerSize',12)
plot3(X(idx==5,13),X(idx==5,12),X(idx==5,11),'y.','MarkerSize',12)
plot3(C(:,4),C(:,2),C(:,3),'kx',...
     'MarkerSize',15,'LineWidth',3) 
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5','Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids'
hold off