from math import atan2, pi

import numpy as np
from matplotlib import pyplot as plt

from commons.commons import hardlim

def func(k, value, bias):
    return k * value + bias

def AddPoint(plot, x, y, color):
    plot.scatter(x, y, c=color)
    plot.clf()
    plot.show()

if __name__ == '__main__':
    x = np.arange(0, 2, 0.01)
    # setting the corresponding y - coordinates
    y = np.sin(x)


    w1 = -2.2817
    w2 = -1.3234
    b = 1.4438
    x = np.arange(-2, 2, 0.1)
    y = np.array([func(-(w1 / w2), elem, -(b / w2)) for elem in x])

    plt.plot(x, y)
    plt.plot(-1, -1, 'ro')
    plt.plot(0, 0, 'ro')
    plt.plot(1, -1, 'ro')
    plt.plot(1, 1, 'bo')

    plt.show()
