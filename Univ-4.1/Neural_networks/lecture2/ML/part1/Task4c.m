%task b

numInputs = 1;
numLayers = 3;
biasConnect = [1; 1; 1];
inputConnect = [1; 0; 0];
layerConnect = [0 0 0; 1 0 0; 1 1 0];
outputConnect = [0 0 1];

net = network(numInputs,numLayers,biasConnect,inputConnect,layerConnect,outputConnect);

net.inputs{1}.size = 2

net.layers{1}.size = 3
net.layers{2}.size = 3
net.layers{3}.size = 3

view(net);