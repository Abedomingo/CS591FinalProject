totals_bot = [0,0,0,0,0];
totals_tbt = [0,0,0,0,0];
totals_btc = [0,0,0,0,0];
totals_bts = [0,0,0,0,0];
totals_covid = [0,0,0,0,0];
totals_cluster = [0,0,0,0,0];

for i=1:518
    hashtag = T{i,3};
    if hashtag == "#bot"
       totals_bot(idx(i)) = totals_bot(idx(i)) + 1; 
    end
    if hashtag == "#tbt"
       totals_tbt(idx(i)) = totals_tbt(idx(i)) + 1; 
    end
    if hashtag == "#btc"
       totals_btc(idx(i)) = totals_btc(idx(i)) + 1; 
    end
    if hashtag == "#bts"
       totals_bts(idx(i)) = totals_bts(idx(i)) + 1; 
    end
    if hashtag == "#covid"
       totals_covid(idx(i)) = totals_covid(idx(i)) + 1; 
    end
    totals_cluster(idx(i)) = totals_cluster(idx(i)) + 1;     
end    

totals_bot
totals_tbt
totals_btc
totals_bts
totals_covid
totals_cluster