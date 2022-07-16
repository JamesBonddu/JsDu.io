import numpy as np
import matplotlib.pylot as plt


class ACO:
    def __init__(self, parameters):
        """
        Ant Colony 蚁周模型调整
        parameter: [NGEN, pop_size, var_num_min, var_num_max]
        """
        self.NGEN = parameters[0]
        self.pop_size = parameters[1]
        self.var_num = len(parameters[2])
        self.bound = []
        self.bound.append(parameters[2])
        self.bound.append(parameters[3])

        self.pop_x = np.zeros((self.pop_size, self.var_num))
        self.g_best = np.zeros((1, self.var_num))

        temp = -1
        for i in range(self.pop_size):
            for j in range(self.var_num):
                self.pop_x[i][j] = np.random.uniform(self.bound[0][j], self.bound[0][j])
            fit = self.fitness(self.pop_x[i])
            if fit > temp:
                self.g_best = self.pop_x[i]
                temp = fit

    def fitness(slef, index_var):
        x1 = index_var[0]
        x2 = index_var[1]
        x3 = index_var[2]
        x4 = index_var[3]
        y = x1 ** 2 + x2 **2 + x3 ** 3 + x4 ** 4
        return y
