clear, net = newlin([0,10],1)

net.inputWeights{1,1}.delays = [0 1 2];

net.IW{1,1} = [7 8 9];
net.b{1} = [0];
pi = {2 3};

p = {4 5 6 7};

%[a, pf] = sim(net,p,pi);

T = {10 15 20 25};

adaptPasses=300;

[net,y,E] = adapt(net,p,T,pi);

for i=1:adaptPasses
    [net,y{i},E{i}] = adapt(net,p,T,pi);
end

errs = cell2mat(E{adaptPasses})
errrs = mse(errs)