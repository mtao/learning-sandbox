#ifndef NEURON_H
#define NEURON_H

class Neuron {
    public:
    virtual double operator()(double x) const = 0;
    virtual double p(double x) const = 0; //partial
};

#include <Eigen/Dense>

//This class is identical to Neuron except without virtual calls
template <typename Derived>
class Neuron_T {
    public:
        Derived& derived() {return *static_cast<Derived*>(this);}
        const Derived& derived() const {return *static_cast<const Derived*>(this);}
        double operator()(double x) const {
            return derived()(x);
        }
        double p(double x) const {
            return derived()(x);
        }

        
        Eigen::VectorXd operator()(const Eigen::VectorXd& x) const {
            Eigen::VectorXd ret(x.rows());
            for(int i=0; i < x.rows(); ++i) {
                ret(i) = (*this)(x(i));
            }
            return ret;
        }
        Eigen::VectorXd p(const Eigen::VectorXd& x) const {
            Eigen::VectorXd ret(x.rows());
            for(int i=0; i < x.rows(); ++i) {
                ret(i) = this->p(x(i));
            }
            return ret;
        }

        

};

#endif
