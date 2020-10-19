from math import atan2, pi

import numpy as np
from matplotlib import pyplot as plt

from commons.commons import hardlim


def make_out(weight, bias, first_param, second_param):
    inner_output = first_param * weight[0] + second_param * weight[1] + bias
    return hardlim(inner_output)


def run_all_variants(weight, bias):
    print("weights =", weight, ", b =", bias)
    for it1 in range(0, 2):
        for it2 in range(0, 2):
            print(it1, it2, "output", make_out(weight, bias, it1, it2))


def func(k, value, bias):
    return k * value + bias


if __name__ == '__main__':
    # завдання 15
    print("A")
    run_all_variants(np.array([1, 0]), -1)
    print("Б")
    run_all_variants(np.array([-1, -1]), 1)
    print("Розв'язок В та Г неможливий")
    # завдання 16
    w1 = 5
    w2 = -8
    b = 4
    x = np.arange(0, 6, 0.1)
    y = np.array([func(-(w1 / w2), elem, -(b / w2)) for elem in x])
    plt.plot(x, y)
    for it in range(100):
        p1 = np.random.uniform() * 6
        p2 = np.random.uniform() * 6
        plt.plot([p1], [p2], 'bo', color='green' if hardlim(p1 * w1 + p2 * w2 + b) else 'red')
    plt.show()


    plt.plot(x, y)
    for it in range(100):
        p1 = np.random.uniform() * 6 - 3
        p2 = np.random.uniform() * 6 - 3
        atan_ = atan2(p1, p2)
        color="red"
        if (atan_>0 and atan_<=2*pi/3):
            color = 'green'
        if (atan_>2*pi/3 and atan_<=4*pi/3):
            color = 'yellow'
        if (atan_>4*pi/3 and atan_<=2*pi):
            color = 'red'
        plt.plot([p1+3], [p2+3], 'bo', color=color)
    plt.show()



    #   00=0 -> b<0
    #   01=1&10=1 ->w1>-b & w2>-b
    #   BUT
    #   11=0 -> w1+w2<-b

    # plt.figure()
    # x = np.linspace(-2.0, 2.0, 100)
    # y = np.linspace(-2.0, 2.0, 100)
    # X, Y = np.meshgrid(x, y)
    # F = X * w1 + Y * w2 + b
    # plt.contour(X, Y, F)
    # plt.show()

