if __name__ == '__main__':
    p, g, a, b = 47, 8, 15, 42
    g_a = (g ** a) % p
    g_b = (g ** b) % p
    k_a = (g_b ** a) % p
    k_b = (g_a ** b) % p
    assert k_a == k_b
    print("K = ", k_a)