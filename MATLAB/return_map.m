%Names: 
%Nicholas Barrett, Abraham Dominguez, Cheng En Ho
%This program computes the return map for the logistic map equation
%using different values of R

%Set the background color to white
set(gcf,'color','w');

%Values of R can be 2.75, 3.85, 3.95

n = 3;
R = [2.75,3.85,3.95];
h = zeros(n,1);
h2 = zeros(n,1);
colors = ['r','b','g'];
time_length = 1000;
x = zeros(n,time_length);
y = zeros(n,time_length);
for i = 1:n
    x(i,1) = 0.5;
end
for i = 1:n
    for t = 1:time_length
        y(i,t) = R(i)*x(i,t)*(1-x(i,t));
        if t ~= time_length
            x(i,t+1) = y(i,t);
        end
    end
end
for i=1:n
    subplot(2,1,1);
    h(i) = stairs(x(i,:),y(i,:),'Color',colors(i));
    title(strcat('Return Map X(t) vs. X(t+1) for R=2.75, 3.85, 3.95'));
    xlabel('x(t)');
    ylabel('x(t+1)');
    xlim([0 1]);
    ylim([0 1]);
    if i==1
        hold on;
    end
    if i==n
        legend('R=2.75','R=3.85','R=3.95','Location','northwest') 
        hold off;
    end    
end
uistack(h(1),'top');
uistack(h(3),'bottom');


%The second part of figure 3 requires us to get 
%the mean value of 100 populations with R varying 
%within a specified range

ranges = [0.5,0.1,0.1];
low_limit = [2.5,3.8, 3.9];
num_pop = 100;

R2 = zeros(n,num_pop);
for i=1:n
    R2(i,:) = ranges(i).*rand(1,num_pop) + low_limit(i);
end    
x2 = zeros(n,num_pop,time_length);
y2 = zeros(n,num_pop,time_length);
for m = 1:n
    for i = 1:num_pop
        x2(m,i,1) = 0.5;
    end
end
for m = 1:n
    for i = 1:num_pop
        for t = 1:time_length
            y2(m,i,t) = R2(m,i)*x2(m,i,t)*(1-x2(m,i,t));
            if t ~= time_length
                x2(m,i,t+1) = y2(m,i,t);
            end
        end
    end
end
xmean = zeros(n,time_length);
ymean = zeros(n,time_length);
for m = 1:n
    for t = 1:time_length
        xmean(m,t) = mean(x2(m,:,t));
        ymean(m,t) = mean(y2(m,:,t));
    end
end
for i=1:n
    subplot(2,1,2);
    h2(i) = stairs(xmean(i,:),ymean(i,:),'Color',colors(i));
    title(strcat('Return Map Xmean(t) vs. Xmean(t+1)'));
    xlabel('xmean(t)');
    ylabel('xmean(t+1)');
    xlim([0 1]);
    ylim([0 1]);
    if i==1
     hold on;
    end    
    if i==n
        hold off;
    end
end

% Indices specifying the order in which you want the legend entries to appear
uistack(h2(1),'top');
uistack(h2(2),'bottom');
labels = {'2.5<R<3','3.8<R<3.9','3.9<R<4'};
neworder = [3 2 1];
legend(h2(neworder), labels(neworder),'Location','northwest');