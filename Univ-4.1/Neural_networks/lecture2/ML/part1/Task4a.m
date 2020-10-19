%task a

numInputs = 3;
numLayers = 1;
biasConnect = [0];
inputConnect = [1 1 1];
layerConnect = [0];
outputConnect = [1];

net = network(numInputs,numLayers,biasConnect,inputConnect,layerConnect,outputConnect);

net.inputs{1}.size = 2
net.inputs{2}.size = 2
net.inputs{3}.size = 2

net.layers{1}.size = 3

view(net);