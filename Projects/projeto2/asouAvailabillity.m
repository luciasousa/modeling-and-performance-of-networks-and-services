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

MTBF= (450*365*24)./L;
A= MTBF./(MTBF + 24);
A(isnan(A))= 0;
Alog= -log(A);

[sP1 a1 sP2 a2]= calculateDisjointPaths(Alog,T);
sum1 = 0;
sum2=0;
clc
for i= 1:nFlows
    fprintf('Flow %d:\n',i);
    fprintf('   First path: %d',sP1{i}{1}(1));
    for j= 2:length(sP1{i}{1})
        fprintf('-%d',sP1{i}{1}(j));
    end
    if ~isempty(sP2{i}{1})
        fprintf('\n   Second path: %d',sP2{i}{1}(1));
        for j= 2:length(sP2{i}{1})
            fprintf('-%d',sP2{i}{1}(j));
        end
    end
    fprintf('\n   Availability of First Path= %.5f%%\n',100*a1(i));
    sum1 = sum1 + 100*a1(i);
    if ~isempty(sP2{i}{1})
        fprintf('   Availability of Second Path= %.5f%%\n',100*a2(i));
        sum2 = sum2 + 100*a2(i);
    end
end

fprintf('\nAverage Availability of First Path= %.5f%%\n',sum1/nFlows);
fprintf('Average Availability of Second Path= %.5f%%\n',sum2/nFlows);

fprintf('\n1+1 protection:\n');
fprintf('Bandwidth on each direction of each link\n');
Loads= calculateLinkLoads1plus1(nNodes,Links,T,sP1,sP2)
fprintf('Total Bandwidth\n');
totalLoad= sum(sum(Loads(:,3:4)))

% links without enough capacity
bt = Loads(:,3);
bt_2 = Loads(:,4);

for i=1:nLinks
    if bt(i) > 10 || bt_2(i) > 10
        fprintf('Link %d without enough capacity\n',i);
    end
end

fprintf('\n1:1 protection:\n');
fprintf('Bandwidth on each direction of each link\n');
Loads= calculateLinkLoads1to1(nNodes,Links,T,sP1,sP2)
fprintf('Total Bandwidth\n');
totalLoad= sum(sum(Loads(:,3:4)))

% links without enough capacity and the highest bandwidth value required 
bt = Loads(:,3);
bt_2 = Loads(:,4);
maxLoad= max(max(Loads(:,3:4)));
for i=1:nLinks
    if bt(i) > 10 || bt_2(i) > 10
        fprintf('Link %d without enough capacity\n',i);
    end
end
fprintf('Highest Bandwidth required= %.5f\n',maxLoad);

% task 4
% For each flow, compute 10 pairs of link disjoint paths in the following way. 
% With a kshortest path algorithm, first compute the k = 10 most available routing paths provided by 
% the network to each traffic flow. Then, compute the most available path which is link
% disjoint with each of the k previous paths.

% compute 10 pairs of link disjoint paths 
% kshortest path algorithm, compute the k = 10 most available routing paths
n=10;
[sP nSP]= calculatePaths(L,T,n);

%compute the most available path which is link disjoint with each of the k previous paths
[sP1 a1 sP2 a2]= calculateDisjointPaths(L,T);

tempo = 30;

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
%routing paths of each flow (and its availability) 
%the average service availability of the best solution
%the highest required bandwidth value among all links
fprintf('MULTI START HILL CLIMBING:\n');
fprintf('   Routing Paths of each flow and availability = %.2f Gbps\n',bestLoad);
fprintf('   Av. service availability of the best solution = %.2f Gbps\n',mean(allValues));
fprintf('   Highest bandwidth = %d\n',length(allValues));