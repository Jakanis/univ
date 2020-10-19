
w1 = -2.2817;
w2 = -1.3234;
b = 1.4438;

x=linspace(-3, 3, 50);
y=-(w1/w2)*x-(b/w2);

plot(x,y, 'DisplayName','Linear network')
hold on
grid on


w1 = -1;
w2 = -1;
b = 1;

x=linspace(-3, 3, 50);
y=-(w1/w2)*x-(b/w2);

plot(x,y, 'DisplayName','Perceptron')


x=[-1, 0, 1, 1];
y=[-1, 0, -1, 1];
scatter(x,y,'filled', 'DisplayName','Points')


legend