# This file calculates the standard costs (runtime and communication cost) of an operation in verilog

from getresults import GetResults
import pickle
from collections import OrderedDict
import numpy as np
from verilogcomponents import createMaxpool, createdotproduct , createFC
import os
from testrun import CreateRunTest
import random

def getOpProps(weights):
    '''Find out the proportion of each type of weight in the operation'''
    ops = []
    props = []

    if len(weights.shape) == 4:
        # Convolution
        conv_size = weights.shape[2]*weights.shape[2]
        ops = list(range(conv_size + 1))
        props = [0 for _ in range(conv_size + 1)]
        for i in range(weights.shape[0]):
            for j in range(weights.shape[1]):
                valid_size = np.sum(weights[i,j] != 0)
                props[valid_size] += 1.0
    else:
        # FC
        dp_size = weights.shape[1]
        ops = list(range(dp_size + 1))
        props = [0 for _ in range(dp_size + 1)]
        for i in range(weights.shape[0]):
            valid_size = np.sum(weights[i] != 0)
            props[valid_size] += 1.0                

    props = props / np.sum(props)

    return ops, props

def getcosts_conv(op_size):
    '''Get cost of convolution operation'''
    dirname = os.path.dirname(__file__)
    filename = os.path.join(dirname, createdotproduct(op_size, dirname))
    off, on, com = CreateRunTest(filename, "CONV") 

    return off, on, com

def getcosts_fc(input_f, output_f, valid, numvalid):
    '''Get cost of fully connected operation'''
    dirname = os.path.dirname(__file__)
    filename = os.path.join(dirname, createFC(random.randint(1,100), input_f, output_f, valid, numvalid, dirname))
    off, on, com = CreateRunTest(filename, "FC") 

    return off, on, com


def getcosts_mp(op_size, i_lh, i_d):
    '''Get cost of maxpool operation'''
    dirname = os.path.dirname(__file__)
    filename = os.path.join(dirname, createMaxpool(random.randint(1,100), i_lh, i_d, op_size, dirname))
    off, on, com = CreateRunTest(filename, "MP") 

    return off, on, com

def StandardCosts(name, i_lh, i_d, weights=None):
    '''Main function that calculates the standard costs. If weights are not given, it uses values observed from a previous experiment.'''
    num_operations = i_lh*i_lh*i_d

    offline = 0
    online = 0
    communication = 0

    if name.startswith('conv'):
        size = int(name.split("_")[1])
        ops, props = None, None
        if weights == None:
            if size == 3:
                ops = [6,7,8,9]
                props = [0.05, 0.35, 0.48, 0.12]
            elif size == 5:
                ops = [16,17,18,19,20,21,22,23,24,25]
                props = [0.09,0.07,0.12,0.15,0.17,0.14,0.10,0.08,0.05,0.03]
        else:
            ops, props = getOpProps(weights[name])

        off, on, com = [], [], []
        for i in range(len(ops)):
            if props[i] > 0.0001:
                off_op, on_op, com_op = getcosts_conv(ops[i])
                off.append(props[i]*off_op)
                on.append(props[i]*on_op)
                com.append(props[i]*com_op)
            else:
                off.append(0.0)
                on.append(0.0)
                com.append(0.0)

        offline += sum(off)*num_operations
        online += sum(on)*num_operations
        communication += sum(com)*num_operations
    
    elif name.startswith('fc'):
        if weights != None:
            out_size = weights.shape[0]
            valid = (weights != 0).astype(int).flatten()
            numvalid = np.sum(valid)
            off_op, on_op, com_op = getcosts_fc(num_operations, out_size, valid, numvalid)
        else:
            off_op, on_op, com_op = getcosts_fc(num_operations, 10, np.ones(num_operations*10), num_operations*10)
        
        offline += off_op
        online += on_op
        communication += com_op
    
    elif name.startswith('mp'):
        off_op, on_op, com_op = getcosts_mp(int(name.split("_")[1]), i_lh, i_d)
        offline += off_op
        online += on_op
        communication += com_op        

    return offline, online, communication


if __name__=="__main__":
    with open('weights.dat', 'rb') as f:
        x = pickle.load(f)
        print(x.keys())
        for key in x.keys():
            print(x[key].shape)
            print(StandardCosts(key, 32, 3, x[key]))
