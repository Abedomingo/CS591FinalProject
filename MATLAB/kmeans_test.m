T = readtable('testdata.csv');

Labels = ["Score","Astroturf","Fake Follower","Financial","Other","Overall",...
    "Self-declared","Spammer","Most Recent Post Time","Recent Tweets per Week",...
    "Number of Tweets","Following","Followers","Number of Likes","Vietnamese",...
    "Hindi (India)","English","Japanese","Undetermined","Chinese","Korean",...
    "Spanish","Portuguese","Turkish","Haitian","German","French","Persian",...
    "Arabic","Thai","Dutch","Italian","Bengali","Hindi"]
;

X = table2array(T(:,5:38));

k = 5;

[idx,C] = kmeans(X,k);

vars = [2,3,7];

figure;
plot3(X(idx==1,vars(1)),X(idx==1,vars(2)),X(idx==1,vars(3)),'r.','MarkerSize',12)
hold on
plot3(X(idx==2,vars(1)),X(idx==2,vars(2)),X(idx==2,vars(3)),'b.','MarkerSize',12)
plot3(X(idx==3,vars(1)),X(idx==3,vars(2)),X(idx==3,vars(3)),'g.','MarkerSize',12)
plot3(X(idx==4,vars(1)),X(idx==4,vars(2)),X(idx==4,vars(3)),'c.','MarkerSize',12)
plot3(X(idx==5,vars(1)),X(idx==5,vars(2)),X(idx==5,vars(3)),'m.','MarkerSize',12)
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
totals_btc = [0,0,0,0,0];
totals_bts = [0,0,0,0,0];
totals_covid = [0,0,0,0,0];
totals_cluster = [0,0,0,0,0];

for i=1:518
    hashtag = T{i,3};
    if hashtag == "#bot"
       totals_bot(idx(i)) = totals_bot(idx(i)) + 1 
    end
    if hashtag == "#tbt"
       totals_tbt(idx(i)) = totals_tbt(idx(i)) + 1 
    end
    if hashtag == "#btc"
       totals_btc(idx(i)) = totals_btc(idx(i)) + 1 
    end
    if hashtag == "#bts"
       totals_bts(idx(i)) = totals_bts(idx(i)) + 1 
    end
    if hashtag == "#covid"
       totals_covid(idx(i)) = totals_covid(idx(i)) + 1 
    end
    totals_cluster(idx(i)) = totals_cluster(idx(i)) + 1     
end    

totals_bot
totals_tbt
totals_btc
totals_bts
totals_covid
totals_cluster