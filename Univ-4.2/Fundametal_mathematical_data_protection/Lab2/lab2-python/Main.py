import numpy as np
import time
start_time = time.clock()
n = 100000
p = np.array([[0.1, 0.4, 0.5],
              [0.2, 0.5, 0.3],
              [0.7, 0.2, 0.1]])

p0 = np.array([0.2, 0.4, 0.4])

for i in range(n):
    p2 = p.dot(p)
    p3 = p2.dot(p)
    p4 = p3.dot(p)
    p0p3 = p0.dot(p3)
    p0p4 = p0.dot(p4)

    # print('p2:\n'+str(p2))
    # print('p3:\n'+str(p3))
    # print('p4:\n'+str(p4))
    # print('p0p3:\n'+str(p0p3))
    # print('p0p4:\n'+str(p0p4))

res = time.clock() - start_time
res = res*1000*1000
print(str(n)+" runs in "+ str(res) + " microseconds")
print("avg: "+str(res/n) + " microseconds")