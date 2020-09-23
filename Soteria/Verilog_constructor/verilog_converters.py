# This file contains the functions for defining the module calls in verilog main module.

import numpy as np
import os
import verilogcomponents

operation_counter = 0
dotp_needed = []
includes = []


def create_dp_file(dp_size):
    dirname = os.path.dirname(__file__)
    filename = verilogcomponents.createdotproduct(dp_size, dirname)
    return filename

def finalize():
    global includes
    for dp_size in dotp_needed:
        filename = create_dp_file(dp_size)
        includes.append(filename)
    return includes


def getdotproductcombi(n, g_start, e_start, o_var, gi, gj, inp_name, IMAGE_SIZE_H, IMAGE_SIZE_L, KERNEL_SIZE, choices=None):
    name = inp_name.split("_")[0]
    global operation_counter
    call = ""
    g_inputs = [inp_name + '[' + str(g_start + gi*IMAGE_SIZE_L + gj + x) + ']' for x in range(KERNEL_SIZE)] + \
               [inp_name + '[' + str(g_start + (gi+1)*IMAGE_SIZE_L + gj + x) + ']' for x in range(KERNEL_SIZE)] + \
               [inp_name + '[' + str(g_start + (gi+2)*IMAGE_SIZE_L + gj + x) + ']' for x in range(KERNEL_SIZE)]

    if KERNEL_SIZE == 5:
        g_inputs += [inp_name + '[' + str(g_start + (gi+3)*IMAGE_SIZE_L + gj + x) + ']' for x in range(KERNEL_SIZE)] + \
                    [inp_name + '[' + str(g_start + (gi+4)*IMAGE_SIZE_L + gj + x) + ']' for x in range(KERNEL_SIZE)]

    e_inputs = ['e_input[' + str(e_start + x) + ']' for x in range(KERNEL_SIZE*KERNEL_SIZE)]

    g_chosen = "{" + ", ".join([g_inputs[i] for i in choices]) + "}"
    e_chosen = "{" + ", ".join([e_inputs[i] for i in choices]) + "}"

    call = "    dotproduct{} operation_{}{}(.clk (clk), .rst (rst), .g_input ({}), .e_input({}), .o ({}[{}]));\n".format(n, "conv", operation_counter, g_chosen, e_chosen, o_var, gi*(IMAGE_SIZE_L-2*(KERNEL_SIZE//2))+gj)

    operation_counter += 1
    return call


def getdotproductcombi_fc(n, g_start, e_start, o_var, i, inp_name, NUM_INPUTS, choices=None):
    name = inp_name.split("_")[0]
    global operation_counter
    call = ""
    g_inputs = [inp_name + '[' + str(g_start + x) + ']' for x in range(NUM_INPUTS)]

    e_inputs = ['e_input[' + str(e_start + x) + ']' for x in range(NUM_INPUTS)]

    g_chosen = "{" + ", ".join([g_inputs[i] for i in choices]) + "}"
    e_chosen = "{" + ", ".join([e_inputs[i] for i in choices]) + "}"

    call = "    dotproduct{} operation_{}{}(.clk (clk), .rst (rst), .g_input ({}), .e_input({}), .o ({}[{}]));\n".format(n, "fc", operation_counter, g_chosen, e_chosen, o_var, gi*(IMAGE_SIZE_L-2)+gj)

    operation_counter += 1
    return call


def getverilog_conv(name, inp_name, weights, i_lh, i_d, counter):
    global dotp_needed
    shape = weights.shape
    assert shape[2] == shape[3]
    KERNEL_SIZE = shape[2]
    assert i_d == shape[1]
    kernels = shape[0]
    IMAGE_SIZE_H, IMAGE_SIZE_L = i_lh, i_lh 
    outputs = []
    conv_code = ""
    initializations = ""
    
    for i in range(kernels):
        for j in range(i_d):
            choices = np.argwhere(weights[i,j].flatten() != 0).flatten()
            num_active = len(choices)
            if num_active not in dotp_needed:
                dotp_needed.append(num_active)

            g_start = IMAGE_SIZE_H*IMAGE_SIZE_L*j
            g_end = g_start + IMAGE_SIZE_H*IMAGE_SIZE_L - 1
            e_start = counter
            e_end = counter + KERNEL_SIZE*KERNEL_SIZE - 1

            counter = counter + KERNEL_SIZE*KERNEL_SIZE
            for gi in range(IMAGE_SIZE_H-2*(KERNEL_SIZE//2)):
                for gj in range(IMAGE_SIZE_L-2*(KERNEL_SIZE//2)):
                    conv_code = conv_code + getdotproductcombi(num_active, g_start, e_start, "{}_{}_{}".format(name,i,j), gi, gj, inp_name, IMAGE_SIZE_H, IMAGE_SIZE_L, KERNEL_SIZE, choices)

            initializations = initializations + "bit [{}:0] {}_{}_{};\n".format((IMAGE_SIZE_L-2*(KERNEL_SIZE//2))*(IMAGE_SIZE_H-2*(KERNEL_SIZE//2)) - 1, name, i, j)
            outputs.append("{}_{}_{}".format(name, i,j))
    
    conv_code += "    assign " + name + "_res = {" + ", ".join(outputs) + "};\n\n"
    name = name + "_res"
    initializations = initializations + "bit [{}:0] {};\n".format((IMAGE_SIZE_L-2*(KERNEL_SIZE//2))*(IMAGE_SIZE_H-2*(KERNEL_SIZE//2))*kernels*i_d - 1, name)
    return i_lh-2*(KERNEL_SIZE//2), kernels, conv_code, initializations, name, counter


def getverilog_fc_nobn(name, inp_name, weights, i_lh, i_d, counter):
    global dotp_needed
    shape = weights.shape
    NUM_NODES = shape[0]
    NUM_INPUTS = shape[1]
    assert NUM_INPUTS == i_d*i_lh*i_lh
    dotp_needed = []
    outputs = []
    fc_code = ""
    initializations = ""
    
    for i in range(NUM_NODES):
        choices = np.argwhere(weights[i].flatten() != 0).flatten()
        num_active = len(choices)
        if num_active not in dotp_needed:
            dotp_needed.append(num_active)

        g_start = NUM_INPUTS*i
        g_end = g_start + NUM_INPUTS - 1
        e_start = counter
        e_end = counter + NUM_INPUTS - 1

        counter = counter + NUM_INPUTS
        fc_code = fc_code + getdotproductcombi_fc(num_active, g_start, e_start, "{}_res".format(name), i, inp_name, NUM_INPUTS, choices)

    name = name + "_res"
    initializations = initializations + "bit [{}:0] {};\n".format(NUM_NODES - 1, name)

    return 1, NUM_NODES, fc_code, initializations, name, counter


def getverilog_fc(name, inp_name, weights, i_lh, i_d, counter):
    global operation_counter, includes
    shape = weights.shape
    NUM_NODES = shape[0]
    NUM_INPUTS = shape[1]

    assert NUM_INPUTS == i_d*i_lh*i_lh
    num_valid = np.sum(weights != 0, axis=1)
    valid_bits = (weights.flatten() != 0)*1.0

    valid_bits = ["1'b" + str(int(x)) for x in valid_bits]
    numericid = name[2:]
    dirname = os.path.dirname(__file__)
    filename = verilogcomponents.createFC(numid=numericid, ISIZE=NUM_INPUTS, LSIZE=NUM_NODES, valid=valid_bits, num_valid=num_valid, location=dirname)
    
    e_start = counter
    e_end = counter + NUM_INPUTS*NUM_NODES - 1

    e_input_logic = "e_input[{}:{}]".format(e_end, e_start)

    counter = counter + NUM_INPUTS*NUM_NODES

    fc_code = """
    {mod} operation_{modname}{ctr}(
        .clk   (clk),
        .rst   (rst),
        .g_input ({ginp}),
        .e_input ({einp}),
        .o     ({outp})
    );
    """.format(mod=name, modname=name, ctr=operation_counter, ginp=inp_name, einp=e_input_logic, outp=name + "_res")

    name = name + "_res"
    initializations = "bit [{}:0] {};\n".format(NUM_NODES - 1, name)
    operation_counter+=1
    includes.append(filename)

    return 1, NUM_NODES, fc_code, initializations, name, counter



def getverilog_maxp(name, inp_name, i_lh, i_d, counter):
    global operation_counter, includes
    name, pool_size = name.split("_")
    pool_size = int(pool_size)
    numericid = name[2:]
    dirname = os.path.dirname(__file__)
    filename = verilogcomponents.createMaxpool(numid=numericid, ISIZE_L=i_lh, ISIZE_H=i_lh, POOL_SIZE=pool_size, location=dirname)
    maxp_code = ""
    initializations = ""
    outputs = []

    for i in range(i_d):
        g_input = inp_name + "[{}:{}]".format(i_lh*i_lh*(i+1) - 1, i_lh*i_lh*i)
        output = name + "_" + str(i)
        outputs.append(output)

        maxp_code += """
        {mod} operation_{modname}{ctr}(
            .clk   (clk),
            .rst   (rst),
            .g_input ({ginp}),
            .e_input (1'b0),
            .o     ({outp})
        );
        """.format(mod=name, modname = name, ctr=operation_counter, ginp=g_input, outp=output)
        initializations += "bit [{}:0] {}_{};\n".format((i_lh//pool_size)*(i_lh//pool_size) - 1, name, i) 
        operation_counter += 1
    
    maxp_code += "assign " + name + "_res = {" + ", ".join(outputs) + "};\n\n"
    name = name + "_res"
    initializations = initializations + "bit [{}:0] {};\n".format((i_lh//pool_size)*(i_lh//pool_size)*i_d - 1, name)
    includes.append(filename)

    return i_lh//pool_size, i_d, maxp_code, initializations, name, counter


def getverilog_pad(name, inp_name, i_lh, i_d, counter):
    global operation_counter, includes
    name, pad_size = name.split("_")
    pad_size = int(pad_size)
    numericid = name[3:]
    dirname = os.path.dirname(__file__)
    filename = verilogcomponents.createPad(numid=numericid, ISIZE_L=i_lh, ISIZE_H=i_lh, PAD_SIZE=pad_size, location=dirname)
    pad_code = ""
    initializations = ""
    outputs = []

    for i in range(i_d):
        g_input = inp_name + "[{}:{}]".format(i_lh*i_lh*(i+1) - 1, i_lh*i_lh*i)
        output = name + "_" + str(i)
        outputs.append(output)

        pad_code += """
        {mod} operation_{modname}{ctr}(
            .clk   (clk),
            .rst   (rst),
            .g_input ({ginp}),
            .e_input (1'b0),
            .o     ({outp})
        );
        """.format(mod=name, modname = name, ctr=operation_counter, ginp=g_input, outp=output)
        initializations += "bit [{}:0] {}_{};\n".format((i_lh + 2*pad_size)*(i_lh + 2*pad_size) - 1, name, i) 
        operation_counter += 1
    
    pad_code += "assign " + name + "_res = {" + ", ".join(outputs) + "};\n\n"
    name = name + "_res"
    initializations = initializations + "bit [{}:0] {};\n".format((i_lh + 2*pad_size)*(i_lh + 2*pad_size)*i_d - 1, name)
    includes.append(filename)

    return i_lh + 2*pad_size, i_d, pad_code, initializations, name, counter
