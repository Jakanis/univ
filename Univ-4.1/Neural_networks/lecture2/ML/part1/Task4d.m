%task b

numInputs = 3;
numLayers = 3;
biasConnect = [1; 1; 1];
inputConnect = [1 1 1; 0 0 0; 0 0 0];
layerConnect = [0 0 0; 1 0 0; 0 1 0];
outputConnect = [0 0 1];

net = network(numInputs,numLayers,biasConnect,inputConnect,layerConnect,outputConnect);

net.inputs{1}.size = 3
net.inputs{2}.size = 3
net.inputs{3}.size = 3

net.layers{1}.size = 3
net.layers{2}.size = 3
net.layers{3}.size = 3

% net.layerWeights = {0 0 1; 1 0 0; 0 1 0}
net.inputWeights{1, 1}.delays = [1]
net.inputWeights{1, 2}.delays = [1]
net.inputWeights{1, 3}.delays = [1]
net.layerWeights{2, 1}.delays = [1]
net.layerWeights{3, 2}.delays = [2]

view(net);