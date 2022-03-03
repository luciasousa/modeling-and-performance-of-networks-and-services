%% 3.a

%considerando o 10^-2 o primeiro estado
p0=1/(1+5/1+((5/1)*(20/2))+((5/1)*(20/2)*(100/5))+((5/1)*(20/2)*(100/5)*(600/8)))
p1=(5/1)/(1+5/1+((5/1)*(20/2))+((5/1)*(20/2)*(100/5))+((5/1)*(20/2)*(100/5)*(600/8)))
%p1=p0*(5/1)
p2=((5/1)*(20/2))/(1+5/1+((5/1)*(20/2))+((5/1)*(20/2)*(100/5))+((5/1)*(20/2)*(100/5)*(600/8)))
%p2=p0*(5/1)*(20/2)
p3=((5/1)*(20/2)*(100/5))/(1+5/1+((5/1)*(20/2))+((5/1)*(20/2)*(100/5))+((5/1)*(20/2)*(100/5)*(600/8)))
%p3=p0*(5/1)*(20/2)*(100/5)
p4=((5/1)*(20/2)*(100/5)*(600/8))/(1+5/1+((5/1)*(20/2))+((5/1)*(20/2)*(100/5))+((5/1)*(20/2)*(100/5)*(600/8)))
%p4=p0*(5/1)*(20/2)*(100/5)*(600/8)

%% 3.b

%probabilidade do estado é igual ao tempo médio de permanencia em cada estado
p0=1/(1+5/1+((5/1)*(20/2))+((5/1)*(20/2)*(100/5))+((5/1)*(20/2)*(100/5)*(600/8)))
p1=p0*(5/1)
p2=p0*(5/1)*(20/2)
p3=p0*(5/1)*(20/2)*(100/5)
p4=p0*(5/1)*(20/2)*(100/5)*(600/8)

P1=1/(1+(8/600)+((8/600)*(5/100))+((8/600)*(5/100)*(2/20))+((8/600)*(5/100)*(2/20)*(1/5)))
P2=(8/600)/(1+(8/600)+((8/600)*(5/100))+((8/600)*(5/100)*(2/20))+((8/600)*(5/100)*(2/20)*(1/5)))
P3=((8/600)*(5/100))/(1+(8/600)+((8/600)*(5/100))+((8/600)*(5/100)*(2/20))+((8/600)*(5/100)*(2/20)*(1/5)))
P4=((8/600)*(5/100)*(2/20))/(1+(8/600)+((8/600)*(5/100))+((8/600)*(5/100)*(2/20))+((8/600)*(5/100)*(2/20)*(1/5)))
P5=((8/600)*(5/100)*(2/20)*(1/5))/(1+(8/600)+((8/600)*(5/100))+((8/600)*(5/100)*(2/20))+((8/600)*(5/100)*(2/20)*(1/5)))

%% 3.c

av = 10^(-6)*p4 + 10^(-5)*p3 + 10^(-4)*p2 + 10^(-3)*p1 + 10^(-2)*p0

%% 3.d

% 1/(soma dos valores de saída)
t0=(1/8)*60         % 10^-6
t1=(1/(600+5))*60   % 10^-5
t2=(1/(100+2))*60   % 10^-4
t3=(1/(20+1))*60    % 10^-3
t4=(1/5)*60         % 10^-2

%% 3.e

p_int = p0+p1
p_norm = p2+p3+p4

%% 3.f

av_int = (10^(-3)*p1 + 10^(-2)*p0) /p_int
av_norm = (10^(-6)*p4 + 10^(-5)*p3 + 10^(-4)*p2) /p_norm

%% 3.g
x = linspace(64, 1500, 500);
n=x*8;

% probabilidade de um pacote chegar com erros para P1
p = 10^-6
ac=(1*(p^0)*((1-p).^(n-0)));
e1=(1-ac)

% probabilidade de um pacote chegar com erros para P2
p = 10^-5;
ac=(1*(p^0)*((1-p).^(n-0)));
e2=(1-ac)

% probabilidade de um pacote chegar com erros para P3
p = 10^-4;
ac=(1*(p^0)*((1-p).^(n-0)));
e3=(1-ac)

% probabilidade de um pacote chegar com erros para P4
p = 10^-3;
ac=(1*(p^0)*((1-p).^(n-0)));
e4=(1-ac)

% probabilidade de um pacote chegar com erros para P5
p = 10^-2;
ac=(1*(p^0)*((1-p).^(n-0)));
e5=(1-ac)


prob=((e1*P1)+(e2*P2)+(e3*P3)+(e4*P4)+(e5*P5))

figure(1)
plot(n/8, prob)
title('Probability of at least one error')
xlabel('Packet Size (Bytes)')


%% 3.h
x = linspace(64, 1500,500);
n=x*8;

% vetores y
y1=((e1*P1)./((e1*P1)+(e2*P2)+(e3*P3)+(e4*P4)+(e5*P5)))
y2=((e2*P2)./((e1*P1)+(e2*P2)+(e3*P3)+(e4*P4)+(e5*P5)))
y3=((e3*P3)./((e1*P1)+(e2*P2)+(e3*P3)+(e4*P4)+(e5*P5)))

prob=y1+y2+y3

figure(2)
plot(x, prob, 'b-')
title('Probability of at least one error normal state')
xlabel('Packet Size (Bytes)')


%% 3.i
x = linspace(64, 1500, 500);
n=x*8;
ber = [10^(-6) 10^(-5) 10^(-4) 10^(-3) 10^(-2)]
% probabilidade de um pacote chegar sem erros para P1
p = 10^-6
ac1=(1*(p^0)*((1-p).^(n-0)));

% probabilidade de um pacote chegar sem erros para P2
p = 10^-5;
ac2=(1*(p^0)*((1-p).^(n-0)));

% probabilidade de um pacote chegar sem erros para P3
p = 10^-4;
ac3=(1*(p^0)*((1-p).^(n-0)));

% probabilidade de um pacote chegar sem erros para P4
p = 10^-3;
ac4=(1*(p^0)*((1-p).^(n-0)));

% probabilidade de um pacote chegar sem erros para P5
p = 10^-2;
ac5=(1*(p^0)*((1-p).^(n-0)));

% vetores y
% vetores y
y4=((ac4*P4)./((ac1*P1)+(ac2*P2)+(ac3*P3)+(ac4*P4)+(ac5*P5)))
y5=((ac5*P5)./((ac1*P1)+(ac2*P2)+(ac3*P3)+(ac4*P4)+(ac5*P5)))

prob=y4+y5

figure(3)
semilogy(x, prob)
title('Probability of no errors interference state')
xlabel('Packet Size (Bytes)')