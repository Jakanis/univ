import numpy as np
from matplotlib import pyplot
from commons.commons import hardlim,func

w1 = 5
w2 = -10
b = 4
x = np.arange(0, 6, 0.1)
y = np.array([func(-(w1 / w2), elem, -(b / w2)) for elem in x])
pyplot.plot(x, y)
for it in range(100):
    p1 = np.random.uniform() * 6
    p2 = np.random.uniform() * 6
    pyplot.plot([p1], [p2], 'bo', color='green' if hardlim(p1 * w1 + p2 * w2 + b) else 'red')
pyplot.savefig('division')