import numpy as np

M = np.array([[0.0,0.5,0.5],
              [0.5,0.0,0.5],
              [1.0,0.0,0.0]])

v = np.array([0.1,0.1,0.8])
v= np.matmul(v,M)
print(v)