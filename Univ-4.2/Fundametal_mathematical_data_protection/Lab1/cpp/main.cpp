#include <iostream>
#include <chrono>
#include <utility>

using namespace std;

int gcd0(int a, int b) {
    return b ? gcd0(b, a % b) : a;
}

int gcd0iter(int a, int b) {
    while (b) {
        a %= b;
        a += b;
        b = a - b;
        a = a - b;
    }
    return a;
}

int gcd0iterNoZa4em(int a, int b) {
    while (b) {
        a %= b;
        int t = a;
        a = b;
        b = t;
    }
    return a;
}

int binary_gcd(int u, int v) {
    int shift, t;
    if (u == 0) return v;
    if (v == 0) return u;
    for (shift = 0; ((u | v) & 1) == 0; ++shift) {
        u >>= 1;
        v >>= 1;
    }
    while ((u & 1) == 0) u >>= 1;
    do {
        while ((v & 1) == 0) v >>= 1;
        if (u > v) t = v, v = u, u = t;
        v = v - u;
    } while (v != 0);
    return u << shift;
}

long long gcd(long long a, long long b, long long &u, long long &v) {
    a = abs(a);
    b = abs(b);

    long long k = 1;
    while (a & 1 == 0 && b & 1 == 0) {
        a >>= 1; b >>= 1; k <<= 1;
    }

    long long p = 1, q = 0, r = 0, s = 1;
    while (a && b) {
        if (a >= b) {
            a -= b; p -= r; q -= s;
        } else {
            b -= a; r -= p; s -= q;
        }
    }
    if (a) {
        u = q;
        v = k * a;
        return p;
    } else {
        u = s;
        v = k * b;
        return r;
    }
}

void diofant(long long a, long long b, long long c) {
    long long u, v;
    long long ans = gcd(a, b, u, v);
//    cout << ans[0] << " * " << a << " + " << ans[1] << " * " << b << " = " << ans[2] << "\n";

    if (c % v == 0) {
        long long dd = c/v;
        ans *= dd;
        b *= dd;
//        cout << ans[0] << " * " << a << " + " << ans[1] << " * " << b << " = " << c << "\n";
    } else {
//        cout << "s * " << a << " + t * " << b << "= " << c << "has no answer in integer numbers\n";
    }
}

void doTask() {
    diofant(66, 15, 21);
    diofant(7705636, 7121729, 7519);
    diofant(2101106450462279, 628817143587126, 45162);
}

int main() {
    int n= 10000000;
    auto t1 = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < n; ++i) {
        doTask();
    }
    auto t2 = std::chrono::high_resolution_clock::now();

    auto duration = std::chrono::duration_cast<std::chrono::microseconds>( t2 - t1 ).count();
    cout<<"executed "<<n<<" runs in "<<duration<<" microseconds\n";
    cout<<"Average run =  "<<duration/n<<" microseconds\n";


    return 0;
}
