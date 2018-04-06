clear all

runTime = 1; %given in seconds
timecuts = 1000;
dt =runTime/timecuts;

R1=1;
C1=0.25;
R2=2;
L1=0.2;
R3=10;
a=100;
b=-50;
c=300;
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
   
G = [     1,             0,  0,    0,                  0,     0,            0; ...
      -1/R1, (1/R2 + 1/R1), -1,    0,                  0,     0,            0; ...
          0,             1,  0,   -1,                  0,     0,            0; ...
          0,             0, -1, 1/R3,                  0,     0,            0; ...
          0,             0,  0,    0, (-a-b^(-2)-c^(-3)),     1,            0; ...
          0,             0,  0, 1/R3,                 -1,     0,            0; ...
          0,             0,  0,    0,                  0, -1/R4, (1/R4 +1/Ro)];
   
      
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


figure(20)
plot((1:timecuts).*dt,Volist(1,:))
xlabel('Time(seconds)')
ylabel('Voltage')
title('Vout of Step voltage')
hold on
plot((1:timecuts).*dt,V1list(1,:))
hold off

figure(21)
g = abs(fftshift(fft(Volist(1,:))));
plot(((1:length(g))/timecuts)-0.5,g)
xlim([-0.05 0.05])
xlabel('frequency')
ylabel('magnitude')
title('Fourier transform of output')