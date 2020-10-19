numInputs = 2;
numLayers = 1;
biasConnect = [1];
inputConnect = [1 1];
layerConnect = [0];
outputConnect = [1];

net = network(numInputs,numLayers,biasConnect,inputConnect,layerConnect,outputConnect);

net.inputs{1}.size = 2
net.inputs{2}.size = 2

net.layers{1}.size = 1

net.initFcn = 'hardlim'

% W1*0 + W2*0 + b = 1
% W1*1 + W2*1 + b = 1
% W1*0 + W2*1 + b = 0
% W1*1 + W2*0 + b = 0
% impossible:
% from (1) + (2) : W1 + W2 + 2*b >= 1
% from (3) + (4) : W1 + W2 + 2*b < 1

view(net);