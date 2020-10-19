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

net.layers{1}.transferFcn = 'hardlim';

% W1*0 + W2*0 + b = 0
% W1*0 + W2*1 + b = 0
% W1*1 + W2*0 + b = 1
% W1*1 + W2*1 + b = 1
% b = W2 = 0
% W1 = 1

net.b = {0}
net.IW{1} = [0 1]

view(net);