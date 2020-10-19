import itertools
from tabulate import tabulate

if __name__ == '__main__':
    with open("input.txt") as f:
        p, g, a, b = 23, 5, 6, 7
        g_a = (g ** a) % p
        g_b = (g ** b) % p
        k_a = (g_b ** a) % p
        k_b = (g_a ** b) % p
        print(tabulate([[p, g, a, b, g_a, g_b, k_a, k_b]],
                       headers=["p", "g", "a", "b", "A", "B", "K(A)", "K(B)"], tablefmt="github"))
        x_answers, y_answers = [], []
        x_id, y_id = 0, 0
        print_table = []
        g_cur = 1
        for xy in range(1, p):
            g_cur = (g_cur * g) % p
            first_str = str(xy)
            if g_cur == g_a:
                x_id += 1
                first_str = "$x_" + str(x_id) + " = " + first_str + "$"
                x_answers.append(xy)

            if g_cur == g_b:
                y_id += 1
                first_str = "$y_" + str(y_id) + " = " + first_str + "$"
                y_answers.append(xy)

            print_table.append([first_str, str(g_cur), str(g_cur)])

        print(tabulate(print_table, headers=["x, y", "A = g^x mod p", "B=g^x mod p"], tablefmt="github"))

        print_table = []
        for x, y in itertools.product(x_answers, y_answers):
            print_table.append([x, y, x * y, (g ** (x * y)) % p, (x * y) % (p - 1)])

        print(
            tabulate(print_table, headers=["x", "y", "xy", "K=g^{xy} mod p", "xy mod (p-1)"], tablefmt="github"))