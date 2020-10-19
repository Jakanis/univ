if __name__ == '__main__':
    a, p, g = 600, 18913, 7
    x = 1
    while (g ** x) % p != a % p:
        x += 1
    print("x = ", x)
    assert (g ** x) % p == a % p