#ifndef NEURAL_NETWORK_H
#define NEURAL_NETWORK_H

#include "neuron.h"
#include <Eigen/Dense>
#include <vector>

template <typename NeuronType>
class HomogeneousNeuralNetwork {
    public:
        typedef Neuron_T<NeuronType> Neuron;
        //typedef std::vector<Neuron> NeuronRow;
        typedef Eigen::MatrixXd WeightMatrix;
        typedef Eigen::VectorXd RowValues;

        HomogeneousNeuralNetwork(const std::vector<unsigned int>& topology); 
        size_t num_starts() const;
        size_t num_ends() const;
        void backpropagate(const RowValues& start, const RowValues& target, double learning_rate = 0.2, double error_scaling = 10);

        RowValues operator()(const RowValues& start) const;
    private:
        //std::vector< NeuronRow > m_neurons;
        Neuron m_neuron;
        std::vector<unsigned int> m_topology;
        std::vector< WeightMatrix > m_weights;
};


#include "neural_network.ipl"
#endif
