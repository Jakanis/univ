import numpy as np
from sklearn.linear_model import Perceptron
from sklearn.metrics import accuracy_score


def generate(count):
    x = []s
    y = []
    for ir in range(0, count):
        math = np.random.randint(1, 6)
        physics = np.random.randint(1, 6)
        russian = np.random.randint(1, 6)
        disabled = np.random.randint(0, 2)
        x.append([math, physics, russian, disabled])
        y.append(1 if (disabled == 1 and math >= 3 and physics >= 3 and russian>=3) or (math >= 4 and physics >= 4 and math + physics + russian >= 11) else 0)
    return np.array(x), np.array(y)


if __name__ == '__main__':
    np.random.seed(42)
    X, y = generate(400)
    X_test, y_test = generate(50)
    perceptron = Perceptron(tol=1e-7)
    perceptron.fit(X, y)
    predict = perceptron.predict(X_test)
    print(accuracy_score(predict, y_test))
    print(perceptron.predict([[3,3,3,1]])) #prints 1
    print(perceptron.predict([[5,5,5,0]])) #prints 1
    print(perceptron.predict([[4,4,3,0]])) #prints 1
    print(perceptron.predict([[3,4,3,0]])) #prints 0
    print(perceptron.predict([[3,4,2,1]])) #prints 0

