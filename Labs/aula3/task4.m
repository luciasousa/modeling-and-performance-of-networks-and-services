%% 4.a
lambda = 1000;
delay = 10*10^(-6);
C=10e6;
packetSize = 64:1518;
prob = zeros(1,1518);
prob(packetSize) = (1 - 0.19 - 0.23 -0.17) / (length(packetSize)-3);
prob(64) = 0.19;
prob(110) = 0.23;
prob(1518) = 0.17;

avgPacketSize = sum(prob(packetSize).*packetSize)
avgTransmissionTime = avgPacketSize*8/C

%% 4.b
% taxa de tranferência
avgThroughput = avgPacketSize*8*lambda/10^6

%% 4.c
% 10*10^6 bits/seg -> x pacotes/seg
capacity = C/(avgPacketSize*8)

%% 4.d
S = ((packetSize.*8)./C);
S_2 = S.^2;
E = sum(prob(packetSize).*S);
E_2 = sum(prob(packetSize).*S_2);
queuingDelay = (lambda.*E_2) / (2*(1-lambda.*E))
propagationDelay = delay;
systemDelay = queuingDelay + avgTransmissionTime + propagationDelay

%% 4.e
x = 100:2000;
C = 10e6;

y = ((x.*E_2) ./ (2.*(1-x.*E))) + E;

figure(1);
plot(x,y)
title('Average system delay (seconds)')
xlabel('lambda (pps)')

%% 4.f
lambda1 = 100:2000;
lambda2 = 200:4000;
lambda3 = 1000:20000;
C1 = 10e6;
C2 = 20e6;
C3 = 100e6;

PPS1 = C1/(avgPacketSize*8);
PPS2 = C2/(avgPacketSize*8);
PPS3 = C3/(avgPacketSize*8);

PERC1 = (lambda1./PPS1) .* 100;
PERC2 = (lambda2./PPS2) .* 100;
PERC3 = (lambda3./PPS3) .* 100;

S1 = ((packetSize.*8)./C1);
S2 = ((packetSize.*8)./C2);
S3 = ((packetSize.*8)./C3);
S1_2 = S1.^2;
S2_2 = S2.^2;
S3_2 = S3.^2;
E1 = sum(prob(packetSize).*S1);
E2 = sum(prob(packetSize).*S2);
E3 = sum(prob(packetSize).*S3);
E1_2 = sum(prob(packetSize).*S1_2);
E2_2 = sum(prob(packetSize).*S2_2);
E3_2 = sum(prob(packetSize).*S3_2);

w1 = (lambda1.*E1_2) ./ (2*(1-lambda1.*E1)) + E1;
w2 = (lambda2.*E2_2) ./ (2*(1-lambda2.*E2)) + E2;
w3 = (lambda3.*E3_2) ./ (2*(1-lambda3.*E3)) + E3;

figure(2);
plot(PERC1,w1, PERC2, w2, PERC3, w3)
legend('C=10Mbps', 'C=20Mbps', 'C=100Mbps')
title('Average system delay (seconds)')
xlabel('lambda (% of the link capacity)')
