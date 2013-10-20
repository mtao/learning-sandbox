#include "neural_network.h"
#include <iostream>
#include <cmath>
struct Tanh: public Neuron_T<Tanh> {
    double operator()(double x) const {
        return std::tanh(x);
    }
    double p(double x) const {
        return 1.0 / (std::pow(std::cosh(x),2.0));
    }
};
struct Logistic: public Neuron_T<Logistic> {
    double operator()(double x) const {
        return 1.0/(1+std::exp(x));
    }
    double p(double x) const {
        const double v = (*this)(x);
        return v * (1 - v);
    }
};


int main( int argc, char * argv[] ) {

    std::vector<unsigned int> top({2,1,2,1,1});
    HomogeneousNeuralNetwork<Logistic> net(top);
    Neuron_T<Logistic> l;
    int count=0;
    bool converged = false;
    double threshold = 1e-6;
    for(int i=0; i < 1000000; ++i) {
        if(converged) {
            std::cout << "Converged!" << std::endl;
            break;
        }
        double error = std::numeric_limits<double>::min();
        for(int j=-1; j < 2; ++j) {
            Eigen::VectorXd x(top.front());
            x(0) = (j)*.1;
            for(int k=-1; k < 2; ++k) {
                x(1) = (k)*.1;
                Eigen::VectorXd y(top.back());
                y(0) = l(l(0.5 * l(l(x(0))) - 2.0 * l(2.0*l(x(1))) ));
                net.backpropagate(x,y,0.11);
                error = std::max((net(x)-y).lpNorm<Eigen::Infinity>(),error);
                if(++count %10000 == 0) {
                    std::cout << "Error: " << (error < threshold) << " " << error  << std::endl;
                }
            }
        }
                if(error < threshold) {
                    std::cout << "Final Error: " << (error < threshold) << " " << error  << std::endl;
                    std::cout << count << " iterations" << std::endl;
                    converged=true;
                    break;
                }
        /*
        for(int a=0; a < 2; ++a) {
            for(int b=0; b < 2; ++b) {
                Eigen::VectorXd x(2);
                x(0) = a;
                x(1) = b;
                Eigen::VectorXd y(1);
                y(0) = double(bool(a)&bool(b));
                net.backpropagate(x,y,0.1);
                std::cout << int(net(x)(0)+.5) << " " <<  y  << std::endl;
            }
        }
        */
    }
        for(int j=-1; j < 2; ++j) {
            Eigen::VectorXd x(top.front());
            x(0) = (j)*.1;
            for(int k=-1; k < 2; ++k) {
                x(1) = (k)*.1;
                Eigen::VectorXd y(top.back());
                y(0) = l(l(0.5 * l(l(x(0))) - 2.0 * l(2.0*l(x(1))) ));
                std::cout << "Neuron: " << net(x)- y << std::endl;
            }
        }
}
