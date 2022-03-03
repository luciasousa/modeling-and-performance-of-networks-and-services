function [PLdata , PLvoip, APDdata, APDvoip , MPDdata , MPDvoip, TT] = Simulator5(lambda,C,f,P,n)
% INPUT PARAMETERS:
%  lambda - packet rate (packets/sec)
%  C      - link bandwidth (Mbps)
%  f      - queue size (Bytes)
%  P      - number of packets (stopping criterium)
%  n      - number of VoIP packets
% OUTPUT PARAMETERS:
%  PLdata   - packet loss of data packets (%)
%  PLvoip   - packet loss of VoIP packets (%)
%  APDdata  - average packet delay of data (milliseconds)
%  APDvoip  - average packet delay of VoIP (milliseconds)
%  MPDdata  - maximum packet delay of data (milliseconds)
%  MPDvoip  - maximum packet delay of VoIP (milliseconds)
%  TT   - transmitted throughput (Mbps)

%Events:
ARRIVAL= 0;       % Arrival of a packet            
DEPARTURE= 1;     % Departure of a packet

%State variables:
STATE = 0;          % 0 - connection free; 1 - connection busy
QUEUEOCCUPATION= 0; % Occupation of the queue (in Bytes)
QOCCUPATION = 0;    % Occupation of the queue (%)
QUEUE= [];          % Size and arriving time instant of each packet in the queue

%Statistical Counters:
TOTALPACKETS= 0;                % No. of packets arrived to the system
TOTALPACKETSdata= 0;            % No. of data packets arrived to the system
TOTALPACKETSvoip= 0;            % No. of VoIP packets arrived to the system

LOSTPACKETS= 0;                 % No. of packets dropped due to buffer overflow
LOSTPACKETSdata= 0;             % No. of data packets dropped due to buffer overflow
LOSTPACKETSvoip= 0;             % No. of VoIP packets dropped due to buffer overflow

TRANSMITTEDPACKETS= 0;          % No. of transmitted packets
TRANSMITTEDPACKETSdata= 0;      % No. of transmitted data packets
TRANSMITTEDPACKETSvoip= 0;      % No. of transmitted VoIP packets
TRANSMITTEDBYTES= 0;            % Sum of the Bytes of transmitted packets

DELAYS= 0;                      % Sum of the delays of transmitted packets
DELAYSdata= 0;                  % Sum of the delays of transmitted data packets
DELAYSvoip= 0;                  % Sum of the delays of transmitted VoIP packets

MAXDELAY= 0;                    % Maximum delay among all transmitted packets
MAXDELAYdata= 0;                % Maximum delay among all transmitted data packets
MAXDELAYvoip= 0;                % Maximum delay among all transmitted VoIP packets

% Initializing the simulation clock:
Clock= 0;

% Initializing the List of Events with the first ARRIVAL:
tmp= Clock + exprnd(1/lambda);
EventList = [ARRIVAL, tmp, GeneratePacketSize(), tmp, 0];

for i=1:n
    tmp = rand() * 0.02;
    EventList = [EventList; ARRIVAL, tmp, GeneratePacketSizeVoIP(), tmp, 1];
end

%Similation loop:
while TRANSMITTEDPACKETS<P               % Stopping criterium
    EventList= sortrows(EventList,2);    % Order EventList by time
    Event= EventList(1,1);               % Get first event and 
    Clock= EventList(1,2);               %   and
    PacketSize= EventList(1,3);          %   associated
    ArrivalInstant= EventList(1,4);      %   parameters.
    PacketType = EventList(1,5);
    EventList(1,:)= [];                  % Eliminate first event
    switch Event
        case ARRIVAL                     % If first event is an ARRIVAL
            TOTALPACKETS= TOTALPACKETS+1;
            if PacketType == 0
                TOTALPACKETSdata = TOTALPACKETSdata + 1;
                tmp= Clock + exprnd(1/lambda);
                EventList = [EventList; ARRIVAL, tmp, GeneratePacketSize(), tmp, PacketType];
            else
                TOTALPACKETSvoip = TOTALPACKETSvoip + 1;
                tmp = Clock + unifrnd(0.016,0.024);
                EventList = [EventList; ARRIVAL, tmp, GeneratePacketSizeVoIP(), tmp, PacketType];
            end
            
            
            if STATE==0
                STATE= 1;
                EventList = [EventList; DEPARTURE, Clock + 8*PacketSize/(C*10^6), PacketSize, Clock, PacketType];
            else
                if QUEUEOCCUPATION + PacketSize <= f
                    if PacketType == 0
                        temp = QUEUEOCCUPATION + PacketSize;
                        temp2 = temp/f;
                        if temp2 < 0.90
                            QUEUE= [QUEUE;PacketSize , Clock, PacketType];
                            QUEUE = sortrows(QUEUE,3,'descend');
                            QUEUEOCCUPATION= temp;
                            QOCCUPATION = temp2;
                        else
                            LOSTPACKETS= LOSTPACKETS + 1;
                            LOSTPACKETSdata = LOSTPACKETSdata + 1;
                        end
                    else
                        QUEUE= [QUEUE;PacketSize , Clock, PacketType];
                        QUEUE = sortrows(QUEUE,3,'descend');
                        QUEUEOCCUPATION= QUEUEOCCUPATION + PacketSize;
                        QOCCUPATION = QUEUEOCCUPATION/f;
                    end
                else
                    LOSTPACKETS= LOSTPACKETS + 1;
                    if PacketType == 0
                        LOSTPACKETSdata = LOSTPACKETSdata + 1;
                    else
                        LOSTPACKETSvoip = LOSTPACKETSvoip + 1;
                    end
                end
            end
        case DEPARTURE                     % If first event is a DEPARTURE
            TRANSMITTEDBYTES= TRANSMITTEDBYTES + PacketSize;
            TRANSMITTEDPACKETS= TRANSMITTEDPACKETS + 1;

            if PacketType == 0
                TRANSMITTEDPACKETSdata = TRANSMITTEDPACKETSdata + 1;
                DELAYSdata= DELAYSdata + (Clock - ArrivalInstant);
                if Clock - ArrivalInstant > MAXDELAYdata
                    MAXDELAYdata= Clock - ArrivalInstant;
                end
            else
                TRANSMITTEDPACKETSvoip = TRANSMITTEDPACKETSvoip + 1;
                DELAYSvoip= DELAYSvoip + (Clock - ArrivalInstant);
                if Clock - ArrivalInstant > MAXDELAYvoip
                    MAXDELAYvoip= Clock - ArrivalInstant;
                end
            end

            if QUEUEOCCUPATION > 0
                EventList = [EventList; DEPARTURE, Clock + 8*QUEUE(1,1)/(C*10^6), QUEUE(1,1), QUEUE(1,2), QUEUE(1,3)];
                QUEUEOCCUPATION= QUEUEOCCUPATION - QUEUE(1,1);
                QUEUE(1,:)= [];
            else
                STATE= 0;
            end
    end
end

%Performance parameters determination:
PLdata= 100*LOSTPACKETSdata/TOTALPACKETSdata;           % in %
APDdata= 1000*DELAYSdata/TRANSMITTEDPACKETSdata;        % in milliseconds
MPDdata= 1000*MAXDELAYdata;                             % in milliseconds

PLvoip= 100*LOSTPACKETSvoip/TOTALPACKETSvoip;           % in %
APDvoip= 1000*DELAYSvoip/TRANSMITTEDPACKETSvoip;        % in milliseconds
MPDvoip= 1000*MAXDELAYvoip;                             % in milliseconds

TT= 10^(-6)*TRANSMITTEDBYTES*8/Clock;                   % in Mbps

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

function out= GeneratePacketSizeVoIP()
    out = randi([110,130]);
end