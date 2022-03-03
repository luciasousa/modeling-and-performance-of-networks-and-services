%% 7.b

N = 100;
P=10000;
conf = 0.9;
lambda = 1800;
C = 10;
f = 1000000;
n=20;
PacketLossData = zeros (1,N);
PacketLossVoip = zeros (1,N);
AvPacketDelayData = zeros (1,N);
AvPacketDelayVoip = zeros (1,N);
MaxPacketDelayData = zeros (1,N);
MaxPacketDelayVoip = zeros (1,N);
Throughput = zeros (1,N);
for i=1:N
    [PacketLossData(i),PacketLossVoip(i), AvPacketDelayData(i), AvPacketDelayVoip(i), MaxPacketDelayData(i), MaxPacketDelayVoip(i), Throughput(i)] = Simulator3(lambda, C, f, P,n);
end
fprintf('Alinea b\n')
alfa=1-conf;
media=mean(PacketLossData);
term=norminv(1-alfa/2)*sqrt(var(PacketLossData)/N);
fprintf('Packet Loss Data= %.2e +- %.2e\n',media,term)
media=mean(PacketLossVoip);
term=norminv(1-alfa/2)*sqrt(var(PacketLossVoip)/N);
fprintf('Packet Loss Voip= %.2e +- %.2e\n',media,term)
media=mean(AvPacketDelayData);
term=norminv(1-alfa/2)*sqrt(var(AvPacketDelayData)/N);
fprintf('Av. Packet Delay Data (ms) = %.2e +- %.2e\n',media,term)
media=mean(AvPacketDelayVoip);
term=norminv(1-alfa/2)*sqrt(var(AvPacketDelayVoip)/N);
fprintf('Av. Packet Delay Voip (ms) = %.2e +- %.2e\n',media,term)
media=mean(MaxPacketDelayData);
term=norminv(1-alfa/2)*sqrt(var(MaxPacketDelayData)/N);
fprintf('Max. Packet Delay Data (ms) = %.2e +- %.2e\n',media,term)
media=mean(MaxPacketDelayVoip);
term=norminv(1-alfa/2)*sqrt(var(MaxPacketDelayVoip)/N);
fprintf('Max. Packet Delay (ms) = %.2e +- %.2e\n',media,term)
media=mean(Throughput);
term=norminv(1-alfa/2)*sqrt(var(Throughput)/N);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n',media,term)

%% 7.c

N = 100;
P=10000;
conf = 0.9;
lambda = 1800;
C = 10;
f = 10000;
n=20;
PacketLossData = zeros (1,N);
PacketLossVoip = zeros (1,N);
AvPacketDelayData = zeros (1,N);
AvPacketDelayVoip = zeros (1,N);
MaxPacketDelayData = zeros (1,N);
MaxPacketDelayVoip = zeros (1,N);
Throughput = zeros (1,N);
for i=1:N
    [PacketLossData(i),PacketLossVoip(i), AvPacketDelayData(i), AvPacketDelayVoip(i), MaxPacketDelayData(i), MaxPacketDelayVoip(i), Throughput(i)] = Simulator3(lambda, C, f, P,n);
end
fprintf('Alinea c\n')
alfa=1-conf;
media=mean(PacketLossData);
term=norminv(1-alfa/2)*sqrt(var(PacketLossData)/N);
fprintf('Packet Loss Data= %.2e +- %.2e\n',media,term)
media=mean(PacketLossVoip);
term=norminv(1-alfa/2)*sqrt(var(PacketLossVoip)/N);
fprintf('Packet Loss Voip= %.2e +- %.2e\n',media,term)
media=mean(AvPacketDelayData);
term=norminv(1-alfa/2)*sqrt(var(AvPacketDelayData)/N);
fprintf('Av. Packet Delay Data (ms) = %.2e +- %.2e\n',media,term)
media=mean(AvPacketDelayVoip);
term=norminv(1-alfa/2)*sqrt(var(AvPacketDelayVoip)/N);
fprintf('Av. Packet Delay Voip (ms) = %.2e +- %.2e\n',media,term)
media=mean(MaxPacketDelayData);
term=norminv(1-alfa/2)*sqrt(var(MaxPacketDelayData)/N);
fprintf('Max. Packet Delay Data (ms) = %.2e +- %.2e\n',media,term)
media=mean(MaxPacketDelayVoip);
term=norminv(1-alfa/2)*sqrt(var(MaxPacketDelayVoip)/N);
fprintf('Max. Packet Delay (ms) = %.2e +- %.2e\n',media,term)
media=mean(Throughput);
term=norminv(1-alfa/2)*sqrt(var(Throughput)/N);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n',media,term)

%% 7.d

N = 100;
P=10000;
conf = 0.9;
lambda = 1800;
C = 10;
f = 2000;
n=20;
PacketLossData = zeros (1,N);
PacketLossVoip = zeros (1,N);
AvPacketDelayData = zeros (1,N);
AvPacketDelayVoip = zeros (1,N);
MaxPacketDelayData = zeros (1,N);
MaxPacketDelayVoip = zeros (1,N);
Throughput = zeros (1,N);
for i=1:N
    [PacketLossData(i),PacketLossVoip(i), AvPacketDelayData(i), AvPacketDelayVoip(i), MaxPacketDelayData(i), MaxPacketDelayVoip(i), Throughput(i)] = Simulator3(lambda, C, f, P,n);
end
fprintf('Alinea d\n')
alfa=1-conf;
media=mean(PacketLossData);
term=norminv(1-alfa/2)*sqrt(var(PacketLossData)/N);
fprintf('Packet Loss Data= %.2e +- %.2e\n',media,term)
media=mean(PacketLossVoip);
term=norminv(1-alfa/2)*sqrt(var(PacketLossVoip)/N);
fprintf('Packet Loss Voip= %.2e +- %.2e\n',media,term)
media=mean(AvPacketDelayData);
term=norminv(1-alfa/2)*sqrt(var(AvPacketDelayData)/N);
fprintf('Av. Packet Delay Data (ms) = %.2e +- %.2e\n',media,term)
media=mean(AvPacketDelayVoip);
term=norminv(1-alfa/2)*sqrt(var(AvPacketDelayVoip)/N);
fprintf('Av. Packet Delay Voip (ms) = %.2e +- %.2e\n',media,term)
media=mean(MaxPacketDelayData);
term=norminv(1-alfa/2)*sqrt(var(MaxPacketDelayData)/N);
fprintf('Max. Packet Delay Data (ms) = %.2e +- %.2e\n',media,term)
media=mean(MaxPacketDelayVoip);
term=norminv(1-alfa/2)*sqrt(var(MaxPacketDelayVoip)/N);
fprintf('Max. Packet Delay (ms) = %.2e +- %.2e\n',media,term)
media=mean(Throughput);
term=norminv(1-alfa/2)*sqrt(var(Throughput)/N);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n',media,term)

%% 7.e

N = 100;
P=10000;
conf = 0.9;
lambda = 1800;
C = 10;
f = 1000000;
n=20;
PacketLossData = zeros (1,N);
PacketLossVoip = zeros (1,N);
AvPacketDelayData = zeros (1,N);
AvPacketDelayVoip = zeros (1,N);
MaxPacketDelayData = zeros (1,N);
MaxPacketDelayVoip = zeros (1,N);
Throughput = zeros (1,N);
for i=1:N
    [PacketLossData(i),PacketLossVoip(i), AvPacketDelayData(i), AvPacketDelayVoip(i), MaxPacketDelayData(i), MaxPacketDelayVoip(i), Throughput(i)] = Simulator4(lambda, C, f, P,n);
end
fprintf('Alinea e\n')
alfa=1-conf;
media=mean(PacketLossData);
term=norminv(1-alfa/2)*sqrt(var(PacketLossData)/N);
fprintf('Packet Loss Data= %.2e +- %.2e\n',media,term)
media=mean(PacketLossVoip);
term=norminv(1-alfa/2)*sqrt(var(PacketLossVoip)/N);
fprintf('Packet Loss Voip= %.2e +- %.2e\n',media,term)
media=mean(AvPacketDelayData);
term=norminv(1-alfa/2)*sqrt(var(AvPacketDelayData)/N);
fprintf('Av. Packet Delay Data (ms) = %.2e +- %.2e\n',media,term)
media=mean(AvPacketDelayVoip);
term=norminv(1-alfa/2)*sqrt(var(AvPacketDelayVoip)/N);
fprintf('Av. Packet Delay Voip (ms) = %.2e +- %.2e\n',media,term)
media=mean(MaxPacketDelayData);
term=norminv(1-alfa/2)*sqrt(var(MaxPacketDelayData)/N);
fprintf('Max. Packet Delay Data (ms) = %.2e +- %.2e\n',media,term)
media=mean(MaxPacketDelayVoip);
term=norminv(1-alfa/2)*sqrt(var(MaxPacketDelayVoip)/N);
fprintf('Max. Packet Delay (ms) = %.2e +- %.2e\n',media,term)
media=mean(Throughput);
term=norminv(1-alfa/2)*sqrt(var(Throughput)/N);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n',media,term)


%% 7.f

N = 100;
P=10000;
conf = 0.9;
lambda = 1800;
C = 10;
f = 10000;
n=20;
PacketLossData = zeros (1,N);
PacketLossVoip = zeros (1,N);
AvPacketDelayData = zeros (1,N);
AvPacketDelayVoip = zeros (1,N);
MaxPacketDelayData = zeros (1,N);
MaxPacketDelayVoip = zeros (1,N);
Throughput = zeros (1,N);
for i=1:N
    [PacketLossData(i),PacketLossVoip(i), AvPacketDelayData(i), AvPacketDelayVoip(i), MaxPacketDelayData(i), MaxPacketDelayVoip(i), Throughput(i)] = Simulator4(lambda, C, f, P,n);
end
fprintf('Alinea f\n')
alfa=1-conf;
media=mean(PacketLossData);
term=norminv(1-alfa/2)*sqrt(var(PacketLossData)/N);
fprintf('Packet Loss Data= %.2e +- %.2e\n',media,term)
media=mean(PacketLossVoip);
term=norminv(1-alfa/2)*sqrt(var(PacketLossVoip)/N);
fprintf('Packet Loss Voip= %.2e +- %.2e\n',media,term)
media=mean(AvPacketDelayData);
term=norminv(1-alfa/2)*sqrt(var(AvPacketDelayData)/N);
fprintf('Av. Packet Delay Data (ms) = %.2e +- %.2e\n',media,term)
media=mean(AvPacketDelayVoip);
term=norminv(1-alfa/2)*sqrt(var(AvPacketDelayVoip)/N);
fprintf('Av. Packet Delay Voip (ms) = %.2e +- %.2e\n',media,term)
media=mean(MaxPacketDelayData);
term=norminv(1-alfa/2)*sqrt(var(MaxPacketDelayData)/N);
fprintf('Max. Packet Delay Data (ms) = %.2e +- %.2e\n',media,term)
media=mean(MaxPacketDelayVoip);
term=norminv(1-alfa/2)*sqrt(var(MaxPacketDelayVoip)/N);
fprintf('Max. Packet Delay (ms) = %.2e +- %.2e\n',media,term)
media=mean(Throughput);
term=norminv(1-alfa/2)*sqrt(var(Throughput)/N);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n',media,term)

%% 7.g

N = 100;
P=10000;
conf = 0.9;
lambda = 1800;
C = 10;
f = 2000;
n=20;
PacketLossData = zeros (1,N);
PacketLossVoip = zeros (1,N);
AvPacketDelayData = zeros (1,N);
AvPacketDelayVoip = zeros (1,N);
MaxPacketDelayData = zeros (1,N);
MaxPacketDelayVoip = zeros (1,N);
Throughput = zeros (1,N);
for i=1:N
    [PacketLossData(i),PacketLossVoip(i), AvPacketDelayData(i), AvPacketDelayVoip(i), MaxPacketDelayData(i), MaxPacketDelayVoip(i), Throughput(i)] = Simulator4(lambda, C, f, P,n);
end
fprintf('Alinea g\n')
alfa=1-conf;
media=mean(PacketLossData);
term=norminv(1-alfa/2)*sqrt(var(PacketLossData)/N);
fprintf('Packet Loss Data= %.2e +- %.2e\n',media,term)
media=mean(PacketLossVoip);
term=norminv(1-alfa/2)*sqrt(var(PacketLossVoip)/N);
fprintf('Packet Loss Voip= %.2e +- %.2e\n',media,term)
media=mean(AvPacketDelayData);
term=norminv(1-alfa/2)*sqrt(var(AvPacketDelayData)/N);
fprintf('Av. Packet Delay Data (ms) = %.2e +- %.2e\n',media,term)
media=mean(AvPacketDelayVoip);
term=norminv(1-alfa/2)*sqrt(var(AvPacketDelayVoip)/N);
fprintf('Av. Packet Delay Voip (ms) = %.2e +- %.2e\n',media,term)
media=mean(MaxPacketDelayData);
term=norminv(1-alfa/2)*sqrt(var(MaxPacketDelayData)/N);
fprintf('Max. Packet Delay Data (ms) = %.2e +- %.2e\n',media,term)
media=mean(MaxPacketDelayVoip);
term=norminv(1-alfa/2)*sqrt(var(MaxPacketDelayVoip)/N);
fprintf('Max. Packet Delay (ms) = %.2e +- %.2e\n',media,term)
media=mean(Throughput);
term=norminv(1-alfa/2)*sqrt(var(Throughput)/N);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n',media,term)

