numInputs = 10;
numLayers = 10;
biasConnect = [1; 1; 1; 1; 1; 1; 1; 1; 1; 1];
inputConnect = [1 0 0 0 0 0 0 0 0 0;
    0 1 0 0 0 0 0 0 0 0; 
    0 0 1 0 0 0 0 0 0 0; 
    0 0 0 1 0 0 0 0 0 0; 
    0 0 0 0 1 0 0 0 0 0; 
    0 0 0 0 0 1 0 0 0 0; 
    0 0 0 0 0 0 1 0 0 0; 
    0 0 0 0 0 0 0 1 0 0; 
    0 0 0 0 0 0 0 0 1 0; 
    0 0 0 0 0 0 0 0 0 1];
layerConnect = [0 0 0 0 0 0 0 0 0 0; 
    0 0 0 0 0 0 0 0 0 0; 
    0 0 0 0 0 0 0 0 0 0; 
    0 0 0 0 0 0 0 0 0 0; 
    0 0 0 0 0 0 0 0 0 0; 
    0 0 0 0 0 0 0 0 0 0; 
    0 0 0 0 0 0 0 0 0 0; 
    0 0 0 0 0 0 0 0 0 0; 
    0 0 0 0 0 0 0 0 0 0; 
    0 0 0 0 0 0 0 0 0 0; ];
outputConnect = [1 1 1 1 1 1 1 1 1 1];

net = network(numInputs,numLayers,biasConnect,inputConnect,layerConnect,outputConnect);

net.inputs{1}.size = 10
net.inputs{2}.size = 10
net.inputs{3}.size = 10
net.inputs{4}.size = 10
net.inputs{5}.size = 10
net.inputs{6}.size = 10
net.inputs{7}.size = 10
net.inputs{8}.size = 10
net.inputs{9}.size = 10
net.inputs{10}.size = 10

net.layers{1}.size = 10
net.layers{2}.size = 10
net.layers{3}.size = 10
net.layers{4}.size = 10
net.layers{5}.size = 10
net.layers{6}.size = 10
net.layers{7}.size = 10
net.layers{8}.size = 10
net.layers{9}.size = 10
net.layers{10}.size = 10

view(net);