net = newp([-2 2;-2 2], 1)

net.IW{1,1}=[1 1];
net.b{1}=[1];

%net=init(net)

p={[-1;-1] [0;0] [1;-1] [1;1]};
T1=[1; 1; 1; 0];

net.adaptParam.passes = 10;

net=adapt(net,p(1),T1(1));
net=adapt(net,p(2),T1(2));
net=adapt(net,p(3),T1(3));
net=adapt(net,p(4),T1(4))


