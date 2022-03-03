%% 6.b

N = 100;
P=10000;
conf = 0.9;
lambda = 1800;
C = 10;
f = 1000000;
b=10^(-6);
PacketLoss = zeros (1,N);
AvPacketDelay = zeros (1,N);
MaxPacketDelay = zeros (1,N);
Throughput = zeros (1,N);
for i=1:N
    [PacketLoss(i), AvPacketDelay(i), MaxPacketDelay(i), Throughput(i)] = Simulator2(lambda, C, f, P,b);
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

%% 6.c

f= 10000;
PacketLoss = zeros (1,N);
AvPacketDelay = zeros (1,N);
MaxPacketDelay = zeros (1,N);
Throughput = zeros (1,N);

for i=1:N
    [PacketLoss(i), AvPacketDelay(i), MaxPacketDelay(i), Throughput(i)] = Simulator2(lambda, C, f, P, b);
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

%% 6.d

f= 2000;
PacketLoss = zeros (1,N);
AvPacketDelay = zeros (1,N);
MaxPacketDelay = zeros (1,N);
Throughput = zeros (1,N);

for i=1:N
    [PacketLoss(i), AvPacketDelay(i), MaxPacketDelay(i), Throughput(i)] = Simulator2(lambda, C, f, P, b);
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
