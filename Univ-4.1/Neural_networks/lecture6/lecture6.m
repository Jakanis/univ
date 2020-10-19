P = -1:0.1:1;
T = [-0.9602 -0.5770 -0.0729 0.3771 0.6405 0.6600 0.4609 0.1336 -0.2013 -0.4344 -0.5000 -0.3930 -0.1647 0.988 0.3072 0.3960 0.3449 0.1816 -0.0312 -0.2189 -0.3201];
plot(P, T, '*r', 'MarkerSize', 4, "LineWidth", 2)
hold on

net=newrbe(P,T);

V = sim(net,P);
plot(P, V, '*b', 'MarkerSize', 5, 'LineWidth', 2)
P = [-0.75 -0.25 0.25 0.75]
V = sim(net, P);
hold on
plot(P, V, '*b', 'MarkerSize', 10, 'LineWidth', 2)