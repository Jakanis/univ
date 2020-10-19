import math
import random

import numpy as np
from sklearn import svm

def get_data():
    inputs = list()
    outputs = list()
    for x in np.arange(-1.0, 1.0, 0.1):
        for y in np.arange(0.0, 5.0, 0.1):
            for z in np.arange(1.0, 5.0, 0.1):
                inputs.append([x, y, z])
                outputs.append([x*x + 2*x*y - math.sqrt(z)])
    return inputs, outputs


if __name__ == '__main__':
    X, y = get_data()