disp('2.(a) Represents a low pass circuit with amplifier. During DC conditions, the', ...
     'capacitor will block current however the resistors will let it', ...
     'pass freely. The inductor will also let it pass freely.', ...
     'However, once the current begins to alternate, the inductor', ...
     'will begin to resist the current and the capacitor will begin',...
     'to conduct. This will cause parralel resistance and further',...
     'the resistance of the circuit')
 
 disp('2.(b) I would expects a pass band during the low frequencies',...
      ' and a 2nd order drop off at its respective frequency')
  
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
   
      
%function A
V1 = 0;      
F = zeros(1);
F = [V1; 0; 0; 0; 0; 0; 0];

for count  = 1:1:timecuts
    
    
end
      
      
      
      
      
      
      
      
      
      
      
      
      
      