# This file contains functions to create the module files for each operation.

import constants
import os

def createMaxpool(numid, ISIZE_L, ISIZE_H, POOL_SIZE, location):
    modulename = "mp" + str(numid)
    code = """
module {module}
#(
    parameter ISIZE_L = {il},  
    parameter ISIZE_H = {ih},  
    parameter POOL_SIZE = {ps}
{rem} 
    """.format(module=modulename, il=ISIZE_L, ih=ISIZE_H, ps=POOL_SIZE, rem=constants.maxpool_verilog)

    filename = modulename + ".sv"
    f = open(os.path.join(location, filename), "w+")
    f.write(code)
    f.close()
    return filename

def createPad(numid, ISIZE_L, ISIZE_H, PAD_SIZE, location):
    modulename = "pad" + str(numid)
    code = """
module {module}
#(
    parameter ISIZE_L = {il},  
    parameter ISIZE_H = {ih},  
    parameter PAD_SIZE = {ps}
{rem} 
    """.format(module=modulename, il=ISIZE_L, ih=ISIZE_H, ps=PAD_SIZE, rem=constants.pad_verilog)

    filename = modulename + ".sv"
    f = open(os.path.join(location, filename), "w+")
    f.write(code)
    f.close()
    return filename

def createFC(numid, ISIZE, LSIZE, valid, num_valid, location, threshold=0):
    modulename = "fc" + str(numid)
    code = """
module {module}
#(
    parameter ISIZE = {isz},
    parameter LSIZE = {lsz},
    parameter [(LSIZE*ISIZE - 1):0] valid = {vd},
    parameter integer NUM_VALID [LSIZE-1:0] = {nv},
    parameter threshold = {th}
{rem} 
    """.format(module=modulename, isz=ISIZE, lsz=LSIZE, vd="{"+", ".join(valid)+"}", nv="'{" + ",".join([str(x) for x in num_valid]) + "}", th=threshold, rem=constants.fc_verilog)

    filename = modulename + ".sv"
    f = open(os.path.join(location, filename), "w+")
    f.write(code)
    f.close()
    return filename


def createConv(numid, ISIZE_L, ISIZE_H, CONV_SIZE, valid, num_valid, location, threshold=0):
    modulename = "conv" + str(numid)
    code = """
module {module}
#(
    parameter ISIZE_L = {isl},
    parameter ISIZE_H = {ish},
    parameter CONV_SIZE = {cs},
    parameter [(CONV_SIZE*CONV_SIZE - 1):0] valid = {vd},
    parameter NUM_VALID = {nv},
    parameter threshold = {th}
{rem} 
    """.format(module=modulename, isl=ISIZE_L, ish=ISIZE_H, cs=CONV_SIZE, vd="{"+", ".join(valid)+"}", nv=num_valid, th=threshold, rem=constants.conv_verilog)

    filename = modulename + ".sv"
    f = open(os.path.join(location, filename), "w+")
    f.write(code)
    f.close()
    return filename


def createdotproduct(dp_size, location):
    modulename = "dotproduct" + str(dp_size)
    code = """
module {module}
#(
    parameter ISIZE = {isz}
{rem} 
    """.format(module=modulename, isz=dp_size, rem=constants.dotproduct_verilog)

    filename = modulename + ".sv"
    f = open(os.path.join(location, filename), "w+")
    f.write(code)
    f.close()
    return filename
