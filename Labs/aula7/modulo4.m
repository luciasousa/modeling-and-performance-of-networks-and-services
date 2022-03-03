%% ex A

C = 10;     % Gbps

Nodes= [20 60
       250 30
       550 150
       310 100
       100 130
       580 230
       120 190
       400 220
       220 280];
   
Links= [1 2
        1 5
        2 4
        3 4
        3 6
        3 8
        4 5
        4 8
        5 7
        6 8
        7 8
        7 9
        8 9];

T= [1  3  1.0 1.0
    1  4  0.7 0.5
    2  7  3.4 2.5
    3  4  2.4 2.1
    4  9  2.0 1.4
    5  6  1.2 1.5
    5  8  2.1 2.7
    5  9  2.6 1.9];

nNodes= 9;
nLinks= size(Links,1);
nFlows= size(T,1);

B= 625;  %Average packet size in Bytes

co= Nodes(:,1)+j*Nodes(:,2);

L= inf(nNodes);    %Square matrix with arc lengths (in Km)
for i=1:nNodes
    L(i,i)= 0;
end
C= zeros(nNodes);  %Square matrix with arc capacities (in Gbps)
for i=1:nLinks
    C(Links(i,1),Links(i,2))= 10;  %Gbps
    C(Links(i,2),Links(i,1))= 10;  %Gbps
    d= abs(co(Links(i,1))-co(Links(i,2)));
    L(Links(i,1),Links(i,2))= d+5; %Km
    L(Links(i,2),Links(i,1))= d+5; %Km
end
L= round(L);  %Km

% Compute up to 100 paths for each flow:
n= 100;
[sP nSP]= calculatePaths(L,T,n);

%Compute the link loads using the first (shortest) path of each flow:
sol= ones(1,nFlows);
Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
maxLoad= max(max(Loads(:,3:4)))

%Optimization algorithm resorting to the greedy strategy:
t= tic;
bestLoad= inf;
sol= zeros(1,nFlows);
allValues= [];
while toc(t)<10
    ax2 = randperm(nFlows); % array numa ordem aleatória
    sol= zeros(1,nFlows);
    for i= ax2
        k_best = 0;
        best = inf;
        for k = 1:nSP(i)
            sol(i)= k;
            Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
            load= max(max(Loads(:,3:4)));
            if load < best
                k_best = k;
                best = load;
            end
        end
        sol(i) = k_best;
    end
    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
    load= max(max(Loads(:,3:4)));
    allValues= [allValues load];
    if load<bestLoad
        bestSol= sol;
        bestLoad= load;
    end
end
plot(sort(allValues));
bestSol
bestLoad

%Optimization algorithm resorting to the random strategy:
t= tic;
bestLoad= inf;
sol= zeros(1,nFlows);
allValues= [];
while toc(t)<10
    for i= 1:nFlows
        sol(i)= randi(nSP(i));
    end
    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
    load= max(max(Loads(:,3:4)));
    allValues= [allValues load];
    if load<bestLoad
        bestSol= sol;
        bestLoad= load;
    end
end
hold on
plot(sort(allValues));
bestSol
bestLoad

%% ex B

% greedy melhor quanto maior o problema, como só temos 8 fluxos, a
% estratégia random é melhor 
% random gere soluçoes muito más mas gere uma melhor

%% ex C

C = 10;     % Gbps

Nodes= [20 60
       250 30
       550 150
       310 100
       100 130
       580 230
       120 190
       400 220
       220 280];
   
Links= [1 2
        1 5
        2 4
        3 4
        3 6
        3 8
        4 5
        4 8
        5 7
        6 8
        7 8
        7 9
        8 9];

T= [1  3  1.0 1.0
    1  4  0.7 0.5
    2  7  3.4 2.5
    3  4  2.4 2.1
    4  9  2.0 1.4
    5  6  1.2 1.5
    5  8  2.1 2.7
    5  9  2.6 1.9];

nNodes= 9;
nLinks= size(Links,1);
nFlows= size(T,1);

B= 625;  %Average packet size in Bytes

co= Nodes(:,1)+j*Nodes(:,2);

L= inf(nNodes);    %Square matrix with arc lengths (in Km)
for i=1:nNodes
    L(i,i)= 0;
end
C= zeros(nNodes);  %Square matrix with arc capacities (in Gbps)
for i=1:nLinks
    C(Links(i,1),Links(i,2))= 10;  %Gbps
    C(Links(i,2),Links(i,1))= 10;  %Gbps
    d= abs(co(Links(i,1))-co(Links(i,2)));
    L(Links(i,1),Links(i,2))= d+5; %Km
    L(Links(i,2),Links(i,1))= d+5; %Km
end
L= round(L);  %Km

% Compute up to 100 paths for each flow:
n= 100;
[sP nSP]= calculatePaths(L,T,n);

%Compute the link loads using the first (shortest) path of each flow:
sol= ones(1,nFlows);
Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
maxLoad= max(max(Loads(:,3:4)))

%Optimization algorithm resorting to the greedy strategy:
t= tic;
bestLoad= inf;
sol= zeros(1,nFlows);
allValues= [];
while toc(t)<10
    ax2 = randperm(nFlows); % array numa ordem aleatória
    sol= zeros(1,nFlows);
    for i= ax2
        k_best = 0;
        best = inf;
        n=min(6,nSP(i));
        for k = 1:n
            sol(i)= k;
            Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
            load= max(max(Loads(:,3:4)));
            if load < best
                k_best = k;
                best = load;
            end
        end
        sol(i) = k_best;
    end
    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
    load= max(max(Loads(:,3:4)));
    allValues= [allValues load];
    if load<bestLoad
        bestSol= sol;
        bestLoad= load;
    end
end
hold on
plot(sort(allValues));
bestSol
bestLoad

%Optimization algorithm resorting to the random strategy:
t= tic;
bestLoad= inf;
sol= zeros(1,nFlows);
allValues= [];
while toc(t)<10
    for i= 1:nFlows
        n=min(6,nSP(i));
        sol(i)= randi(n);
    end
    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
    load= max(max(Loads(:,3:4)));
    allValues= [allValues load];
    if load<bestLoad
        bestSol= sol;
        bestLoad= load;
    end
end
hold on
plot(sort(allValues));
bestSol
bestLoad


%% ex D

C = 10;     % Gbps

Nodes= [20 60
       250 30
       550 150
       310 100
       100 130
       580 230
       120 190
       400 220
       220 280];
   
Links= [1 2
        1 5
        2 4
        3 4
        3 6
        3 8
        4 5
        4 8
        5 7
        6 8
        7 8
        7 9
        8 9];

T= [1  3  1.0 1.0
    1  4  0.7 0.5
    2  7  3.4 2.5
    3  4  2.4 2.1
    4  9  2.0 1.4
    5  6  1.2 1.5
    5  8  2.1 2.7
    5  9  2.6 1.9];

nNodes= 9;
nLinks= size(Links,1);
nFlows= size(T,1);

B= 625;  %Average packet size in Bytes

co= Nodes(:,1)+j*Nodes(:,2);

L= inf(nNodes);    %Square matrix with arc lengths (in Km)
for i=1:nNodes
    L(i,i)= 0;
end
C= zeros(nNodes);  %Square matrix with arc capacities (in Gbps)
for i=1:nLinks
    C(Links(i,1),Links(i,2))= 10;  %Gbps
    C(Links(i,2),Links(i,1))= 10;  %Gbps
    d= abs(co(Links(i,1))-co(Links(i,2)));
    L(Links(i,1),Links(i,2))= d+5; %Km
    L(Links(i,2),Links(i,1))= d+5; %Km
end
L= round(L);  %Km

% Compute up to 100 paths for each flow:
n= 100;
[sP nSP]= calculatePaths(L,T,n);

%Compute the link loads using the first (shortest) path of each flow:
sol= ones(1,nFlows);
Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
maxLoad= max(max(Loads(:,3:4)))

%Optimization algorithm resorting to the greedy strategy:
t= tic;
bestEnergy= inf;
sol= zeros(1,nFlows);
allValues= [];
while toc(t)<10
    ax2 = randperm(nFlows); % array numa ordem aleatória
    sol= zeros(1,nFlows);
    for i= ax2
        k_best = 0;
        best = inf;
        for k = 1:nSP(i)
            sol(i)= k;
            Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
            load= max(max(Loads(:,3:4)));
            if load <= 10
                energy = 0;
                for a=1:nLinks
                    if Loads(a,3)+Loads(a,4) > 0 %está a suportar trafego, link está ativo
                        energy = energy + L(Loads(a,1),Loads(a,2));
                    end
                end
            else
                energy = inf;
            end
            if energy<best
                k_best= k;
                best= energy;
            end
        end
        sol(i) = k_best;
    end
    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
    load= max(max(Loads(:,3:4)));
    if load <= 10
           energy = 0;
           for a=1:nLinks
               if Loads(a,3)+Loads(a,4) > 0 %está a suportar trafego, link está ativo
                   energy = energy + L(Loads(a,1),Loads(a,2));
               end
           end
    else
        energy = inf;
    end
    allValues= [allValues energy];
    if energy <bestEnergy
        bestSol= sol;
        bestEnergy= energy;
    end
end
hold on
plot(sort(allValues));
bestSol
bestEnergy

%Optimization algorithm resorting to the random strategy:
t= tic;
bestEnergy= inf;
sol= zeros(1,nFlows);
allValues= [];
while toc(t)<10
    for i= 1:nFlows
        sol(i)= randi(nSP(i));
    end
    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
    load= max(max(Loads(:,3:4)));
    if load <= 10
        energy = 0;
        for a=1:nLinks
            if Loads(a,3)+Loads(a,4) > 0 %está a suportar trafego, link está ativo
                energy = energy + L(Loads(a,1),Loads(a,2));
            end
        end
    else
        energy = inf;
    end
    allValues= [allValues energy];
    if energy<bestEnergy
        bestSol= sol;
        bestEnergy= energy;
    end
end
hold on
plot(sort(allValues));
bestSol
bestEnergy

%% ex E



%% ex F

C = 10;     % Gbps

Nodes= [20 60
       250 30
       550 150
       310 100
       100 130
       580 230
       120 190
       400 220
       220 280];
   
Links= [1 2
        1 5
        2 4
        3 4
        3 6
        3 8
        4 5
        4 8
        5 7
        6 8
        7 8
        7 9
        8 9];

T= [1  3  1.0 1.0
    1  4  0.7 0.5
    2  7  3.4 2.5
    3  4  2.4 2.1
    4  9  2.0 1.4
    5  6  1.2 1.5
    5  8  2.1 2.7
    5  9  2.6 1.9];

nNodes= 9;
nLinks= size(Links,1);
nFlows= size(T,1);

B= 625;  %Average packet size in Bytes

co= Nodes(:,1)+j*Nodes(:,2);

L= inf(nNodes);    %Square matrix with arc lengths (in Km)
for i=1:nNodes
    L(i,i)= 0;
end
C= zeros(nNodes);  %Square matrix with arc capacities (in Gbps)
for i=1:nLinks
    C(Links(i,1),Links(i,2))= 10;  %Gbps
    C(Links(i,2),Links(i,1))= 10;  %Gbps
    d= abs(co(Links(i,1))-co(Links(i,2)));
    L(Links(i,1),Links(i,2))= d+5; %Km
    L(Links(i,2),Links(i,1))= d+5; %Km
end
L= round(L);  %Km

% Compute up to 100 paths for each flow:
n= 100;
[sP nSP]= calculatePaths(L,T,n);

%Compute the link loads using the first (shortest) path of each flow:
sol= ones(1,nFlows);
Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
maxLoad= max(max(Loads(:,3:4)))

%Optimization algorithm resorting to the greedy strategy:
t= tic;
bestEnergy= inf;
sol= zeros(1,nFlows);
allValues= [];
while toc(t)<10
    ax2 = randperm(nFlows); % array numa ordem aleatória
    sol= zeros(1,nFlows);
    for i= ax2
        k_best = 0;
        best = inf;
        n=min(6,nSP(i));
        for k = 1:n
            sol(i)= k;
            Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
            load= max(max(Loads(:,3:4)));
            if load <= 10
                energy = 0;
                for a=1:nLinks
                    if Loads(a,3)+Loads(a,4) > 0 %está a suportar trafego, link está ativo
                        energy = energy + L(Loads(a,1),Loads(a,2));
                    end
                end
            else
                energy = inf;
            end
            if energy<best
                k_best= k;
                best= energy;
            end
        end
        sol(i) = k_best;
    end
    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
    load= max(max(Loads(:,3:4)));
    if load <= 10
           energy = 0;
           for a=1:nLinks
               if Loads(a,3)+Loads(a,4) > 0 %está a suportar trafego, link está ativo
                   energy = energy + L(Loads(a,1),Loads(a,2));
               end
           end
    else
        energy = inf;
    end
    allValues= [allValues energy];
    if energy <bestEnergy
        bestSol= sol;
        bestEnergy= energy;
    end
end
hold on
plot(sort(allValues));
bestSol
bestEnergy

%Optimization algorithm resorting to the random strategy:
t= tic;
bestEnergy= inf;
sol= zeros(1,nFlows);
allValues= [];
while toc(t)<10
    for i= 1:nFlows
        n=min(6,nSP(i));
        sol(i)= randi(n);
    end
    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
    load= max(max(Loads(:,3:4)));
    if load <= 10
        energy = 0;
        for a=1:nLinks
            if Loads(a,3)+Loads(a,4) > 0 %está a suportar trafego, link está ativo
                energy = energy + L(Loads(a,1),Loads(a,2));
            end
        end
    else
        energy = inf;
    end
    allValues= [allValues energy];
    if energy<bestEnergy
        bestSol= sol;
        bestEnergy= energy;
    end
end
hold on
plot(sort(allValues));
legend('greedy A', 'random A', 'greedy C', 'random C', 'greedy D', 'random D', 'greedy F', 'random F')
bestSol
bestEnergy



