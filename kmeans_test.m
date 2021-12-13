T = readtable('testdata.csv');

Labels = T.Properties.VariableNames(5:12);

X = table2array(T(:,5:12));

k = 5;

[idx,C] = kmeans(X,k);

vars = [6,7,8];

figure;
plot3(X(idx==1,vars(1)),X(idx==1,vars(2)),X(idx==1,vars(3)),'r.','MarkerSize',12)
hold on
plot3(X(idx==2,vars(1)),X(idx==2,vars(2)),X(idx==2,vars(3)),'b.','MarkerSize',12)
plot3(X(idx==3,vars(1)),X(idx==3,vars(2)),X(idx==3,vars(3)),'g.','MarkerSize',12)
plot3(X(idx==4,vars(1)),X(idx==4,vars(2)),X(idx==4,vars(3)),'c.','MarkerSize',12)
plot3(X(idx==5,vars(1)),X(idx==5,vars(2)),X(idx==5,vars(3)),'y.','MarkerSize',12)
plot3(C(:,vars(1)),C(:,vars(2)),C(:,vars(3)),'kx',...
     'MarkerSize',15,'LineWidth',3) 
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5','Centroids',...
       'Location','NW')
xlabel(Labels(vars(1)))
ylabel(Labels(vars(2)))
zlabel(Labels(vars(3)))
title 'Cluster Assignments and Centroids'
hold off

totals_bot = [0,0,0,0,0];
totals_tbt = [0,0,0,0,0];
totals_cluster = [0,0,0,0,0];

for i=1:206
    hashtag = T{i,3};
    if hashtag == "#bot"
       totals_bot(idx(i)) = totals_bot(idx(i)) + 1 
    end
    if hashtag == "#tbt"
       totals_tbt(idx(i)) = totals_tbt(idx(i)) + 1 
    end
    totals_cluster(idx(i)) = totals_cluster(idx(i)) + 1     
end    

totals_bot
totals_tbt
totals_cluster