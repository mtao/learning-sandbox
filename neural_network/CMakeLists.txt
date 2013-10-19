cmake_minimum_required(VERSION 2.8.9)
PROJECT(NeuralNetwork)

SET(CMAKE_RUNTIME_OUTPUT_DIR ${PROJECT_BINARY_DIR}/bin)
SET(CMAKE_LIBRARY_OUTPUT_DIR ${PROJECT_BINARY_DIR}/lib)
SET(CMAKE_ARCHIVE_OUTPUT_DIR ${PROJECT_BINARY_DIR}/lib)

ADD_DEFINITIONS(-std=c++11)
ADD_DEFINITIONS(-Werror)

# Include dirs
INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/include /usr/include/eigen3)

# Source files
SET(NeuralNetwork_SOURCES
    src/main.cpp
    )
# Include files
SET(NeuralNetwork_HEADERS
    include/neural_network.h
    include/neural_network.ipl
    include/neuron.h
    include/util.h
    )
SET(NeuralNetwork_SOURCES ${NeuralNetwork_SOURCES} ${NeuralNetwork_HEADERS})


# Executable to build
ADD_EXECUTABLE(NeuralNetwork
    ${NeuralNetwork_SOURCES}
    )
