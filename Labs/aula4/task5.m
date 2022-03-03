%% 5.a

N = 10;
P=10000;
conf = 0.9;
lambda = 1800;
C = 10;
f = 1000000;
PacketLoss = zeros (1,N);
AvPacketDelay = zeros (1,N);
MaxPacketDelay = zeros (1,N);
Throughput = zeros (1,N);
for i=1:N
    [PacketLoss(i), AvPacketDelay(i), MaxPacketDelay(i), Throughput(i)] = Simulator1(lambda, C, f, P);
end
fprintf('Alinea a\n')
alfa=1-conf;
media=mean(PacketLoss);
term=norminv(1-alfa/2)*sqrt(var(PacketLoss)/N);
fprintf('Packet Loss = %.2e +- %.2e\n',media,term)
media=mean(AvPacketDelay);
term=norminv(1-alfa/2)*sqrt(var(AvPacketDelay)/N);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n',media,term)
media=mean(MaxPacketDelay);
term=norminv(1-alfa/2)*sqrt(var(MaxPacketDelay)/N);
fprintf('Max. Packet Delay (ms) = %.2e +- %.2e\n',media,term)
media=mean(Throughput);
term=norminv(1-alfa/2)*sqrt(var(Throughput)/N);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n',media,term)

%% 5.b

N = 100;
PacketLoss = zeros (1,N);
AvPacketDelay = zeros (1,N);
MaxPacketDelay = zeros (1,N);
Throughput = zeros (1,N);

for i=1:N
    [PacketLoss(i), AvPacketDelay(i), MaxPacketDelay(i), Throughput(i)] = Simulator1(lambda, C, f, P);
end
fprintf('Alinea b\n')
alfa=1-conf;
media=mean(PacketLoss);
term=norminv(1-alfa/2)*sqrt(var(PacketLoss)/N);
fprintf('Packet Loss = %.2e +- %.2e\n',media,term)
media=mean(AvPacketDelay);
term=norminv(1-alfa/2)*sqrt(var(AvPacketDelay)/N);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n',media,term)
media=mean(MaxPacketDelay);
term=norminv(1-alfa/2)*sqrt(var(MaxPacketDelay)/N);
fprintf('Max. Packet Delay (ms) = %.2e +- %.2e\n',media,term)
media=mean(Throughput);
term=norminv(1-alfa/2)*sqrt(var(Throughput)/N);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n',media,term)

% Conclusao: Para a mesma simulacao pode haver paramentros de desempenho que
% precisamos de mais simulacoes para termos um intervalo de confianca
% pequeno (mais confianca no numero obtido)
% temos de ver o intervalo de confianca para saber quantas simulacoes e
% preciso fazermos, quanto menor confianca (equivale a intervalo de erro menor), melhor
% Aqui neste caso como repetimos a simulacao mais vezes mais pequeno ficou
% o intervalo de confianca

%% 5.c

N = 100;
f= 10000;
PacketLoss = zeros (1,N);
AvPacketDelay = zeros (1,N);
MaxPacketDelay = zeros (1,N);
Throughput = zeros (1,N);

for i=1:N
    [PacketLoss(i), AvPacketDelay(i), MaxPacketDelay(i), Throughput(i)] = Simulator1(lambda, C, f, P);
end
fprintf('Alinea c\n')
alfa=1-conf;
media=mean(PacketLoss);
term=norminv(1-alfa/2)*sqrt(var(PacketLoss)/N);
fprintf('Packet Loss = %.2e +- %.2e\n',media,term)
media=mean(AvPacketDelay);
term=norminv(1-alfa/2)*sqrt(var(AvPacketDelay)/N);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n',media,term)
media=mean(MaxPacketDelay);
term=norminv(1-alfa/2)*sqrt(var(MaxPacketDelay)/N);
fprintf('Max. Packet Delay (ms) = %.2e +- %.2e\n',media,term)
media=mean(Throughput);
term=norminv(1-alfa/2)*sqrt(var(Throughput)/N);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n',media,term)

% Conclusao : temos mais pacotes perdidos, porque a fila de espera e mais
% pequena e assim ela enche mais rapidamente e os pacotes que chegam
% intertanto perdem-se porque a fila esta cheia, como a fila é mais pequena
% cada pacote tem um delay mais pequeno porque vai ter que esperar menos
% tempo na fila. Os intervalos de confianca aperta -> indica que estamos
% proximos de ter uma confianca boa da media de atraso de pacotes.
% A taxa de transferencia e mais pequena porque vai ha menos pacotes a
% serem atendidos (pacotes perdidos na fila)

%% 5.d

N = 100;
f= 2000;
PacketLoss = zeros (1,N);
AvPacketDelay = zeros (1,N);
MaxPacketDelay = zeros (1,N);
Throughput = zeros (1,N);

for i=1:N
    [PacketLoss(i), AvPacketDelay(i), MaxPacketDelay(i), Throughput(i)] = Simulator1(lambda, C, f, P);
end
fprintf('Alinea d\n')
alfa=1-conf;
media=mean(PacketLoss);
term=norminv(1-alfa/2)*sqrt(var(PacketLoss)/N);
fprintf('Packet Loss = %.2e +- %.2e\n',media,term)
media=mean(AvPacketDelay);
term=norminv(1-alfa/2)*sqrt(var(AvPacketDelay)/N);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n',media,term)
media=mean(MaxPacketDelay);
term=norminv(1-alfa/2)*sqrt(var(MaxPacketDelay)/N);
fprintf('Max. Packet Delay (ms) = %.2e +- %.2e\n',media,term)
media=mean(Throughput);
term=norminv(1-alfa/2)*sqrt(var(Throughput)/N);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n',media,term)

%Conclusao : voltamos a diminuir a fila de espera, voltou a haver mais
%pacotes perdidos, Os atrasos de transmissao diminuem pela mesma razao -> a
%espera e mais pequena na fila
% O throughput diminui porque os pacotes perdidos aumenta -> a taxa de
% transferencia e melhor pq existe menos pacotes totais (alguns sao
% perdidos na fila)

%% 5.e
lambda = 1800;
N=100;
packetSize = 64:1518;
prob = zeros(1,1518);
prob(packetSize) = (1 - 0.19 - 0.23 -0.17) / (length(packetSize)-3);
prob(64) = 0.19;
prob(110) = 0.23;
prob(1518) = 0.17;
C=10e6;
avgPacketSize = sum(prob(packetSize).*packetSize);

S = ((packetSize.*8)./C);
S_2 = S.^2;
E = sum(prob(packetSize).*S);
E_2 = sum(prob(packetSize).*S_2);
i=1:N;
u = C/(avgPacketSize*8);
Pn = ((lambda/u)^N) / sum((lambda/u).^i);
fprintf('Packet Loss = %.4f\n',Pn);
avgPacketDelay = (((lambda.*E_2) / (2*(1-lambda.*E))) + E) * 10^3;
fprintf('Av. Packet Delay = %.4f\n',avgPacketDelay);
avgThroughput = avgPacketSize*8*lambda/10^6;
fprintf('Throughput = %.4f\n',avgThroughput);
