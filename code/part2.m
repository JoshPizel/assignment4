% disp('2.(a) Represents a low pass circuit with amplifier. During DC conditions, the', ...
%      'capacitor will block current however the resistors will let it', ...
%      'pass freely. The inductor will also let it pass freely.', ...
%      'However, once the current begins to alternate, the inductor', ...
%      'will begin to resist the current and the capacitor will begin',...
%      'to conduct. This will cause parralel resistance and further',...
%      'the resistance of the circuit')
%  
%  disp('2.(b) I would expects a pass band during the low frequencies',...
%       ' and a 2nd order drop off at its respective frequency')
  
runTime = 1; %given in seconds
timecuts = 1000;
dt =runTime/timecuts;

R1=1;
C1=0.25;
R2=2;
L1=0.2;
R3=10;
a=100;
R4=0.1;
Ro=1000;


%    V1    V2     V3          V5       IL3
% G = [-1/R1, 0,     0,          0,      0; ...%N1
%      1/R1 , -1/R2, 0,          0,      0; ...%N2
%      0,     0,     -1/R3,      0,      0; ...%N3
%      0,     0,     -a/(R3*R4), -1/R4,  0; ...%N4
     

C = [  0, 0,   0, 0, 0, 0, 0; ...
     -C1,C1,   0, 0, 0, 0, 0; ...
       0, 0, -L1, 0, 0, 0, 0; ...
       0, 0,   0, 0, 0, 0, 0; ...
       0, 0,   0, 0, 0, 0, 0; ...
       0, 0,   0, 0, 0, 0, 0; ...
       0, 0,   0, 0, 0, 0, 0];
   
G = [     1,             0,  0,    0,  0,     0,            0; ...
      -1/R1, (1/R2 + 1/R1), -1,    0,  0,     0,            0; ...
          0,             1,  0,   -1,  0,     0,            0; ...
          0,             0, -1, 1/R3,  0,     0,            0; ...
          0,             0,  0,    0, -a,     1,            0; ...
          0,             0,  0, 1/R3, -1,     0,            0; ...
          0,             0,  0,    0,  0, -1/R4, (1/R4 +1/Ro)];
   
      
%Time Stepping function
V1 = 0;      
F = zeros(7,1);
%Flist = [V1; 0; 0; 0; 0; 0; 0];
Flist = zeros(7,1,timecuts);
Flist(1,1,30:timecuts) = 1;
Vlist = zeros(7,1,timecuts);

for count  = 2:1:timecuts
    A = C/dt +G;
    
    Vlist(:,:,count) = A\(C*Vlist(:,:,count-1)/dt +Flist(:,:,count));
end
      
V1list(1,:) = Vlist(1,1,:);
V2list(1,:) = Vlist(2,1,:);
ILlist(1,:) = Vlist(3,1,:);
I3list(1,:) = Vlist(4,1,:);
V4list(1,:) = Vlist(5,1,:);
Volist(1,:) = Vlist(7,1,:);


figure(1)
plot((1:timecuts).*dt,Volist(1,:))
xlabel('Time(seconds)')
ylabel('Voltage')
title('Vout of Step voltage')
hold on
plot((1:timecuts).*dt,V1list(1,:))
hold off

figure(2)
g = abs(fft(Volist(1,:)));
g = g(1:(length(g)/2));
plot((1:length(g))/timecuts,g)
xlabel('frequency')
ylabel('magnitude')
title('Fourier transform of output')
      
%Sine function
f = 1/0.03;
Flist = zeros(7,1,timecuts);
for count = 1:1:timecuts
    Flist(1,1,count) = sin(2*pi*f*count*dt);
end
Vlist = zeros(7,1,timecuts);

for count  = 2:1:timecuts
    A = C/dt +G;
    
    Vlist(:,:,count) = A\(C*Vlist(:,:,count-1)/dt +Flist(:,:,count));
end
      
V1list(1,:) = Vlist(1,1,:);
V2list(1,:) = Vlist(2,1,:);
ILlist(1,:) = Vlist(3,1,:);
I3list(1,:) = Vlist(4,1,:);
V4list(1,:) = Vlist(5,1,:);
Volist(1,:) = Vlist(7,1,:);



figure(3)
plot((1:timecuts).*dt,Volist(1,:))
xlabel('Time(seconds)')
ylabel('Voltage')
title('Vout of Sine wave')
hold on
plot((1:timecuts).*dt,V1list(1,:))
hold off

figure(4)
g = abs(fft(Volist(1,:)));
g = g(1:(length(g)/2));
plot((1:length(g))/timecuts,g)
xlabel('frequency')
ylabel('magnitude')
title('Fourier transform of output')

%Gaussian pulse
f = 1/0.03;
Flist = zeros(7,1,timecuts);
for count = 1:1:timecuts
    Flist(1,1,count) = sin(2*pi*f*count*dt);
end
Vlist = zeros(7,1,timecuts);

for count  = 2:1:timecuts
    A = C/dt +G;
    
    Vlist(:,:,count) = A\(C*Vlist(:,:,count-1)/dt +Flist(:,:,count));
end
      
V1list(1,:) = Vlist(1,1,:);
V2list(1,:) = Vlist(2,1,:);
ILlist(1,:) = Vlist(3,1,:);
I3list(1,:) = Vlist(4,1,:);
V4list(1,:) = Vlist(5,1,:);
Volist(1,:) = Vlist(7,1,:);



figure(3)
plot((1:timecuts).*dt,Volist(1,:))
xlabel('Time(seconds)')
ylabel('Voltage')
title('Vout of Sine wave')
hold on
plot((1:timecuts).*dt,V1list(1,:))
hold off

figure(4)
g = abs(fft(Volist(1,:)));
g = g(1:(length(g)/2));
plot((1:length(g))/timecuts,g)
xlabel('frequency')
ylabel('magnitude')
title('Fourier transform of output')
      
      
      
      
      
      