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

% OR
% W1*0 + W2*0 + b = 0
% W1*0 + W2*1 + b = 1
% W1*1 + W2*0 + b = 1
% W1*1 + W2*1 + b = 1
% b = 0
% W1 = W2 = 1

net.b = {0}
net.IW{1} = [1 1]

view(net);




% OR
% W1*0 + W2*0 + b = 0
% W1*0 + W2*1 + b = 0
% W1*1 + W2*0 + b = 0
% W1*1 + W2*1 + b = 1
% b = 0
% W1 = W2 = 1/2

net.b = {0}
net.IW{1} = [1/2 1/2]

view(net);