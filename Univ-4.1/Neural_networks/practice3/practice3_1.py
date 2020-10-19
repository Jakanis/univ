import numpy as np
import matplotlib.pyplot as plt


if __name__ == '__main__':
    print("hi")
    # Task2
    # x=np.array(range(10))
    # y=x**2
    # plt.plot(x,y,label='y=x^2')
    # plt.xlabel('x')
    # plt.ylabel('y')
    # plt.title('my first plot')
    # plt.grid(alpha=.4,linestyle='-')
    # plt.legend()
    # plt.show()
    plt.figure()
    x=np.linspace(-2.0, 2.0, 100)
    y=np.linspace(-2.0, 2.0, 100)
    X,Y=np.meshgrid(x,y)
    F=X**2+Y**2-1
    plt.contour(X, Y, F, [0])
    plt.show()