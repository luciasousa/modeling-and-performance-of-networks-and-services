clear all;
close all;

%localizacao de cada no
Nodes= [20 60
       250 30
       550 150
       310 100
       100 130
       580 230
       120 190
       400 220
       220 280];

%ligacoes dos nos
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

%no origem - no destino - debito binario da origem para o destino - debito
%binario do destino para a origem
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
    %capacidade ou carga do link na pode ser maior que os 10 gigabits por segundo
    C(Links(i,1),Links(i,2))= 10;  %Gbps
    C(Links(i,2),Links(i,1))= 10;  %Gbps
    d= abs(co(Links(i,1))-co(Links(i,2)));
    %matriz L da nos o tamanho do link
    L(Links(i,1),Links(i,2))= d+5; %Km
    L(Links(i,2),Links(i,1))= d+5; %Km
end
L= round(L);  %Km

% Compute up to 100 paths for each flow:
n= 100;
[sP nSP]= calculatePaths(L,T,n); 
%sP sao os caminhos e o nSp sao os custos dos caminhos sP

%Compute the link loads using the first (shortest) path of each flow:
sol= ones(1,nFlows);
Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
maxLoad= max(max(Loads(:,3:4)))

%Multi Start Hill Climbing Heuristic:
t= tic;
bestLoad= inf;
sol= zeros(1,nFlows);
bestSol= inf;
nSol=inf;
sol_neig= zeros(1,nFlows);
allValues= [];
av= [];
nLoad=inf;
while toc(t)<10
    [allValues,bestSol,bestLoad] = greedyRandomizedLoads(nFlows,nSP, nNodes, Links, T, sP);
    [av, nSol, nLoad] = BuildNeighbor(bestSol,i, sP, nSP, Links, nNodes, T);
end

%traco azul
figure(1)
plot(sort(allValues));
title("Random and Greedy")
bestSol
bestLoad

