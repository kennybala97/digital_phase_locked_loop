import pandas as pd
import matplotlib.pyplot as plt

vco_data = pd.read_csv("test.txt", header=None)

plt.plot(vco_data[0])
plt.show()