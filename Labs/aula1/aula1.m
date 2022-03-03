%% 1.a
p=0.60;
m=4;
r1a=p + (1 - p)/m

%% 1.b
p=0.70;
m=5;
r1b=p * m / (1 + (m - 1) * p)

%% 1.c
x= linspace(0,1,100);
m=[3 4 5];
y1=x + (1 - x)/m(1);
y2=x + (1 - x)/m(2);
y3=x + (1 - x)/m(3);
figure(1)
title('Probability of right answer')
plot(x, y1,'.', x, y2,'-', x, y3, '*')
legend('m=3', 'm=4', 'm=5')
xlabel('p')
ylabel('p + (1 - p)/m')

%% 1.d
x= linspace(0,1,100);
m=[3 4 5];
y11=(x * m(1))./ (1 + (m(1) - 1) * x);
y22=x * m(2)./ (1 + (m(2) - 1) * x);
y33=x * m(3)./ (1 + (m(3) - 1) * x);
figure(2)
title('Probability of knowing the answer')
plot(x, y11,'.', x, y22,'-', x, y33, '*')
legend('m=3', 'm=4', 'm=5')
xlabel('p')
ylabel('p * m / [1 + (m - 1) * p]')

%% 2.a
% 100 bytes without errors
n=100*8;
p=10^-2;
k=0;
f=nchoosek(n,k)
r2a=f*p^k*(1-p)^(n-k)


%% 2.b
% 1000 bytes with 1 error
n=1000*8;
p=10^-3;
k=1;
f=nchoosek(n,k);
r2b=f*p^k*(1-p)^(n-k)

%% 2.c
% 200 bytes with 1 or more errors
n=200*8;
p=10^-4;
k0=0;
f0=nchoosek(n,k0);
r2c=1-f0*p^k0*(1-p)^(n-k0)

%% 2.d
x=logspace(-8,-2);
m=[100*8 200*8 1000*8];
k=0;
f=nchoosek(x,k);
a=1;
y1=a*x.^k.*(1-x).^(m(1)-k);
y2=a*x.^k.*(1-x).^(m(2)-k);
y3=a*x.^k.*(1-x).^(m(3)-k);
figure(3)
title('Probability of packet reception without errors')
semilogx(x, y1,'.', x, y2,'-', x, y3, '*')
legend('m=100', 'm=200', 'm=1000')
xlabel('Bit Error Rate')

%% 2.e
x=linspace(64,1518,100);
m=[10^-4 10^-3 10^-2];
k=0;
f=nchoosek(x,k);
a=1;
y1=a*m(1)^k*(1-m(1)).^(x-k);
y2=a*m(2)^k*(1-m(2)).^(x-k);
y3=a*m(3)^k*(1-m(3)).^(x-k);
figure(4)
title('Probability of packet reception without errors')
semilogy(x, y1,'.', x, y2,'-', x, y3, '*')
legend('ber=1e-4', 'ber=1e-3', 'ber=1e-2')
xlabel('Packet size (Bytes)')

