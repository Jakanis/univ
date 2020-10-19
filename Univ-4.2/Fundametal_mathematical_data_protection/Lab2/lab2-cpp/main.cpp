#include <iostream>
#include <c++/4.8.3/chrono>
#include <c++/4.8.3/vector>

std::vector <std::vector<double>> Multiply(std::vector <std::vector<double>> &a, std::vector <std::vector<double>> &b){
    const int n = a.size();
    const int m = a[0].size();
    const int p = b[0].size();

    std::vector <std::vector<double>> c(n, std::vector<double>(p, 0));
    for (auto j = 0; j < p; ++j)
        for (auto k = 0; k < m; ++k)
            for (auto i = 0; i < n; ++i)
                c[i][j] += a[i][k] * b[k][j];
    return c;
}


int main() {
    int n= 1000000;

    auto t1 = std::chrono::high_resolution_clock::now();
        for (int i = 0; i < n; i++) {
            std::vector <std::vector<double>> p (3, std::vector<double>(3));
            p[0][0] = 0.1; p[1][0] = 0.4; p[2][0] = 0.5;
            p[0][1] = 0.2; p[1][1] = 0.5; p[2][1] = 0.3;
            p[0][2] = 0.7; p[1][2] = 0.2; p[2][2] = 0.1;

            std::vector <std::vector<double>> p0(3, std::vector<double>(1));
            p0[0][0] = 0.2; p0[1][0] = 0.4; p0[2][0] = 0.4;
            std::vector <std::vector<double>> p2 = Multiply(p, p);
            std::vector <std::vector<double>> p3 = Multiply(p2, p);
            std::vector <std::vector<double>> p4 = Multiply(p3, p);
            std::vector <std::vector<double>> p0p3 = Multiply(p3, p0);
            std::vector <std::vector<double>> p0p4 = Multiply(p4, p0);

            /*for (int i=0; i<p0p4.size(); ++i){
                for(int j=0; j<p0p4[i].size(); ++j){
                    std::cout<<p0p4[i][j]<<" ";
                }
                std::cout<<std::endl;
            }*/

    }
    auto t2 = std::chrono::high_resolution_clock::now();

    auto duration = std::chrono::duration_cast<std::chrono::nanoseconds>( (t2 - t1) ).count();
    std::cout<<"executed "<<n<<" runs in "<<duration<<" ns\n";
    std::cout<<"Average run =  "<<duration/n<<" ns\n";
    return 0;
}
