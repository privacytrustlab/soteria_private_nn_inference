# Soteria

A system that allows secure machine learning inference in a two-party setting. The system automatically searches for an optimal ternary neural network architecture, trains it, and then builds the requisite files for secure inference.

## Setup

Make sure you have **docker** installed before you set up the docker image. Navigate to the code directory containing the `Dockerfile`, and execute:

    $ docker build ./

This will build the Docker image, and install all the requisite tools required to execute the code. This needs to be run only once. 

It may take a few minutes to complete. An image ID will be returned. Create a container and run bash over the image, using the command:

    $ docker run -it --runtime=nvidia <image-id> /bin/bash

Replace `<image-id>` with the image ID obtained when the docker image is built.

## Architecture Search

The first step is the DARTS Architecture Search, to find a suitable architecture for a given dataset, and then train it. Please see the code and [README file in `Soteria/Architecture_Search`](Soteria/Architecture_Search/README.md) for more details.

## Standard TNN - train

Included is a simple Ternary Neural Network to demonstrate how TNNs work, using the 'MNIST' dataset for simplicity. This will only take a few minutes. To train, simply run:

    $ python3 /app/Soteria/TNN/main.py

This will save a `model_architecture.dat` file containing the architecture components list, and `weights.dat` file containing the ternary weights of the trained model.

Simlarly, to run TNNs over 'CIFAR10' dataset, run:

    $ python3 /app/Soteria/TNN/main_cifar.py

### XONN

We try to reproduce the results for existing work XONN. Please refer to the directory `/app/Soteria/TNN/XONN/` for more details.

## Build and Execute

To build the model in Verilog and execute the secure inference protocol, please refer to the code and [README file in `Soteria/Verilog_constructor`](Soteria/Verilog_constructor/README.md) for more details.

## Code References

Code from the following sources was used and modified to build parts of our system.

#### 1. DARTS

GitHub: https://github.com/MandyMo/DARTS  
Paper: Hanxiao Liu, Karen Simonyan and Yiming Yang. _DARTS: Differentiable Architecture Search_, ICLR 2019.

#### 2. BinaryNet.pytorch

GitHub: https://github.com/itayhubara/BinaryNet.pytorch  
Paper: Itay Hubara, Matthieu Courbariaux, Daniel Soudry, Ran El-Yaniv and Yoshua Bengio. _Binarized Neural Networks_, NIPS 2016.

