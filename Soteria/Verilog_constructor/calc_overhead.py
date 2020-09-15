from collections import OrderedDict
import numpy as np
import pickle
import re
import os
from standard_costs import StandardCosts
import sys

def cleanup_arch(arch):
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
        if 'fc' in op_name:
            kernel_size = re.findall('out_features=([0-9]+)', op)[0]
        
        if op_type.startswith("MaxPool") and not op_name.startswith("mp"):
            continue
        
        res_arch.append((op_name + "_" + kernel_size, op_type))
        
    return res_arch

  

if __name__=="__main__":
    tsc_freq_GHz = sys.argv[1]
    input_size_lh = sys.argv[2] # INPUT SIZE LENGTH/WIDTH
    input_size_d = sys.argv[3] # INPUT SIZE DEPTH

    dirname = os.path.dirname(__file__)
    architecture = cleanup_arch(open(os.path.join(dirname, "TNN_mini/model_architecture.dat")).read())

    runtime_offline = 0
    runtime_online = 0
    communication = 0

    for name, op_type in architecture:
        print(name, op_type)
        rt_off, rt_on, cm = StandardCosts(name, input_size_lh, input_size_d)
        
        runtime_offline += rt_off
        runtime_online += rt_on
        communication += cm

    communication_MB = float(communication)/(8*1024*1024)
    offline_ms = round(runtime_offline*1000.0/tsc_freq_GHz, 2)
    online_ms = round(runtime_online*1000.0/tsc_freq_GHz, 2)

    print("Offline = {} ms\nOnline = {} ms\nCommunication = {} MB".format(offline_ms, online_ms, communication_MB))