## Standard TNN training

This is a simple Ternary Neural Network to demonstrate how TNNs work, using the 'MNIST' and 'CIFAR10' datasets for simplicity. This will only take a few minutes. To train on MNIST, simply run:

    $ python3 /app/Soteria/TNN/main.py

This will save a `model_architecture.dat` file containing the architecture components list, and `weights.dat` file containing the ternary weights of the trained model.

Simlarly, to run TNNs over 'CIFAR10' dataset, run:

    $ python3 /app/Soteria/TNN/main_cifar.py

You can create different architectures in the respective files to train them.