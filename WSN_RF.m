% Import necessary toolboxes
global pt;
import phased.*
import comm.*
run('main.m');
% Constant Definitions
nNodes = 100; % Number of wireless sensor nodes
centerFrequency = 5e9; % Operating frequency (5 GHz - suitable for sub-6 GHz 5G)
binaryDataSize = 1024; % Size of binary data to be transmitted by each node

% Network and Antenna Setup
nodes = cell(1,nNodes); % Create a wireless sensor network with antennas
for k = 1:nNodes
    % Create an isotropic antenna element for each node, with a specified frequency range of 2 GHz to 8 GHz
    nodes{k} = phased.IsotropicAntennaElement('FrequencyRange', [2e9 8e9]);
end

% Spatial Setup
% Random 3D positions for the nodes; Z-coordinates are all 0
nodePos = [100*rand(2,nNodes); zeros(1,nNodes)];
% Base station is located at the origin in 3D
basePos = [0;0;0];
% Plot Node Positions and Antenna Directions
% figure;
% hold on;
% plot(basePos(1), basePos(2), 'ro', 'DisplayName', 'Base Station');
% for k = 1:nNodes
%     plot(nodePos(1,k), nodePos(2,k), 'bo', 'DisplayName', sprintf('Node %d', k));
%     quiver(nodePos(1,k), nodePos(2,k), basePos(1)-nodePos(1,k), basePos(2)-nodePos(2,k), 0.1, 'b');
% end
% xlabel('X Coordinate');
% ylabel('Y Coordinate');
% title('Node Positions and Antenna Directions');
% legend('Location','best');
% hold off;

% Preallocate bit errors
bitErrors = zeros(1,nNodes);
%%
% Data Transmission and Reception
% Iterate over each node, transmit data, and receive it at the base station
for k = 1:nNodes
    % Generate random binary data at each node
    %data = randi([0 1], binaryDataSize, 1);
   M = 16;
   data = (0:M-1);
   [y,mapy] = bin2gray(data,'qam',16);
    % Amplify the received signal (simple gain model for the receiving antenna)


   pt=y;
    if(mod(length(pt),16)~=0)
    pt= [pt, zeros(1, 16 -mod(length(pt),16))];
end
for i=1:16
    dim=1;
lb_pso=1;
ub_pso=3;% Upper bounds
 fobj = @CostFunction;
[Best_score]=pso(dim,lb_pso,ub_pso,fobj);
key(i)=round(Best_score.Cost);
end
s = aesinit(key);
% ------------------------------------------------------------------------
% ECB test of AES-128
tic
ct = aes(s, 'enc', 'ecb', pt);
t1=toc;
disp('Encryption time for CPSO-AES');
disp(t1);
tic
sig= round((aes(s, 'dec', 'ecb', ct)));
t2=toc;
disp('Decryption time for CPSO-AES');
disp(t1);
    receivedSig = sig;

    

    recvData =gray2bin(receivedSig,'qam',16) ;

    % Compare the transmitted and received data to check for transmission errors
    nErrors = biterr(data, recvData);

    % Output the number of errors for each node
    fprintf('Node %d: %d errors\n', k, nErrors);

    % Store bit errors for each node
    bitErrors(k) = nErrors;
end
%%
run("access_sensor.m")
%%
r3=0:rmax;
figure
plot(r3,RENERGY1,'-g');
xlabel('Number of Round');
ylabel('Residual Energy (J)');
figure
plot(r3,ENERGY1,'-g');
xlabel('Number of Round');
ylabel('Energy Consumed (J)');
% title('Heterogeneous nodes');
figure
for j = 1:rmax
    eav(j+1) = STATISTICS3(j+1).Eavg5;
end
plot(r3,eav,'-g');
xlabel('Number of Round');
ylabel('Normalized Average Energy per Round (J)');
% title('\bf Heterogeneous nodes');
figure
for i = 0:rmax
    alive_nodes(i+1) = STATISTICS3(i+1).ALLIVE5;
end
plot(r3,alive_nodes,'-g');
xlabel('Number of Round');
ylabel('Number of Alive Nodes per Rounds');
% title('\bf Heterogeneous nodes');
figure
for i = 0:rmax
    dead_nodes(i+1) = STATISTICS3(i+1).DEAD5;
end
plot(r3,dead_nodes,'-g');
xlabel('x(Number of Round)');
ylabel('Number of Dead Nodes per Rounds');
% title('\bf Heterogeneous nodes');
% Plot the bit errors for each node
figure;
bar(1:nNodes, bitErrors);
xlabel('Node');
ylabel('Bit Errors');
title('Bit Errors for Each Node');
