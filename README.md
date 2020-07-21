# Soteria

## Setup

Make sure you have **docker** installed before you 

Set up the docker image. Navigate to the code directory containing the `Dockerfile`, and execute:

    $ docker build ./

This will build the Docker image, and install all the requisite tools required to execute the code. This needs to be run only once. 

It may take a few minutes to complete. An image ID will be returned. Create a container and run bash over the image, using the command:

    $ docker run -it --runtime=nvidia <image-id> /bin/bash

Replace `<image-id>` with the image ID obtained when the docker image is built.

## Architecture Search

#### Steps

1. First, a suitable model for a given dataset is searched using DARTS architecture search. 
    - The included code uses the 'CIFAR10' dataset.
2. Then, the model is trained fully.

Executing this code may take a few hours, depending on your machine configuration.

#### Search model

    $ python3 /app/Soteria/Architecture_Search/train_search.py

This will save a architecture pickle file `nas_arch.pkl` under directory `/app/Soteria/Architecture_Search/trained_model`. 

**If a pre-searched DARTS architecture exists:** Place the architecture pickle file in this directory.

#### Train searched model

    $ python3 /app/Soteria/Architecture_Search/train.py

This will train the model fully.

## Standard TNN - train

Included is a simple Ternary Neural Network to demonstrate how TNNs work, using the 'MNIST' dataset for simplicity. This will only take a few minutes. To train, simply run:

    $ python3 /app/Soteria/TNN/main.py

This will save a `model_architecture.dat` file containing the architecture components list, and `weights.dat` file containing the ternary weights of the trained model.

Simlarly, to run TNNs over 'CIFAR10' dataset, run:

    $ python3 /app/Soteria/TNN/main_cifar.py

## Build Verilog

To build the SystemVerilog code from the saved model architecture and weights from the previous step, run:

    $ python3 /app/Soteria/Verilog_constructor/convert_verilog.py

Make sure to set values `input_size_lh` (LENGTH/WIDTH of input) and `input_size_d` (DEPTH of input) in file `convert_verilog.py` at line nos. 54, 55 before executing the build script. These values correspond to the first ternary layer of the architecture. The values have been set for the architecture trained in the previous step.

This will generate a SystemVerilog file `multlayer1.sv` along with attached module `.sv` files for the model under the directory `/app/Soteria/Verilog_constructor`.

#### Example provided

A very small network has been trained and used to generate the SystemVerilog code for demonstration of protocol execution. This can be found in the directory `/app/Soteria/Verilog_constructor/TNN_mini`. The `convert_verilog.py` script has been executed on the weights and architecture of the model, and the resultant verilog code is stored in directory `/app/Soteria/Verilog_constructor/verilog`.

**If pre-trained model and corresponding saved weights file exist:** Place the files in the directory `/app/Soteria/Verilog_constructor/TNN_mini`. Note that if the number of operations/size of operations is large, it may take up to a few hours to build and synthesize the subsequent Verilog files. The example provided builds in a couple of seconds, and synthesizes in a few minutes.

**If previously generated SystemVerilog file exists:** Place the generated `.sv` file along with the attached module `.sv` files in the directory `/app/Soteria/Verilog_constructor`.

## Synthesize

Synthesize the main file `multlayer1.sv` into a netlist file using Synopsys DC.

This will generate a `<synthfilename.v>` file in the directory `/app/Soteria/Verilog_constructor`.

#### Example provided

A pre-synthesized version of the SystemVerilog code generated for the model above can be found as file `syn/mlnn.v` in directory `/app/Soteria/Verilog_constructor/verilog`.

## Run Garbled Circuit test

### Create the .scd file

Create the 'Simple Circuit Description' (`.scd`) file from the synthesized netlist file using `V2SCD_Main` utility that ships with TinyGarble package.

    $ /app/Soteria/TinyGarble/bin/scd/V2SCD_Main -i <path-to-synthfilename.v> -o /app/Soteria/Verilog_constructor/mlnn.scd

#### Example provided

A pre-generated SCD file for the synthesized netlist file generated above can be found as file `syn/mlnn.scd` in directory `/app/Soteria/Verilog_constructor/verilog`.

### Execute the test

Run the Garbled Circuit using the `TinyGarble` utility. For a simple test, run:
    
    $ /app/Soteria/TinyGarble/bin/garbled_circuit/TinyGarble --alice --scd_file /app/Soteria/Verilog_constructor/mlnn.scd --input <hex-input>

Provide Alice's binary inputs in a single hexadecimal input string. The command will wait for Bob's process to be executed before it completes.

Spawn a separate terminal:

    $ docker exec -it <container-id> /bin/bash

Replace `<container-id>` with the Container ID used in the previous step. Then run Bob's process:

    $ /app/Soteria/TinyGarble/bin/garbled_circuit/TinyGarble --bob --scd_file /app/Soteria/Verilog_constructor/mlnn.scd --input <hex-input>

Provide Bob's binary inputs in a single hexadecimal input string. This will generate the output in hexadecimal. On the other terminal, Alice's process will also simultaneously complete. 

#### Example provided

To run the experiment automatically using generated SCD and netlist files in the example above, using random inputs for the secure layers, can be executed by running:

    $ python3 /app/Soteria/Verilog_constructor/verilog/runtest.py

This will automatically create two separate processes and run the test, generating the output.

For the model SystemVerilog file generated and synthesized in the previous steps, the time for execution of Bob's process is ~20 ms including overheads, using an Intel Xeon 8124M processor @3.0 GHz.