function [av, nSol, nLoad] = BuildNeighbor(bestSol,i, sP, nSP, Links, nNodes, T)
%Find best neighbor of a given solution
%   i - flow from whom we will choose neighbors
%   bestSol - current solution 
%   sP - Contains shortest paths among network nodes for each flow
%   nSP - Contains the number of shortest paths for each flow
%   Links - Links of the network
%   nNodes - Network Nodes
%   T - Network flows
%   allValues - to store load values for plot

nFlows= size(bestSol);
nSol= bestSol;
nLoad= inf;
av= [];

for n=1:nFlows
    if n~=i
        newNeighbor= bestSol;
        for j=1:nSP(n)
            if j~=bestSol(n)
                newNeighbor(n)= j;
                nLoads= calculateLinkLoads(nNodes,Links,T,sP,newNeighbor);
                load= max(max(nLoads(:,3:4)));
                av= [av load];
                if load < nLoad
                    nSol= newNeighbor;
                    nLoad= load; 
                end
            end
        end
    end
end


end