import numpy as np
import matplotlib.pyplot as plt


with open('numbers.txt', 'w') as f:
    # s1 = np.random.gamma(2, 1, 10**5*2//3)
    # s2 = np.random.gamma(7.5, 1, 10**5//3)

    # s = s1.tolist() + s2.tolist()

    s1 = np.random.normal(1000, 250, 10**5*6//10)
    s2 = np.random.normal(400, 200, 10**5*3//10)
    s3 = np.random.normal(100, 60, 10**5//10)

    s = s1.tolist() + s2.tolist() + s3.tolist()
    np.random.shuffle(s)

    count, bins, ignored = plt.hist(s, bins=20, density=True)
    plt.show()
    for i in s:
        f.write(f'{i:.3f}\n')

