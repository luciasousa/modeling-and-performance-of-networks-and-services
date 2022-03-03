function [PLd, PLv , APDd , APDv, MPDd, MPDv , TT] = Simulator4(lambda,C,f,P,n)
% INPUT PARAMETERS:
%  lambda - packet rate (packets/sec)
%  C      - link bandwidth (Mbps)
%  f      - queue size (Bytes)
%  P      - number of packets (stopping criterium)
%  n      - number of VoIP packet flows
% OUTPUT PARAMETERS:
%  PLdata   - packet loss of data packets (%)
%  PLvoip   - packet loss of VoIP packets (%)
%  APDdata  - average delay of data packets (milliseconds)
%  APDvoip  - average delay of VoIP packets (milliseconds)
%  MPDdata  - maximum delay of data packets (milliseconds)
%  MPDvoip  - maximum delay of voip packets (milliseconds)
%  TT   - transmitted throughput (Mbps)

%Events:
ARRIVAL= 0;       % Arrival of a packet            
DEPARTURE= 1;     % Departure of a packet

%State variables:
STATE = 0;          % 0 - connection free; 1 - connection bysy
QUEUEOCCUPATION= 0; % Occupation of the queue (in Bytes)
QUEUE= [];          % Size and arriving time instant of each packet in the queue

%Statistical Counters:
TOTALDATAPACKETS= 0;       % No. of data packets arrived to the system
TOTALVOIPPACKETS= 0;       % No. of voip packets arrived to the system
LOSTDATAPACKETS= 0;        % No. of data packets dropped due to buffer overflow
LOSTVOIPPACKETS= 0;        % No. of voip packets dropped due to buffer overflow
TRANSMITTEDDATAPACKETS= 0; % No. of transmitted data packets
TRANSMITTEDVOIPPACKETS= 0; % No. of transmitted voip packets
TRANSMITTEDDATABYTES= 0;   % Sum of the Bytes of transmitted data packets
TRANSMITTEDVOIPBYTES= 0;   % Sum of the Bytes of transmitted voip packets
DELAYSDATA= 0;             % Sum of the delays of transmitted data packets
DELAYSVOIP= 0;             % Sum of the delays of transmitted voip packets
MAXDELAYDATA= 0;           % Maximum delay among all transmitted data packets
MAXDELAYVOIP= 0;           % Maximum delay among all transmitted voip packets
TRANSMITTEDPACKETS = 0;

% Initializing the simulation clock:
Clock= 0;
% Initializing the List of Events with the first ARRIVAL:
tmp= Clock + exprnd(1/lambda);
packetType=0; % 0->Data
EventList = [ARRIVAL, tmp, GeneratePacketSize(), tmp, packetType];
packetType=1; % 1->VoIP
for i=1:n 
    time = unifrnd(0,0.02);
    EventList = [EventList; ARRIVAL, time, Size(), time, packetType];
end

%Similation loop:
while TRANSMITTEDPACKETS<P           % Stopping criterium
    EventList= sortrows(EventList,2);    % Order EventList by time
    Event= EventList(1,1);               % Get first event and 
    Clock= EventList(1,2);               %   and
    PacketSize= EventList(1,3);          %   associated
    ArrivalInstant= EventList(1,4);      %   parameters.
    PacketType = EventList(1,5);
    EventList(1,:)= [];                  % Eliminate first event
    switch Event
        case ARRIVAL                     % If first event is an ARRIVAL
            if PacketType == 0
                TOTALDATAPACKETS= TOTALDATAPACKETS+1;
                tmp= Clock + exprnd(1/lambda);
                EventList = [EventList; ARRIVAL, tmp, GeneratePacketSize(), tmp, PacketType];
                if STATE==0
                    STATE= 1;
                    EventList = [EventList; DEPARTURE, Clock + 8*PacketSize/(C*10^6), PacketSize, Clock, PacketType];
                else
                    if QUEUEOCCUPATION + PacketSize <= (f*0.9)
                        QUEUE= [QUEUE;PacketSize , Clock, PacketType];
                        QUEUEOCCUPATION= QUEUEOCCUPATION + PacketSize;
                    else
                        LOSTDATAPACKETS= LOSTDATAPACKETS + 1;
                    end
                end
            else 
                TOTALVOIPPACKETS= TOTALVOIPPACKETS+1;
                time = Clock+unifrnd(0.016,0.024);
                EventList = [EventList; ARRIVAL, time, Size(), time, PacketType];
                if STATE==0
                    STATE= 1;
                    EventList = [EventList; DEPARTURE, Clock + 8*PacketSize/(C*10^6), PacketSize, Clock, PacketType];
                else
                    if QUEUEOCCUPATION + PacketSize <= f
                        QUEUE= [QUEUE;PacketSize , Clock, PacketType];
                        % sort QUEUE by packetType (1) primeiro (VoIP) (0) depois (Data)
                        QUEUE = sortrows(QUEUE,3,"descend");
                        QUEUEOCCUPATION= QUEUEOCCUPATION + PacketSize;
                    else
                        LOSTVOIPPACKETS= LOSTVOIPPACKETS + 1;
                    end
                end
            end
        case DEPARTURE                     % If first event is a DEPARTURE
            TRANSMITTEDPACKETS = TRANSMITTEDPACKETS + 1;
            if PacketType == 0
                TRANSMITTEDDATABYTES= TRANSMITTEDDATABYTES + PacketSize;
                DELAYSDATA= DELAYSDATA + (Clock - ArrivalInstant);
                if Clock - ArrivalInstant > MAXDELAYDATA
                    MAXDELAYDATA= Clock - ArrivalInstant;
                end
                TRANSMITTEDDATAPACKETS= TRANSMITTEDDATAPACKETS + 1;
                if QUEUEOCCUPATION > 0
                    EventList = [EventList; DEPARTURE, Clock + 8*QUEUE(1,1)/(C*10^6), QUEUE(1,1), QUEUE(1,2), QUEUE(1,3)];
                    QUEUEOCCUPATION= QUEUEOCCUPATION - QUEUE(1,1);
                    QUEUE(1,:)= [];
                else
                    STATE= 0;
                end
            else
                TRANSMITTEDVOIPBYTES= TRANSMITTEDVOIPBYTES + PacketSize;
                DELAYSVOIP= DELAYSVOIP + (Clock - ArrivalInstant);
                if Clock - ArrivalInstant > MAXDELAYVOIP
                    MAXDELAYVOIP= Clock - ArrivalInstant;
                end
                TRANSMITTEDVOIPPACKETS= TRANSMITTEDVOIPPACKETS + 1;
                if QUEUEOCCUPATION > 0
                    EventList = [EventList; DEPARTURE, Clock + 8*QUEUE(1,1)/(C*10^6), QUEUE(1,1), QUEUE(1,2), QUEUE(1,3)];
                    QUEUEOCCUPATION= QUEUEOCCUPATION - QUEUE(1,1);
                    QUEUE(1,:)= [];
                else
                    STATE= 0;
                end
            end
    end
end

%Performance parameters determination:
PLd= 100*LOSTDATAPACKETS/TOTALDATAPACKETS;                         % in %
PLv= 100*LOSTVOIPPACKETS/TOTALVOIPPACKETS;                         % in %
APDd= 1000*DELAYSDATA/TRANSMITTEDDATAPACKETS;                      % in milliseconds
APDv= 1000*DELAYSVOIP/TRANSMITTEDVOIPPACKETS;                      % in milliseconds
MPDd= 1000*MAXDELAYDATA;                                           % in milliseconds
MPDv= 1000*MAXDELAYVOIP;                                           % in milliseconds
TT= 10^(-6)*(TRANSMITTEDDATABYTES+TRANSMITTEDVOIPBYTES)*8/Clock;   % in Mbps

end

function out= GeneratePacketSize()
    aux= rand();
    aux2= [65:109 111:1517];
    if aux <= 0.19
        out= 64;
    elseif aux <= 0.19 + 0.23
        out= 110;
    elseif aux <= 0.19 + 0.23 + 0.17
        out= 1518;
    else
        out = aux2(randi(length(aux2)));
    end
end

function out= Size()
    out = randi([110,130]);
end