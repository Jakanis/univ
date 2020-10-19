package io.jakanis;

import java.util.List;

import static java.lang.Math.abs;

public class Main {

    static List<Long> gcd(long a, long b) {
        a = abs(a);
        b = abs(b);

        long k = 1;
        while (a % 2 == 0 && b % 2 == 0) {
            a /= 2;
            b /= 2;
            k *= 2;
        }

        long p = 1, q = 0, r = 0, s = 1;
        while (a > 0 && b > 0) {
            if (a >= b) {
                a -= b;
                p -= r;
                q -= s;
            } else {
                b -= a;
                r -= p;
                s -= q;
            }
        }
        return a != 0 ? List.of(p, q, k * a) : List.of(r, s, k * b);
    }

    static void diofant(long a, long b, long c, boolean console) {
        if (console) {
            System.out.println("a = " + a);
            System.out.println("b = " + b);
            System.out.println("c = " + c);
        }
        List<Long> ans = gcd(a, b);
        long u = ans.get(0);
        long v = ans.get(1);
        long d = ans.get(2);
        long s = 0, t = 0;
        if (console) {
            System.out.println(u + " * " + a + " + " + v + " * " + b + " = " + d);
        }

        if (c % d == 0) {
            s = u * (c / d);
            t = v * (c / d);
            if (console)
                System.out.println(s + " * " + a + " + " + t + " * " + b + " = " + c);
        } else {
            if (console)
                System.out.println("s * " + a + " + t * " + b + " = " + c + " has no answer in integer numbers");
        }
        if (console) {
            System.out.println("d = " + d);
            System.out.println("u = " + u);
            System.out.println("v = " + v);
            System.out.println("s = " + s);
            System.out.println("t = " + t);
            System.out.println("---------------------------------------");
        }
    }

    static void doTask() {
        diofant(66, 15, 21, true);
        diofant(7705636, 7121729, 7519, true);
        diofant(2101106450462279L, 628817143587126L, 45162, true);
    }

    static void doTask(boolean console) {
        diofant(66, 15, 21, console);
        diofant(7705636, 7121729, 7519, console);
        diofant(2101106450462279L, 628817143587126L, 45162, console);
    }

    public static void main(String[] args) {
        int n = 10000000;
        long startTime = System.nanoTime();
        for (int i = 0; i < n; i++) {
            doTask(false);
        }
        long endTime = System.nanoTime();
        long res = (endTime-startTime)/1000;
        System.out.println(n+" runs in " + res + " microseconds");
        System.out.println("Average run = " + res / n + " microseconds");
    }
}

