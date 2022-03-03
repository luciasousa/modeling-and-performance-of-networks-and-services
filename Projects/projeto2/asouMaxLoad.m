clear all;
close all;

Nodes= [30 70
       350 40
       550 180
       310 130
       100 170
       540 290
       120 240
       400 310
       220 370
       550 380];
    
Links= [1 2
        1 5
        2 3
        2 4
        3 4
        3 6
        3 8
        4 5
        4 8
        5 7
        6 8
        6 10
        7 8
        7 9
        8 9
        9 10];

T= [1  3  1.0 1.0
    1  4  0.7 0.5
    2  7  2.4 1.5
    3  4  2.4 2.1
    4  9  1.0 2.2
    5  6  1.2 1.5
    5  8  2.1 2.5
    5  9  1.6 1.9
    6 10  1.4 1.6];

nNodes= 10;
nLinks= size(Links,1);
nFlows= size(T,1);

co= Nodes(:,1)+j*Nodes(:,2);
L= inf(nNodes);    %Square matrix with arc lengths (in Km)
for i=1:nNodes
    L(i,i)= 0;
end
for i=1:nLinks
    d= abs(co(Links(i,1))-co(Links(i,2)));
    L(Links(i,1),Links(i,2))= d+5; %Km
    L(Links(i,2),Links(i,1))= d+5; %Km
end
L= round(L);  %Km

%exercicio 1.a
% With a k-shortest path algorithm (using the lengths of the links), compute the number of
% different routing paths provided by the network to each traffic flow

% Compute up to n paths for each flow:
n= inf;
[sP nSP]= calculatePaths(L,T,n);
%sP sao os caminhos 
%nSp sao os custos dos caminhos sP

for i=1:nFlows
    fprintf('No. of different routing paths for flow %d = %d\n',i,length(sP{1,i}));
end

tempo= 10;

%exercicio 1.b
%Optimization algorithm resorting to the random strategy:
t= tic;
bestLoad= inf;
worstLoad= zeros(1,3);
sol= zeros(1,nFlows);
allValues= [];
while toc(t)<tempo
    for i= 1:nFlows
        sol(i)= randi(nSP(i));
    end
    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
    load= max(max(Loads(:,3:4)));
    allValues= [allValues load];
    if load<bestLoad
        bestSol= sol;
        bestLoad= load;
    else
        worstLoad(1)=load;
    end
end
figure(1)
plot(sort(allValues));
fprintf('RANDOM:\n');
fprintf('   Worst load = %.2f Gbps\n',worstLoad(1));
fprintf('   Best load = %.2f Gbps\n',bestLoad);
fprintf('   No. of solutions = %d\n',length(allValues));
fprintf('   Av. quality of solutions = %.2f Gbps\n',mean(allValues));

%10 shortest
t= tic;
bestLoad= inf;
worstLoad= inf;
sol= zeros(1,nFlows);
allValues= [];
while toc(t)<tempo
    for i= 1:nFlows
        n = min(10,nSP(i)); 
        sol(i)= randi(n);
    end
    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
    load= max(max(Loads(:,3:4)));
    allValues= [allValues load];
    if load<bestLoad
        bestSol= sol;
        bestLoad= load;
    else
        worstLoad(2)=load;
    end
end
hold on
plot(sort(allValues));
fprintf('RANDOM 10 SHORTEST:\n');
fprintf('   Worst load = %.2f Gbps\n',worstLoad(2));
fprintf('   Best load = %.2f Gbps\n',bestLoad);
fprintf('   No. of solutions = %d\n',length(allValues));
fprintf('   Av. quality of solutions = %.2f Gbps\n',mean(allValues));

%5 shortest
t= tic;
bestLoad= inf;
worstLoad= inf;
sol= zeros(1,nFlows);
allValues= [];
while toc(t)<tempo
    for i= 1:nFlows
        n = min(5,nSP(i));
        sol(i)= randi(n);
    end
    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
    load= max(max(Loads(:,3:4)));
    allValues= [allValues load];
    if load<bestLoad
        bestSol= sol;
        bestLoad= load;
    else
        worstLoad(3)=load;
    end
end
hold on
plot(sort(allValues));
fprintf('RANDOM 5 SHORTEST:\n');
fprintf('   Worst load = %.2f Gbps\n',worstLoad(3));
fprintf('   Best load = %.2f Gbps\n',bestLoad);
fprintf('   No. of solutions = %d\n',length(allValues));
fprintf('   Av. quality of solutions = %.2f Gbps\n',mean(allValues));
legend('Random','Random 10 shortest','Random 5 shortest');

title('Random algorithm');
xlabel('Number of solutions');
ylabel('Load (Gbps)');

figure(4)
plot(sort(worstLoad));
legend('worst load');


%exercicio 1.c
%Optimization algorithm with greedy randomized:
t= tic;
bestLoad= inf;
allValues= [];
while toc(t)<tempo
    ax2= randperm(nFlows);
    sol= zeros(1,nFlows);
    for i= ax2
        k_best= 0;
        best= inf;
        for k= 1:nSP(i)
            sol(i)= k;
            Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
            load= max(max(Loads(:,3:4)));
            if load<best
                k_best= k;
                best= load;
            end
        end
        sol(i)= k_best;
    end
    load= best;
    allValues= [allValues load];
    if load<bestLoad
        bestSol= sol;
        bestLoad= load;
    end
end
figure(2)
plot(sort(allValues));
fprintf('GREEDY RANDOMIZED:\n');
fprintf('   Best load = %.2f Gbps\n',bestLoad);
fprintf('   No. of solutions = %d\n',length(allValues));
fprintf('   Av. quality of solutions = %.2f Gbps\n',mean(allValues));

%Optimization algorithm with greedy randomized:
%10 shortest routing paths
t= tic;
bestLoad= inf;
allValues= [];
while toc(t)<tempo
    ax2= randperm(nFlows);
    sol= zeros(1,nFlows);
    for i= ax2
        k_best= 0;
        best= inf;
        n = min(10,nSP(i));
        for k= 1:n
            sol(i)= k;
            Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
            load= max(max(Loads(:,3:4)));
            if load<best
                k_best= k;
                best= load;
            end
        end
        sol(i)= k_best;
    end
    load= best;
    allValues= [allValues load];
    if load<bestLoad
        bestSol= sol;
        bestLoad= load;
    end
end
hold on
plot(sort(allValues));
fprintf('GREEDY RANDOMIZED 10 SHORTEST:\n');
fprintf('   Best load = %.2f Gbps\n',bestLoad);
fprintf('   No. of solutions = %d\n',length(allValues));
fprintf('   Av. quality of solutions = %.2f Gbps\n',mean(allValues));

%Optimization algorithm with greedy randomized:
%5 shortest routing paths
t= tic;
bestLoad= inf;
allValues= [];
while toc(t)<tempo
    ax2= randperm(nFlows);
    sol= zeros(1,nFlows);
    for i= ax2
        k_best= 0;
        best= inf;
        n = min(5,nSP(i));
        for k= 1:n
            sol(i)= k;
            Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
            load= max(max(Loads(:,3:4)));
            if load<best
                k_best= k;
                best= load;
            end
        end
        sol(i)= k_best;
    end
    load= best;
    allValues= [allValues load];
    if load<bestLoad
        bestSol= sol;
        bestLoad= load;
    end
end
hold on
plot(sort(allValues));
fprintf('GREEDY RANDOMIZED 5 SHORTEST:\n');
fprintf('   Best load = %.2f Gbps\n',bestLoad);
fprintf('   No. of solutions = %d\n',length(allValues));
fprintf('   Av. quality of solutions = %.2f Gbps\n',mean(allValues));
legend('Greedy Randomized','Greedy Randomized 10 shortest', 'Greedy Randomized 5 shortest');
title('Greedy randomized algorithm');
xlabel('Number of solutions');
ylabel('Load (Gbps)');
%Optimization algorithm with multi start hill climbing:
t= tic;
bestLoad= inf;
allValues= [];
contadortotal= [];
while toc(t)<tempo
    
    %GREEDY RANDOMIZED:
    ax2= randperm(nFlows);
    sol= zeros(1,nFlows);
    for i= ax2
        k_best= 0;
        best= inf;
        for k= 1:nSP(i)
            sol(i)= k;
            Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
            load= max(max(Loads(:,3:4)));
            if load<best
                k_best= k;
                best= load;
            end
        end
        sol(i)= k_best;
    end
    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
    load= best;
    
    %HILL CLIMBING:
    continuar= true;
    while continuar
        i_best= 0;
        k_best= 0;
        best= load;
        for i= 1:nFlows
            for k= 1:nSP(i)
                if k~=sol(i)
                    aux= sol(i);
                    sol(i)= k;
                    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
                    load1= max(max(Loads(:,3:4)));
                    if load1<best
                        i_best= i;
                        k_best= k;
                        best= load1;
                    end
                    sol(i)= aux;
                end
            end
        end
        if i_best>0
            sol(i_best)= k_best;
            load= best;
        else
            continuar= false;
        end
    end
    allValues= [allValues load];
    if load<bestLoad
        bestSol= sol;
        bestLoad= load;
    end
end
figure(3)
plot(sort(allValues));
fprintf('MULTI START HILL CLIMBING:\n');
fprintf('   Best load = %.2f Gbps\n',bestLoad);
fprintf('   No. of solutions = %d\n',length(allValues));
fprintf('   Av. quality of solutions = %.2f Gbps\n',mean(allValues));

%10 shortest
t= tic;
bestLoad= inf;
allValues= [];
contadortotal= [];
while toc(t)<tempo
    
    %GREEDY RANDOMIZED:
    ax2= randperm(nFlows);
    sol= zeros(1,nFlows);
    for i= ax2
        k_best= 0;
        best= inf;
        n = min(10,nSP(i));
        for k= 1:n
            sol(i)= k;
            Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
            load= max(max(Loads(:,3:4)));
            if load<best
                k_best= k;
                best= load;
            end
        end
        sol(i)= k_best;
    end
    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
    load= best;
    
    %HILL CLIMBING:
    continuar= true;
    while continuar
        i_best= 0;
        k_best= 0;
        best= load;
        for i= 1:nFlows
            n = min(10,nSP(i));
            for k= 1:n
                if k~=sol(i)
                    aux= sol(i);
                    sol(i)= k;
                    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
                    load1= max(max(Loads(:,3:4)));
                    if load1<best
                        i_best= i;
                        k_best= k;
                        best= load1;
                    end
                    sol(i)= aux;
                end
            end
        end
        if i_best>0
            sol(i_best)= k_best;
            load= best;
        else
            continuar= false;
        end
    end
    allValues= [allValues load];
    if load<bestLoad
        bestSol= sol;
        bestLoad= load;
    end
end
hold on
plot(sort(allValues));
fprintf('MULTI START HILL CLIMBING 10 SHORTEST:\n');
fprintf('   Best load = %.2f Gbps\n',bestLoad);
fprintf('   No. of solutions = %d\n',length(allValues));
fprintf('   Av. quality of solutions = %.2f Gbps\n',mean(allValues));

%5 shortest
t= tic;
bestLoad= inf;
allValues= [];
contadortotal= [];
while toc(t)<tempo
    
    %GREEDY RANDOMIZED:
    ax2= randperm(nFlows);
    sol= zeros(1,nFlows);
    for i= ax2
        k_best= 0;
        best= inf;
        n = min(5,nSP(i));
        for k= 1:n
            sol(i)= k;
            Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
            load= max(max(Loads(:,3:4)));
            if load<best
                k_best= k;
                best= load;
            end
        end
        sol(i)= k_best;
    end
    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
    load= best;
    
    %HILL CLIMBING:
    continuar= true;
    while continuar
        i_best= 0;
        k_best= 0;
        best= load;
        for i= 1:nFlows
            n = min(5,nSP(i));
            for k= 1:n
                if k~=sol(i)
                    aux= sol(i);
                    sol(i)= k;
                    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
                    load1= max(max(Loads(:,3:4)));
                    if load1<best
                        i_best= i;
                        k_best= k;
                        best= load1;
                    end
                    sol(i)= aux;
                end
            end
        end
        if i_best>0
            sol(i_best)= k_best;
            load= best;
        else
            continuar= false;
        end
    end
    allValues= [allValues load];
    if load<bestLoad
        bestSol= sol;
        bestLoad= load;
    end
end
hold on
plot(sort(allValues));
legend('Hill Climbing','Hill Climbing 10 shortest','Hill Climbing 5 shortest');
fprintf('MULTI START HILL CLIMBING 5 SHORTEST:\n');
fprintf('   Best load = %.2f Gbps\n',bestLoad);
fprintf('   No. of solutions = %d\n',length(allValues));
fprintf('   Av. quality of solutions = %.2f Gbps\n',mean(allValues));
title('Multi Star Hill Climbing algorithm');
xlabel('Number of solutions');
ylabel('Load (Gbps)');
