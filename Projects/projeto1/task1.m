%% 1.a

N = 50;
P = 10000;
conf = 0.9;
alfa=1-conf;
C = 10;
f = 1000000;

lambda1 = 400;
PacketLoss1 = zeros (1,N);
AvPacketDelay1 = zeros (1,N);
MaxPacketDelay1 = zeros (1,N);
Throughput1 = zeros (1,N);

for i=1:N
    [PacketLoss1(i), AvPacketDelay1(i), MaxPacketDelay1(i), Throughput1(i)] = Simulator1(lambda1, C, f, P);
end
fprintf('Alinea a\n')
fprintf('\nlambda = 400\n')
media1=mean(AvPacketDelay1);
term1=norminv(1-alfa/2)*sqrt(var(AvPacketDelay1)/N);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n',media1,term1)

lambda2 = 800;
PacketLoss2 = zeros (1,N);
AvPacketDelay2 = zeros (1,N);
MaxPacketDelay2 = zeros (1,N);
Throughput2 = zeros (1,N);

for i=1:N
    [PacketLoss2(i), AvPacketDelay2(i), MaxPacketDelay2(i), Throughput2(i)] = Simulator1(lambda2, C, f, P);
end
fprintf('\nlambda = 800\n')
media2=mean(AvPacketDelay2);
term2=norminv(1-alfa/2)*sqrt(var(AvPacketDelay2)/N);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n',media2,term2)

lambda3 = 1200;
PacketLoss3 = zeros (1,N);
AvPacketDelay3 = zeros (1,N);
MaxPacketDelay3 = zeros (1,N);
Throughput3 = zeros (1,N);

for i=1:N
    [PacketLoss3(i), AvPacketDelay3(i), MaxPacketDelay3(i), Throughput3(i)] = Simulator1(lambda3, C, f, P);
end
fprintf('\nlambda = 1200\n')
media3=mean(AvPacketDelay3);
term3=norminv(1-alfa/2)*sqrt(var(AvPacketDelay3)/N);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n',media3,term3)

lambda4 = 1600;
PacketLoss4 = zeros (1,N);
AvPacketDelay4 = zeros (1,N);
MaxPacketDelay4 = zeros (1,N);
Throughput4 = zeros (1,N);

for i=1:N
    [PacketLoss4(i), AvPacketDelay4(i), MaxPacketDelay4(i), Throughput4(i)] = Simulator1(lambda4, C, f, P);
end
fprintf('\nlambda = 1600\n')
media4=mean(AvPacketDelay4);
term4=norminv(1-alfa/2)*sqrt(var(AvPacketDelay4)/N);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n',media4,term4)

lambda5 = 2000;
PacketLoss5 = zeros (1,N);
AvPacketDelay5 = zeros (1,N);
MaxPacketDelay5 = zeros (1,N);
Throughput5 = zeros (1,N);

for i=1:N
    [PacketLoss5(i), AvPacketDelay5(i), MaxPacketDelay5(i), Throughput5(i)] = Simulator1(lambda5, C, f, P);
end
fprintf('\nlambda = 2000\n')
media5=mean(AvPacketDelay5);
term5=norminv(1-alfa/2)*sqrt(var(AvPacketDelay5)/N);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n',media5,term5)

lambda = [lambda1 lambda2 lambda3 lambda4 lambda5];
avPacketDelay = [media1 media2 media3 media4 media5];
termhigh = [term1 term2 term3 term4 term5];
termlow = [-term1 -term2 -term3 -term4 -term5];

figure(1);
bar(lambda, avPacketDelay)
xlabel("Packet Rate, lambda (packets/sec)");
ylabel("Average Packet Delay (ms)");
title(" ");
grid("on");

hold on
er = errorbar(lambda, avPacketDelay, termlow, termhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';
hold off

%% 1.b

N = 50;
P = 10000;
conf = 0.9;
alfa=1-conf;
C = 10;
lambda = 1800;

f1 = 100000;
PacketLoss1 = zeros (1,N);
AvPacketDelay1 = zeros (1,N);
MaxPacketDelay1 = zeros (1,N);
Throughput1 = zeros (1,N);

for i=1:N
    [PacketLoss1(i), AvPacketDelay1(i), MaxPacketDelay1(i), Throughput1(i)] = Simulator1(lambda, C, f1, P);
end
fprintf('Alinea b\n')
fprintf('\nf = 100000\n')
media1=mean(AvPacketDelay1);
term1=norminv(1-alfa/2)*sqrt(var(AvPacketDelay1)/N);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n',media1,term1)

f2 = 20000;
PacketLoss2 = zeros (1,N);
AvPacketDelay2 = zeros (1,N);
MaxPacketDelay2 = zeros (1,N);
Throughput2 = zeros (1,N);

for i=1:N
    [PacketLoss2(i), AvPacketDelay2(i), MaxPacketDelay2(i), Throughput2(i)] = Simulator1(lambda, C, f2, P);
end
fprintf('\nf = 20000\n')
media2=mean(AvPacketDelay2);
term2=norminv(1-alfa/2)*sqrt(var(AvPacketDelay2)/N);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n',media2,term2)

f3 = 10000;
PacketLoss3 = zeros (1,N);
AvPacketDelay3 = zeros (1,N);
MaxPacketDelay3 = zeros (1,N);
Throughput3 = zeros (1,N);

for i=1:N
    [PacketLoss3(i), AvPacketDelay3(i), MaxPacketDelay3(i), Throughput3(i)] = Simulator1(lambda, C, f3, P);
end
fprintf('\nf = 10000\n')
media3=mean(AvPacketDelay3);
term3=norminv(1-alfa/2)*sqrt(var(AvPacketDelay3)/N);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n',media3,term3)

f4 = 2000;
PacketLoss4 = zeros (1,N);
AvPacketDelay4 = zeros (1,N);
MaxPacketDelay4 = zeros (1,N);
Throughput4 = zeros (1,N);

for i=1:N
    [PacketLoss4(i), AvPacketDelay4(i), MaxPacketDelay4(i), Throughput4(i)] = Simulator1(lambda, C, f4, P);
end
fprintf('\nf = 2000\n')
media4=mean(AvPacketDelay4);
term4=norminv(1-alfa/2)*sqrt(var(AvPacketDelay4)/N);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n',media4,term4)

f = [f1 f2 f3 f4];
avPacketDelay = [media1 media2 media3 media4];
termhigh = [term1 term2 term3 term4];
termlow = [-term1 -term2 -term3 -term4];

figure(2);
bar(f, avPacketDelay)
xlabel("Queue Size, f (Bytes)");
ylabel("Average Packet Delay (ms)");
title(" ");
grid("on");

hold on
er = errorbar(f, avPacketDelay, termlow, termhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';
hold off

%% 1.c

N = 50;
P = 10000;
conf = 0.9;
alfa=1-conf;
lambda = 1800;
f = 1000000;

C1 = 10;
PacketLoss1 = zeros (1,N);
AvPacketDelay1 = zeros (1,N);
MaxPacketDelay1 = zeros (1,N);
Throughput1 = zeros (1,N);

for i=1:N
    [PacketLoss1(i), AvPacketDelay1(i), MaxPacketDelay1(i), Throughput1(i)] = Simulator1(lambda, C1, f, P);
end
fprintf('Alinea c\n')
fprintf('\nC = 10\n')
media1=mean(AvPacketDelay1);
term1=norminv(1-alfa/2)*sqrt(var(AvPacketDelay1)/N);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n',media1,term1)

C2=20;
PacketLoss2 = zeros (1,N);
AvPacketDelay2 = zeros (1,N);
MaxPacketDelay2 = zeros (1,N);
Throughput2 = zeros (1,N);

for i=1:N
    [PacketLoss2(i), AvPacketDelay2(i), MaxPacketDelay2(i), Throughput2(i)] = Simulator1(lambda, C2, f, P);
end
fprintf('\nC = 20\n')
media2=mean(AvPacketDelay2);
term2=norminv(1-alfa/2)*sqrt(var(AvPacketDelay2)/N);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n',media2,term2)

C3=30;
PacketLoss3 = zeros (1,N);
AvPacketDelay3 = zeros (1,N);
MaxPacketDelay3 = zeros (1,N);
Throughput3 = zeros (1,N);

for i=1:N
    [PacketLoss3(i), AvPacketDelay3(i), MaxPacketDelay3(i), Throughput3(i)] = Simulator1(lambda, C3, f, P);
end
fprintf('\nC = 30\n')
media3=mean(AvPacketDelay3);
term3=norminv(1-alfa/2)*sqrt(var(AvPacketDelay3)/N);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n',media3,term3)

C4=40;
PacketLoss4 = zeros (1,N);
AvPacketDelay4 = zeros (1,N);
MaxPacketDelay4 = zeros (1,N);
Throughput4 = zeros (1,N);

for i=1:N
    [PacketLoss4(i), AvPacketDelay4(i), MaxPacketDelay4(i), Throughput4(i)] = Simulator1(lambda, C4, f, P);
end
fprintf('\nC = 40\n')
media4=mean(AvPacketDelay4);
term4=norminv(1-alfa/2)*sqrt(var(AvPacketDelay4)/N);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n',media4,term4)

C = [C1 C2 C3 C4];
avPacketDelay = [media1 media2 media3 media4];
termhigh = [term1 term2 term3 term4];
termlow = [-term1 -term2 -term3 -term4];

figure(3);
bar(C, avPacketDelay)
xlabel("Capacity, C (Mbps)");
ylabel("Average Packet Delay (ms)");
title(" ");
grid("on");

hold on
er = errorbar(C, avPacketDelay, termlow, termhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';
hold off

%% 1.d

N = 50;
P = 10000;
conf = 0.9;
alfa=1-conf;
lambda = 1800;
f = 1000000;

packetSize = 64:1518;
prob = zeros(1,1518);
prob(packetSize) = (1 - 0.19 - 0.23 -0.17) / (length(packetSize)-3);
prob(64) = 0.19;
prob(110) = 0.23;
prob(1518) = 0.17;
avgPacketSize = sum(prob(packetSize).*packetSize);

fprintf('\nAlinea d\n')

C1 = 10e6;
fprintf('\nC = 10\n')
S = ((packetSize.*8)./C1);
S_2 = S.^2;
E = sum(prob(packetSize).*S);
E_2 = sum(prob(packetSize).*S_2);
i=1:N;
u = C1/(avgPacketSize*8);
avgPacketDelay1 = (((lambda.*E_2) / (2*(1-lambda.*E))) + E) * 10^3;
fprintf('Av. Packet Delay = %.4f\n',avgPacketDelay1);

C2 = 20e6;
fprintf('\nC = 20\n')
S = ((packetSize.*8)./C2);
S_2 = S.^2;
E = sum(prob(packetSize).*S);
E_2 = sum(prob(packetSize).*S_2);
i=1:N;
u = C2/(avgPacketSize*8);
avgPacketDelay2 = (((lambda.*E_2) / (2*(1-lambda.*E))) + E) * 10^3;
fprintf('Av. Packet Delay = %.4f\n',avgPacketDelay2);

C3 = 30e6;
fprintf('\nC = 30\n')
S = ((packetSize.*8)./C3);
S_2 = S.^2;
E = sum(prob(packetSize).*S);
E_2 = sum(prob(packetSize).*S_2);
i=1:N;
u = C3/(avgPacketSize*8);
avgPacketDelay3 = (((lambda.*E_2) / (2*(1-lambda.*E))) + E) * 10^3;
fprintf('Av. Packet Delay = %.4f\n',avgPacketDelay3);

C4 = 40e6;
fprintf('\nC = 40\n')
S = ((packetSize.*8)./C4);
S_2 = S.^2;
E = sum(prob(packetSize).*S);
E_2 = sum(prob(packetSize).*S_2);

u = C4/(avgPacketSize*8);
avgPacketDelay4 = (((lambda.*E_2) / (2*(1-lambda.*E))) + E) * 10^3;
fprintf('Av. Packet Delay = %.4f\n',avgPacketDelay4);

avPacketDelay = [avgPacketDelay1 avgPacketDelay2 avgPacketDelay3 avgPacketDelay4];

C=[10 20 30 40];
figure(4);
bar(C, avPacketDelay)
xlabel("Capacity, C (Mbps)");
ylabel("Average Packet Delay (ms)");
title("Theorical Values");
grid("on");

hold on

hold off

%% 1.e

N = 50;
P = 10000;
conf = 0.9;
alfa=1-conf;
lambda = 1800;
f = 1000000;

C1 = 10;
PacketLoss1 = zeros (1,N);
AvPacketDelay1_64 = zeros (1,N);
AvPacketDelay1_110 = zeros (1,N);
AvPacketDelay1_1518 = zeros (1,N);
MaxPacketDelay1 = zeros (1,N);
Throughput1 = zeros (1,N);

for i=1:N
    [PacketLoss1(i), AvPacketDelay1_64(i),AvPacketDelay1_110(i), AvPacketDelay1_1518(i), MaxPacketDelay1(i), Throughput1(i)] = Simulator1_newVersion(lambda, C1, f, P);
end
fprintf('Alinea e\n')
fprintf('\nC = 10\n')
media1_64=mean(AvPacketDelay1_64);
term1_64=norminv(1-alfa/2)*sqrt(var(AvPacketDelay1_64)/N);
fprintf('Av. Packet Delay size 64 (ms) = %.2e +- %.2e\n',media1_64,term1_64)
media1_110=mean(AvPacketDelay1_110);
term1_110=norminv(1-alfa/2)*sqrt(var(AvPacketDelay1_110)/N);
fprintf('Av. Packet Delay size 110 (ms) = %.2e +- %.2e\n',media1_110,term1_110)
media1_1518=mean(AvPacketDelay1_1518);
term1_1518=norminv(1-alfa/2)*sqrt(var(AvPacketDelay1_1518)/N);
fprintf('Av. Packet Delay size 1518 (ms) = %.2e +- %.2e\n',media1_1518,term1_1518)

C2=20;
PacketLoss2 = zeros (1,N);
AvPacketDelay2_64 = zeros (1,N);
AvPacketDelay2_110 = zeros (1,N);
AvPacketDelay2_1518 = zeros (1,N);
MaxPacketDelay2 = zeros (1,N);
Throughput2 = zeros (1,N);

for i=1:N
    [PacketLoss2(i), AvPacketDelay2_64(i),AvPacketDelay2_110(i),AvPacketDelay2_1518(i), MaxPacketDelay2(i), Throughput2(i)] = Simulator1_newVersion(lambda, C2, f, P);
end
fprintf('\nC = 20\n')
media2_64=mean(AvPacketDelay2_64);
term2_64=norminv(1-alfa/2)*sqrt(var(AvPacketDelay2_64)/N);
fprintf('Av. Packet Delay size 64 (ms) = %.2e +- %.2e\n',media2_64,term2_64)
media2_110=mean(AvPacketDelay2_110);
term2_110=norminv(1-alfa/2)*sqrt(var(AvPacketDelay2_110)/N);
fprintf('Av. Packet Delay size 110 (ms) = %.2e +- %.2e\n',media2_110,term2_110)
media2_1518=mean(AvPacketDelay2_1518);
term2_1518=norminv(1-alfa/2)*sqrt(var(AvPacketDelay2_1518)/N);
fprintf('Av. Packet Delay size 1518 (ms) = %.2e +- %.2e\n',media2_1518,term2_1518)

C3=30;
PacketLoss3 = zeros (1,N);
AvPacketDelay3_64 = zeros (1,N);
AvPacketDelay3_110 = zeros (1,N);
AvPacketDelay3_1518 = zeros (1,N);
MaxPacketDelay3 = zeros (1,N);
Throughput3 = zeros (1,N);

for i=1:N
    [PacketLoss3(i), AvPacketDelay3_64(i),AvPacketDelay3_110(i),AvPacketDelay3_1518(i), MaxPacketDelay3(i), Throughput3(i)] = Simulator1_newVersion(lambda, C3, f, P);
end
fprintf('\nC = 30\n')
media3_64=mean(AvPacketDelay3_64);
term3_64=norminv(1-alfa/2)*sqrt(var(AvPacketDelay3_64)/N);
fprintf('Av. Packet Delay size 64 (ms) = %.2e +- %.2e\n',media3_64,term3_64)
media3_110=mean(AvPacketDelay3_110);
term3_110=norminv(1-alfa/2)*sqrt(var(AvPacketDelay3_110)/N);
fprintf('Av. Packet Delay size 110 (ms) = %.2e +- %.2e\n',media3_110,term3_110)
media3_1518=mean(AvPacketDelay3_1518);
term3_1518=norminv(1-alfa/2)*sqrt(var(AvPacketDelay3_1518)/N);
fprintf('Av. Packet Delay size 1518 (ms) = %.2e +- %.2e\n',media3_1518,term3_1518)

C4=40;
PacketLoss4 = zeros (1,N);
AvPacketDelay4_64 = zeros (1,N);
AvPacketDelay4_110 = zeros (1,N);
AvPacketDelay4_1518 = zeros (1,N);
MaxPacketDelay4 = zeros (1,N);
Throughput4 = zeros (1,N);

for i=1:N
    [PacketLoss4(i), AvPacketDelay4_64(i),AvPacketDelay4_110(i),AvPacketDelay4_1518(i), MaxPacketDelay4(i), Throughput4(i)] = Simulator1_newVersion(lambda, C4, f, P);
end
fprintf('\nC = 40\n')
media4_64=mean(AvPacketDelay4_64);
term4_64=norminv(1-alfa/2)*sqrt(var(AvPacketDelay4_64)/N);
fprintf('Av. Packet Delay size 64 (ms) = %.2e +- %.2e\n',media4_64,term4_64)
media4_110=mean(AvPacketDelay4_110);
term4_110=norminv(1-alfa/2)*sqrt(var(AvPacketDelay4_110)/N);
fprintf('Av. Packet Delay size 110 (ms) = %.2e +- %.2e\n',media4_110,term4_110)
media4_1518=mean(AvPacketDelay4_1518);
term4_1518=norminv(1-alfa/2)*sqrt(var(AvPacketDelay4_1518)/N);
fprintf('Av. Packet Delay size 1518 (ms) = %.2e +- %.2e\n',media4_1518,term4_1518)

C = [C1 C2 C3 C4];
avPacketDelay_64 = [media1_64 media2_64 media3_64 media4_64];
termhigh_64 = [term1_64 term2_64 term3_64 term4_64];
termlow_64 = [-term1_64 -term2_64 -term3_64 -term4_64];

figure(5);
bar(C, avPacketDelay_64)
xlabel("Capacity, C (Mbps)");
ylabel("Average Packet Delay (ms)");
ylim([0 5]);
title("Packet Size 64 Bytes");
grid("on");

hold on
er = errorbar(C, avPacketDelay_64, termlow_64, termhigh_64);
er.Color = [0 0 0];
er.LineStyle = 'none';
hold off

avPacketDelay_110 = [media1_110 media2_110 media3_110 media4_110];
termhigh_110 = [term1_110 term2_110 term3_110 term4_110];
termlow_110 = [-term1_110 -term2_110 -term3_110 -term4_110];

figure(6);
bar(C, avPacketDelay_110)
xlabel("Capacity, C (Mbps)");
ylabel("Average Packet Delay (ms)");
ylim([0 5]);
title("Packet Size 110 Bytes");
grid("on");

hold on
er = errorbar(C, avPacketDelay_110, termlow_110, termhigh_110);
er.Color = [0 0 0];
er.LineStyle = 'none';
hold off

avPacketDelay_1518 = [media1_1518 media2_1518 media3_1518 media4_1518];
termhigh_1518 = [term1_1518 term2_1518 term3_1518 term4_1518];
termlow_1518 = [-term1_1518 -term2_1518 -term3_1518 -term4_1518];

figure(7);
bar(C, avPacketDelay_1518)
xlabel("Capacity, C (Mbps)");
ylabel("Average Packet Delay (ms)");
ylim([0 5]);
title("Packet Size 1518 Bytes");
grid("on");

hold on
er = errorbar(C, avPacketDelay_1518, termlow_1518, termhigh_1518);
er.Color = [0 0 0];
er.LineStyle = 'none';
hold off

