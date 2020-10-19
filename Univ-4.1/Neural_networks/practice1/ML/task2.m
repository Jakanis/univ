net = network();

net.numInputs = 2;
net.numLayers = 3;
net.biasConnect = [1; 0; 0];
net.inputConnect = [1 1; 0 0; 0 0];
net.layerConnect = [0 0 0; 1 0 0; 0 1 0];
net.outputConnect = [0 0 1];

P = [0 0;0 0];
% A = sim(net, P);


% !!!
net.layers{1}.size = 1
net.layers{2}.size = 1
net.layers{3}.size = 1
% !!!!!!


net.inputs{1}.range = [0 1];
net.inputs{2}.range = [0 1];
net.b{1} = -1/4;
% net.b = {-1/4; 0; 0}


net.IW{1,1} = [0.5];
net.IW{1,2} = [0.5];
net.LW{2,1} = [0.5];
net.LW{3,2} = [0.5];

% gensim(net);

net.inputWeights{1, 1}.delays = [0 1];
net.inputWeights{1, 2}.delays = [0 1];
net.layerWeights{3, 2}.delays = [0 1 2];

net.IW{1, 1} = [0.5 0.5];
net.IW{1, 2} = [0.5 0.25];
net.LW{3, 2} = [0.5 0.25 1];

AG = sim(net, P);

PG = [0.5 1; 1 0.5];
PS = {[0.5 1] [1 0.5]};
AG = sim(net, P);

net.inputWeights{1, 1}.delays = [0 1];
net.inputWeights{1, 2}.delays = [0 1];
net.layerWeights{3, 2}.delays = [0 1 2];

net.IW{1, 1} = [0.5 0.5];
net.IW{1, 2} = [0.5 0.25];
net.LW{3, 2} = [0.5 0.25 1];

AG = sim(net, P); 

view(net);