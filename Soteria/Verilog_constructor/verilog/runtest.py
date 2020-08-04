from subprocess import Popen
import time
import os
import argparse
import random
from getresults import GetResults

parser = argparse.ArgumentParser()


parser.add_argument("--ALICE_INPUT_SIZE", help="Alice's input size",
                    default=784, type=int)
parser.add_argument("--BOB_NUM_WEIGHTS", help="Bob - Number of weight parameters",
                    default=944, type=int)
parser.add_argument("--NUM_EXPERIMENTS", help="Number of times experiment is to be run. Default = 5",
                    default=5, type=int)
parser.add_argument("--TG_HOME", help="Path to TinyGarble Home directory",
                    default="/app/Soteria/TinyGarble", type=str)


args = parser.parse_args()

def token_hex(size):
    hex_code = "".join([random.choice(['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f']) for _ in range(size*2)])
    return hex_code

def runTest(bob_weights, alice_input):

    commands = [args.TG_HOME + '/bin/garbled_circuit/TinyGarble --alice --scd_file /app/Soteria/Verilog_constructor/verilog/syn/mlnn.scd --log2std --input ' + alice_input,
                args.TG_HOME + '/bin/garbled_circuit/TinyGarble --bob --scd_file /app/Soteria/Verilog_constructor/verilog/syn/mlnn.scd --log2std --input ' + bob_weights]

    try:
        process0 = Popen(commands[0], shell=True)
        start = time.time()
        process1 = Popen(commands[1], shell=True)
        output0 = process0.wait(timeout=5)
        output1 = process1.wait(timeout=5)

        print(output0, output1)
        print("Total time", round((time.time() - start)*1000, 3))
    except Exception as e:
        print("Timeout Error, skipping" + str(e))
        return -1



alice_input_size_bytes = args.ALICE_INPUT_SIZE//8 + 1

bob_weights_size_bytes = args.BOB_NUM_WEIGHTS//8 + 1


for _ in range(args.NUM_EXPERIMENTS):
    alice_input = token_hex(alice_input_size_bytes)
    bob_weights = token_hex(bob_weights_size_bytes)
    runTest(bob_weights, alice_input)
