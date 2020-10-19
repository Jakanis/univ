import plotly
from keras.models import Sequential
from keras.layers import Dense
from ann_visualizer.visualize import ann_viz
import numpy as np
from plotly import graph_objects
from commons.commons import relu


def func(x: float) -> float:
    return x ** 3 - x ** 2 - 10


if __name__ == '__main__':
    # 1st task
    fig = graph_objects.Figure(
        data=graph_objects.Scatter(x=np.linspace(-10, 10), y=func(np.linspace(-10, 10)), mode='lines'))
    fig.update_xaxes(title_text='x')
    fig.update_yaxes(title_text='f(x)')
    plotly.offline.plot(fig, filename='line.html', auto_open=False)
    # 2nd task
    a = np.array([[3, 7], [5, 2]])
    b = np.array([27, 16])
    x = np.linalg.solve(a, b)
    print(np.allclose(np.dot(a, x), b))
    print(x)
    # 3rd task
    model = Sequential()
    model.add(Dense(4, input_dim=5, activation='relu'))
    model.add(Dense(2, activation='sigmoid'))
    ann_viz(model, title="My first neural network", view=False)
