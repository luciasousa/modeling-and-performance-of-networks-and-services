clear all;
close all;

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

MTBF= (450*365*24)./L;
A= MTBF./(MTBF + 24);
A(isnan(A))= 0;

% Compute up to 100 paths for each flow:
%alterar calculate paths, só queremos 1 percurso, retirar n
[sP nSP]= calculatePaths(L,T);
av = ones(1,nFlows);
for i=1:nFlows
    aux = cell2mat(sP{i});
    arr = size(aux);
    for j=1:arr(1,2)-1
        av(i) = av(i) * A(aux(j),aux(j+1));
    end
end
av
%Compute the link loads using the first (shortest) path of each flow:
sol= ones(1,nFlows);
Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
maxLoad= max(max(Loads(:,3:4)))


% Compute up to 100 paths for each flow:
%alterar calculate paths, só queremos 1 percurso, retirar n
%log(A)
for i=1:nFlows
    aux = cell2mat(sP{i});
    arr = size(aux);
    for j=1:arr(1,2)-1
        A(aux(j),aux(j+1))=0.9;
    end
end

logA = -log(A)*100;

[sP2 nSP2]= calculatePaths(logA,T); %melhor disponibilidade
av2 = ones(1,nFlows);

   for i=1:nFlows
        aux2 = cell2mat(sP2{i});
        arr = size(aux2);
        for j=1:arr(1,2)-1
            av2(i) = av2(i) * A(aux2(j),aux2(j+1));
        end
    end
av2
%Compute the link loads using the first (shortest) path of each flow:
sol= ones(1,nFlows);
Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
maxLoad= max(max(Loads(:,3:4)))

%alinea C

%sP

bandwidth = zeros(1,nLinks);
bt = T(:,3);
bt_2 = T(:,4);
orig = T(:,1);
dest = T(:,2);
no1_link = Links(:,1);
no2_link = Links(:,2);
for i=1:nFlows
    aux = cell2mat(sP{i}); %caminho do fluxo i
    arr = size(aux);
    %ver origem e destino e ver qual é a bt respetivo
    origem = aux(1);
    destino = aux(arr(1,2));
    for k=1:nFlows
        if orig(k)==origem && dest(k) == destino
            capacidade = bt(k);
        end
        if orig(k)==destino && dest(k) == origem
            capacidade = bt_2(k);
        end
    end
    
    for j=1:arr(1,2)-1       %percorrer nós do fluxo i
        no1 = aux(j);
        no2 = aux(j+1);
        for m = 1:nLinks
            if (no1 == no1_link(m) && no2 == no2_link(m)) || (no1 == no2_link(m) && no2 == no1_link(m))
                bandwidth(m) = bandwidth(m) + capacidade;
            end
        end
    end
end

%sP2

bt = T(:,3);
bt_2 = T(:,4);
orig = T(:,1);
dest = T(:,2);
no1_link = Links(:,1);
no2_link = Links(:,2);
for i=1:nFlows
    aux = cell2mat(sP2{i}); %caminho do fluxo i
    arr = size(aux);
    %ver origem e destino e ver qual é a bt respetivo
    origem = aux(1);
    destino = aux(arr(1,2));
    for k=1:nFlows
        if orig(k)==origem && dest(k) == destino
            capacidade = bt(k);
        end
        if orig(k)==destino && dest(k) == origem
            capacidade = bt_2(k);
        end
    end
    
    for j=1:arr(1,2)-1       %percorrer nós do fluxo i
        no1 = aux(j);
        no2 = aux(j+1);
        for m = 1:nLinks
            if (no1 == no1_link(m) && no2 == no2_link(m)) || (no1 == no2_link(m) && no2 == no1_link(m))
                bandwidth(m) = bandwidth(m) + capacidade;
            end
        end
    end
end
bandwidth

%alinea D

%sP

bandwidth = zeros(1,nLinks);
bt = T(:,3);
bt_2 = T(:,4);
orig = T(:,1);
dest = T(:,2);
no1_link = Links(:,1);
no2_link = Links(:,2);
for i=1:nFlows
    aux = cell2mat(sP{i}); %caminho do fluxo i
    arr = size(aux);
    %ver origem e destino e ver qual é a bt respetivo
    origem = aux(1);
    destino = aux(arr(1,2));
    for k=1:nFlows
        if orig(k)==origem && dest(k) == destino
            capacidade = bt(k);
        end
        if orig(k)==destino && dest(k) == origem
            capacidade = bt_2(k);
        end
    end
    
    for j=1:arr(1,2)-1       %percorrer nós do fluxo i
        no1 = aux(j);
        no2 = aux(j+1);
        for m = 1:nLinks
            if (no1 == no1_link(m) && no2 == no2_link(m)) || (no1 == no2_link(m) && no2 == no1_link(m))
                if bandwidth(m) < capacidade
                    bandwidth(m) = capacidade;
                end
            end
        end
    end
end

%sP2

bt = T(:,3);
bt_2 = T(:,4);
orig = T(:,1);
dest = T(:,2);
no1_link = Links(:,1);
no2_link = Links(:,2);
for i=1:nFlows
    aux = cell2mat(sP2{i}); %caminho do fluxo i
    arr = size(aux);
    %ver origem e destino e ver qual é a bt respetivo
    origem = aux(1);
    destino = aux(arr(1,2));
    for k=1:nFlows
        if orig(k)==origem && dest(k) == destino
            capacidade = bt(k);
        end
        if orig(k)==destino && dest(k) == origem
            capacidade = bt_2(k);
        end
    end
    
    for j=1:arr(1,2)-1       %percorrer nós do fluxo i
        no1 = aux(j);
        no2 = aux(j+1);
        for m = 1:nLinks
            if (no1 == no1_link(m) && no2 == no2_link(m)) || (no1 == no2_link(m) && no2 == no1_link(m))
                if bandwidth(m) < capacidade
                    bandwidth(m) = capacidade;
                end
            end
        end
    end
end
bandwidth

