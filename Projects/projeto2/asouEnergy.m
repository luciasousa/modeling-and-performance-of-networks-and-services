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

% Compute up to n paths for each flow:
n= inf;
[sP nSP]= calculatePaths(L,T,n);

tempo= 10;

%solucao random
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
    if load<=10
        energy = 0;
        for a=1:nLinks
            %loads(a,1) loads(a,2) são os nós
            %loads(a,3) loads(a,4) são valores das cargas que passam no
            %link entre os nós, nas duas direções
            if Loads(a,3)+Loads(a,4)>0 %esta a suportar trafego nao pode dormir
                energy = energy + L(Loads(a,1),Loads(a,2)); %a energia e igual a energia + o comprimento do link (L -> comprimento do link)
            end
        end
    else
        energy=inf; %garante que nao escolhe se a capacidade/carga for maior que 10 gigabits
    end
    allValues= [allValues energy];
    if energy<bestEnergy
        bestSol= sol;
        bestEnergy= energy;
    end
end

figure(1)
plot(sort(allValues));
fprintf('RANDOM:\n');
fprintf('   Best energy = %.1f\n',bestEnergy);
fprintf('   No. of solutions = %d\n',length(allValues));
fprintf('   Av. quality of solutions = %.1f\n',mean(allValues));

%solucao random 10 shortest
t= tic;
bestEnergy= inf;
sol= zeros(1,nFlows);
allValues= [];
while toc(t)<10
    for i= 1:nFlows
        n = min(10,nSP(i));
        sol(i)= randi(n);
    end
    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
    load= max(max(Loads(:,3:4)));
    if load<=10
        energy = 0;
        for a=1:nLinks
            %loads(a,1) loads(a,2) são os nós
            %loads(a,3) loads(a,4) são valores das cargas que passam no
            %link entre os nós, nas duas direções
            if Loads(a,3)+Loads(a,4)>0 %esta a suportar trafego nao pode dormir
                energy = energy + L(Loads(a,1),Loads(a,2)); %a energia e igual a energia + o comprimento do link (L -> comprimento do link)
            end
        end
    else
        energy=inf; %garante que nao escolhe se a capacidade/carga for maior que 10 gigabits
    end
    allValues= [allValues energy];
    if energy<bestEnergy
        bestSol= sol;
        bestEnergy= energy;
    end
end

hold on
plot(sort(allValues));
fprintf('RANDOM 10 SHORTEST:\n');
fprintf('   Best energy = %.1f\n',bestEnergy);
fprintf('   No. of solutions = %d\n',length(allValues));
fprintf('   Av. quality of solutions = %.1f\n',mean(allValues));

%solucao random 5 shortest
t= tic;
bestEnergy= inf;
sol= zeros(1,nFlows);
allValues= [];
while toc(t)<10
    for i= 1:nFlows
        n = min(5,nSP(i));
        sol(i)= randi(n);
    end
    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
    load= max(max(Loads(:,3:4)));
    if load<=10
        energy = 0;
        for a=1:nLinks
            %loads(a,1) loads(a,2) são os nós
            %loads(a,3) loads(a,4) são valores das cargas que passam no
            %link entre os nós, nas duas direções
            if Loads(a,3)+Loads(a,4)>0 %esta a suportar trafego nao pode dormir
                energy = energy + L(Loads(a,1),Loads(a,2)); %a energia e igual a energia + o comprimento do link (L -> comprimento do link)
            end
        end
    else
        energy=inf; %garante que nao escolhe se a capacidade/carga for maior que 10 gigabits
    end
    allValues= [allValues energy];
    if energy<bestEnergy
        bestSol= sol;
        bestEnergy= energy;
    end
end

hold on
plot(sort(allValues));
fprintf('RANDOM 5 SHORTEST:\n');
fprintf('   Best energy = %.1f\n',bestEnergy);
fprintf('   No. of solutions = %d\n',length(allValues));
fprintf('   Av. quality of solutions = %.1f\n',mean(allValues));
legend('Random', 'Random 10 shortest', 'Random 5 shortest');
title('Random algorithm');
xlabel('Number of solutions');
ylabel('Energy');
%Optimization algorithm with greedy randomized:
t= tic;
bestEnergy= inf;
allValues= [];
while toc(t)<tempo
    continuar= true;
    while continuar
        continuar= false;
        ax2= randperm(nFlows);
        sol= zeros(1,nFlows);
        for i= ax2
            k_best= 0;
            best= inf;
            for k= 1:nSP(i)
                sol(i)= k;
                Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
                load= max(max(Loads(:,3:4)));
                if load <= 10
                    energy= 0;
                    for a= 1:nLinks
                        if Loads(a,3)+Loads(a,4)>0
                            energy= energy + L(Loads(a,1),Loads(a,2));
                        end
                    end
                else
                    energy= inf;
                end
                if energy<best
                    k_best= k;
                    best= energy;
                end            
            end
            if k_best>0
                sol(i)= k_best;
            else
                continuar= true;
                break;
            end
        end
    end 
    energy= best;
    allValues= [allValues energy];
    if energy<bestEnergy
        bestSol= sol;
        bestEnergy= energy;
    end
end
figure(2)
plot(sort(allValues));
fprintf('GREEDY RANDOMIZED:\n');
fprintf('   Best energy = %.1f\n',bestEnergy);
fprintf('   No. of solutions = %d\n',length(allValues));
fprintf('   Av. quality of solutions = %.1f\n',mean(allValues));

%greedy randomized 10 shortest
t= tic;
bestEnergy= inf;
allValues= [];
while toc(t)<tempo
    continuar= true;
    while continuar
        continuar= false;
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
                if load <= 10
                    energy= 0;
                    for a= 1:nLinks
                        if Loads(a,3)+Loads(a,4)>0
                            energy= energy + L(Loads(a,1),Loads(a,2));
                        end
                    end
                else
                    energy= inf;
                end
                if energy<best
                    k_best= k;
                    best= energy;
                end            
            end
            if k_best>0
                sol(i)= k_best;
            else
                continuar= true;
                break;
            end
        end
    end 
    energy= best;
    allValues= [allValues energy];
    if energy<bestEnergy
        bestSol= sol;
        bestEnergy= energy;
    end
end
hold on
plot(sort(allValues));
fprintf('GREEDY RANDOMIZED 10 SHORTEST:\n');
fprintf('   Best energy = %.1f\n',bestEnergy);
fprintf('   No. of solutions = %d\n',length(allValues));
fprintf('   Av. quality of solutions = %.1f\n',mean(allValues));

%greedy randomized 5 shortest
t= tic;
bestEnergy= inf;
allValues= [];
while toc(t)<tempo
    continuar= true;
    while continuar
        continuar= false;
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
                if load <= 10
                    energy= 0;
                    for a= 1:nLinks
                        if Loads(a,3)+Loads(a,4)>0
                            energy= energy + L(Loads(a,1),Loads(a,2));
                        end
                    end
                else
                    energy= inf;
                end
                if energy<best
                    k_best= k;
                    best= energy;
                end            
            end
            if k_best>0
                sol(i)= k_best;
            else
                continuar= true;
                break;
            end
        end
    end 
    energy= best;
    allValues= [allValues energy];
    if energy<bestEnergy
        bestSol= sol;
        bestEnergy= energy;
    end
end
hold on
plot(sort(allValues));
fprintf('GREEDY RANDOMIZED 5 SHORTEST:\n');
fprintf('   Best energy = %.1f\n',bestEnergy);
fprintf('   No. of solutions = %d\n',length(allValues));
fprintf('   Av. quality of solutions = %.1f\n',mean(allValues));

legend('Greedy Randomized','Greedy Randomized 10 Shortest','Greedy Randomized 5 Shortest');

title('Greedy Randomized algorithm');
xlabel('Number of solutions');
ylabel('Energy');

%Optimization algorithm with multi start hill climbing:
t= tic;
bestEnergy= inf;
allValues= [];
contadortotal= [];
while toc(t)<tempo
    %GREEDY RANDOMIZED:
    continuar= true;
    while continuar
        continuar= false;
        ax2= randperm(nFlows);
        sol= zeros(1,nFlows);
        for i= ax2
            k_best= 0;
            best= inf;
            for k= 1:nSP(i)
                sol(i)= k;
                Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
                load= max(max(Loads(:,3:4)));
                if load <= 10
                    energy= 0;
                    for a= 1:nLinks
                        if Loads(a,3)+Loads(a,4)>0
                            energy= energy + L(Loads(a,1),Loads(a,2));
                        end
                    end
                else
                    energy= inf;
                end
                if energy<best
                    k_best= k;
                    best= energy;
                end            
            end
            if k_best>0
                sol(i)= k_best;
            else
                continuar= true;
                break;
            end
        end
    end 
    energy= best;
    
    %HILL CLIMBING:
    continuar= true;
    while continuar
        i_best= 0;
        k_best= 0;
        best= energy;
        for i= 1:nFlows
            for k= 1:nSP(i)
                if k~=sol(i)
                    aux= sol(i);
                    sol(i)= k;
                    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
                    load1= max(max(Loads(:,3:4)));
                    if load1 <= 10
                        energy1= 0;
                        for a= 1:nLinks
                            if Loads(a,3)+Loads(a,4)>0
                                energy1= energy1 + L(Loads(a,1),Loads(a,2));
                            end
                        end
                    else
                        energy1= inf;
                    end
                    if energy1<best
                        i_best= i;
                        k_best= k;
                        best= energy1;
                    end
                    sol(i)= aux;
                end
            end
        end
        if i_best>0
            sol(i_best)= k_best;
            energy= best;
        else
            continuar= false;
        end
    end    
    allValues= [allValues energy];
    if energy<bestEnergy
        bestSol= sol;
        bestEnergy= energy;
    end
end
figure(3)
plot(sort(allValues));
fprintf('MULTI START HILL CLIMBING:\n');
fprintf('   Best energy = %.1f\n',bestEnergy);
fprintf('   No. of solutions = %d\n',length(allValues));
fprintf('   Av. quality of solutions = %.1f\n',mean(allValues));

%10 shortest
t= tic;
bestEnergy= inf;
allValues= [];
contadortotal= [];
while toc(t)<tempo
    %GREEDY RANDOMIZED:
    continuar= true;
    while continuar
        continuar= false;
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
                if load <= 10
                    energy= 0;
                    for a= 1:nLinks
                        if Loads(a,3)+Loads(a,4)>0
                            energy= energy + L(Loads(a,1),Loads(a,2));
                        end
                    end
                else
                    energy= inf;
                end
                if energy<best
                    k_best= k;
                    best= energy;
                end            
            end
            if k_best>0
                sol(i)= k_best;
            else
                continuar= true;
                break;
            end
        end
    end 
    energy= best;
    
    %HILL CLIMBING:
    continuar= true;
    while continuar
        i_best= 0;
        k_best= 0;
        best= energy;
        for i= 1:nFlows
            n = min(10,nSP(i));
            for k= 1:n
                if k~=sol(i)
                    aux= sol(i);
                    sol(i)= k;
                    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
                    load1= max(max(Loads(:,3:4)));
                    if load1 <= 10
                        energy1= 0;
                        for a= 1:nLinks
                            if Loads(a,3)+Loads(a,4)>0
                                energy1= energy1 + L(Loads(a,1),Loads(a,2));
                            end
                        end
                    else
                        energy1= inf;
                    end
                    if energy1<best
                        i_best= i;
                        k_best= k;
                        best= energy1;
                    end
                    sol(i)= aux;
                end
            end
        end
        if i_best>0
            sol(i_best)= k_best;
            energy= best;
        else
            continuar= false;
        end
    end    
    allValues= [allValues energy];
    if energy<bestEnergy
        bestSol= sol;
        bestEnergy= energy;
    end
end
hold on
plot(sort(allValues));
fprintf('MULTI START HILL CLIMBING 10 SHORTEST:\n');
fprintf('   Best energy = %.1f\n',bestEnergy);
fprintf('   No. of solutions = %d\n',length(allValues));
fprintf('   Av. quality of solutions = %.1f\n',mean(allValues));

%5 shortest
t= tic;
bestEnergy= inf;
allValues= [];
contadortotal= [];
while toc(t)<tempo
    %GREEDY RANDOMIZED:
    continuar= true;
    while continuar
        continuar= false;
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
                if load <= 10
                    energy= 0;
                    for a= 1:nLinks
                        if Loads(a,3)+Loads(a,4)>0
                            energy= energy + L(Loads(a,1),Loads(a,2));
                        end
                    end
                else
                    energy= inf;
                end
                if energy<best
                    k_best= k;
                    best= energy;
                end            
            end
            if k_best>0
                sol(i)= k_best;
            else
                continuar= true;
                break;
            end
        end
    end 
    energy= best;
    
    %HILL CLIMBING:
    continuar= true;
    while continuar
        i_best= 0;
        k_best= 0;
        best= energy;
        for i= 1:nFlows
            n = min(5,nSP(i));
            for k= 1:n
                if k~=sol(i)
                    aux= sol(i);
                    sol(i)= k;
                    Loads= calculateLinkLoads(nNodes,Links,T,sP,sol);
                    load1= max(max(Loads(:,3:4)));
                    if load1 <= 10
                        energy1= 0;
                        for a= 1:nLinks
                            if Loads(a,3)+Loads(a,4)>0
                                energy1= energy1 + L(Loads(a,1),Loads(a,2));
                            end
                        end
                    else
                        energy1= inf;
                    end
                    if energy1<best
                        i_best= i;
                        k_best= k;
                        best= energy1;
                    end
                    sol(i)= aux;
                end
            end
        end
        if i_best>0
            sol(i_best)= k_best;
            energy= best;
        else
            continuar= false;
        end
    end    
    allValues= [allValues energy];
    if energy<bestEnergy
        bestSol= sol;
        bestEnergy= energy;
    end
end
hold on
plot(sort(allValues));
fprintf('MULTI START HILL CLIMBING 5 SHORTEST:\n');
fprintf('   Best energy = %.1f\n',bestEnergy);
fprintf('   No. of solutions = %d\n',length(allValues));
fprintf('   Av. quality of solutions = %.1f\n',mean(allValues));
legend('Hill Climbing','Hill Climbing 10 shortest','Hill Climbing 5 shortest');
title('Multi Star Hill Climbing algorithm');
xlabel('Number of solutions');
ylabel('Energy');
