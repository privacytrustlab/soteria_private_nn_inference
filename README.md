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

## TNN training

Included is code for training any manually defined TNN on MNIST and CIFAR10 datasets, without going through the Architecture Search process. Please see the code and [README file in `Soteria/TNN`](Soteria/TNN/README.md) for more details. 

### XONN

We try to reproduce the results for existing work XONN. Please refer to the directory `Soteria/TNN/XONN/` for more details.

## Build and Execute

To build the model in Verilog and execute the secure inference protocol, please refer to the code and [README file in `Soteria/Verilog_constructor`](Soteria/Verilog_constructor/README.md) for more details. You will also find some automated scripts to run the tests and generate the outputs in the directory. Further, scripts used to generate the different results in the paper are also provided, and references to those scripts are made in the README file in the directory.

## Code References

Code from the following sources was used and modified to build parts of our system.

#### 1. DARTS

GitHub: https://github.com/MandyMo/DARTS  
Paper: Hanxiao Liu, Karen Simonyan and Yiming Yang. _DARTS: Differentiable Architecture Search_, ICLR 2019.

#### 2. BinaryNet.pytorch

GitHub: https://github.com/itayhubara/BinaryNet.pytorch  
Paper: Itay Hubara, Matthieu Courbariaux, Daniel Soudry, Ran El-Yaniv and Yoshua Bengio. _Binarized Neural Networks_, NIPS 2016.

