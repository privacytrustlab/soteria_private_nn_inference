from subprocess import Popen
import time
import os
# from secrets import token_hex
import argparse
import random
import sys

def token_hex(size):
    hex_code = "".join([random.choice(['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f']) for _ in range(size*2)])
    return hex_code

def runTest(TG_HOME, bob_weights, alice_input, filename):
    os.system("chmod +x compile.sh")
    os.system("./compile.sh")
    os.system("~/tc/bin/scd/V2SCD_Main -i syn/mlnn_syn.v -o syn/mlnn.scd")
    commands = [TG_HOME + '/bin/garbled_circuit/TinyGarble --alice --scd_file /app/Soteria/Verilog_constructor/verilog/syn/mlnn.scd --log2std --input ' + alice_input,
                TG_HOME + '/bin/garbled_circuit/TinyGarble --bob --scd_file /app/Soteria/Verilog_constructor/verilog/syn/mlnn.scd --log2std --input ' + bob_weights]

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


def RunTestMain(filename, optype, TG_HOME='/app/Soteria/TinyGarble/'):
    alice_input_size_bytes = 4096
    bob_weights_size_bytes = 4096
    alice_input = token_hex(alice_input_size_bytes)
    bob_weights = token_hex(bob_weights_size_bytes)

    if optype == "MP":
        bob_weights = '0'
    
    runTest(TG_HOME, bob_weights, alice_input, filename)

if __name__=="__main__":
    filename = sys.argv[1]
    optype = sys.argv[2]
    RunTestMain(filename, optype)