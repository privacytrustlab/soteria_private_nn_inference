# Converts a model architecture description along with its weights into verilog.  

from collections import OrderedDict
import numpy as np
import pickle
import re
import os
from verilog_converters import getverilog_conv, getverilog_fc, getverilog_maxp, getverilog_pad, finalize

def cleanup_arch(arch):
    '''Extract relevant components from architecture description'''
    pad_count = 0
    arch = [x for x in arch.split("\n") if ('Ternary' in x or 'MaxPool' in x)]
    res_arch = []
    for op in arch:
        op_name = re.findall('\(([a-z0-9]+)\): ', op)[0]
        op_type = re.findall(': ([A-Za-z0-9]+)\(', op)[0]
        
        kernel_size = ""
        if 'conv' in op_name:
            kernel_size = re.findall('kernel_size=\(([0-9]+), [0-9]+\)', op)[0]
        if 'mp' in op_name:
            kernel_size = re.findall('kernel_size=([0-9]+)', op)[0]
        
        if op_type.startswith("MaxPool") and not op_name.startswith("mp"):
            continue
        if 'padding' in op and 'TernaryConv' in op_type:
            res_arch.append(("pad" + str(pad_count) + "_" + str(int(kernel_size)//2), "Padding"))
            pad_count += 1
        if op_name.startswith('mp'):
            res_arch.append((op_name + "_" + kernel_size, op_type))
            continue

        res_arch.append((op_name, op_type))
    return res_arch


dirname = os.path.dirname(__file__)
weights_file = open(os.path.join(dirname, "TNN_mini/weights.dat"), 'rb')
weights_dict = pickle.load(weights_file)
weights_file.close()

dirname = os.path.dirname(__file__)
architecture = cleanup_arch(open(os.path.join(dirname, "TNN_mini/model_architecture.dat")).read())

print(weights_dict.keys())
for op in weights_dict.keys():
    print(weights_dict[op].shape, end=" ")
    if 'conv' in op:
        print("Convolution")
    elif 'fc' in op:
        print("FC")
print()
print(architecture)


input_size_lh = 28 # INPUT SIZE LENGTH/WIDTH
input_size_d = 1 # INPUT SIZE DEPTH
cur_input_name = "g_input"
initializers_all = ""
counter = 0
include = []
verilog_code_all ="" 
i_lh_orig = input_size_lh
i_d_orig = input_size_d

for name, op_type in architecture:
    print(name, op_type)
    if name.startswith("conv"):
        input_size_lh, input_size_d, verilog_code, initializers, cur_input_name, counter = getverilog_conv(name, cur_input_name, weights_dict[name], input_size_lh, input_size_d, counter)
    elif name.startswith("fc"):
        input_size_lh, input_size_d, verilog_code, initializers, cur_input_name, counter = getverilog_fc(name, cur_input_name, weights_dict[name], input_size_lh, input_size_d, counter)
    elif name.startswith("mp"):
        input_size_lh, input_size_d, verilog_code, initializers, cur_input_name, counter = getverilog_maxp(name, cur_input_name, input_size_lh, input_size_d, counter)
    elif name.startswith("pad"):
        input_size_lh, input_size_d, verilog_code, initializers, cur_input_name, counter = getverilog_pad(name, cur_input_name, input_size_lh, input_size_d, counter)
    
    initializers_all += initializers
    verilog_code_all += verilog_code

include = finalize()

caller_file_code = """
{includes}

module mlnn
#(
    parameter INPUTSIZE = {inputsize}
)
(
    clk,
    rst,
    g_input,
    e_input,
    o
); 

input clk;
input rst;
input bit [INPUTSIZE-1:0] g_input;
input bit [{weightssize}:0] e_input;
output bit [{output_size}:0] o;

{misclogic}

{modulecallslist}

assign o = {last_output_name}; 

endmodule
    """.format(includes="".join(['`include "' + x + '"\n' for x in include]), inputsize=str(i_lh_orig*i_lh_orig*i_d_orig), weightssize=str(counter-1), output_size=str(input_size_lh*input_size_lh*input_size_d-1), misclogic=initializers_all, modulecallslist=verilog_code_all, last_output_name=cur_input_name)

dirname = os.path.dirname(__file__)
f = open(os.path.join(dirname, "multlayer1.sv"), "w+")
f.write(caller_file_code)
f.close()