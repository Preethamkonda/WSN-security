% Import necessary toolboxes
import phased.*
import comm.*

% Constant Definitions
sen_node = 100; % Number of wireless sensor node_sen
centerFrequency = 5e9; % Operating frequency (5 GHz - suitable for sub-6 GHz 5G)
binaryDataSize = 1024; % Size of binary data to be transmitted by each node

% Network and Antenna Setup
node_sen = cell(1,sen_node); % Create a wireless sensor network with antennas
for k = 1:sen_node
    % Create an isotropic antenna element for each node, with a specified frequency range of 2 GHz to 8 GHz
    node_sen{k} = phased.IsotropicAntennaElement('FrequencyRange', [2e9 8e9]);
end

% Spatial Setup
% Random 3D positions for the node_sen; Z-coordinates are all 0
nodePos = [100*rand(2,sen_node); zeros(1,sen_node)];
% Base station is located at the origin in 3D
basePos = [0;0;0];
% Plot Node Positions and Antenna Directions
% figure;
% hold on;
% plot(basePos(1), basePos(2), 'ro', 'DisplayName', 'Base Station');
% for k = 1:sen_node
%     plot(nodePos(1,k), nodePos(2,k), 'bo', 'DisplayName', sprintf('Node %d', k));
%     quiver(nodePos(1,k), nodePos(2,k), basePos(1)-nodePos(1,k), basePos(2)-nodePos(2,k), 0.1, 'b');
% end
% xlabel('X Coordinate');
% ylabel('Y Coordinate');
% title('Node Positions and Antenna Directions');
% legend('Location','best');
% hold off;

% Preallocate bit errors
bitErrors = zeros(1,sen_node);

% Data Transmission and Reception
% Iterate over each node, transmit data, and receive it at the base station
for k = 1:sen_node
    % Generate random binary data at each node
    %data = randi([0 1], binaryDataSize, 1);
  M=16;
   data = (0:M-1);
   p=7;
   q=13;
  n=p*q;
phi=(p-1)*(q-1);
val=0;
cd=0;

while(cd~=1||val==0)
n1=randi(n,1,1);
e=randi([2 n],1,1);
 val=isprime(e);
 cd=gcd(e,phi);
 end

val1=0;
d=0;
while(val1~=1)
d=d+1;
val1=mod(d*e,phi);
end
m1=data;
over=length(m1);
 o=1;
 tic;
 while(o<=over);
    m=m1(o);
    diff=0;
    if(m>n);
        diff=m-n+1;
    end
    m=m-diff;
        
qm=dec2bin(e);
len=length(qm);
c=1;
xz=1;
while(xz<=len)  
    if(qm(xz)=='1')
      c=mod(mod((c^2),n)*m,n);
    elseif(qm(xz)=='0')
        c=(mod(c^2,n));
    end
    xz=xz+1;
end
c1(o)=c;
t1(k)=toc;

tic;
qm1=dec2bin(d);
len1=length(qm1);
nm=1;
xy=1;
while(xy<=len1)    
    if(qm1(xy)=='1')
       nm=mod(mod((nm^2),n)*c,n);
    elseif(qm1(xy)=='0')
        nm=(mod(nm^2,n));
    end
     xy=xy+1;    
end
nm=nm+diff;
nm1(o)=(nm);
o=o+1;
 end
t2(k)=toc;


 




end
disp('Encryption time for RSA:')
disp(mean(t1))
disp('Decryption time for RSA:')
disp(mean(t2))
