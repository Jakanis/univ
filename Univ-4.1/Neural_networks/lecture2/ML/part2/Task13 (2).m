numInputs = 1;
numLayers = 1;
biasConnect = [1];
inputConnect = [1];
layerConnect = [0];
outputConnect = [1];

net = network(numInputs,numLayers,biasConnect,inputConnect,layerConnect,outputConnect);

net.inputs{1}.size = 2
net.layers{1}.size = 1

net.layers{1}.transferFcn = 'hardlim';

% W*0 + b = 1
% W*1 + b = 0
% b = 1
% W = -1

net.b = {1}
net.IW{1} = [-1 -1]


view(net);