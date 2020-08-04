from getresults import GetResults

def getOpProps(weights):
    return None, None

def getcosts_conv(op_size):
    
    return None, None, None

def getcosts_fc(input_f, output_f):
    
    return None, None, None

def getcosts_mp(op_size):
    
    return None, None, None

def StandardCosts(name, i_lh, i_d, weights=None):
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
            off_op, on_op, com_op = getcosts_conv(ops[i])
            off.append(props[i]*off_op)
            on.append(props[i]*on_op)
            com.append(props[i]*com_op)

        offline += sum(off)*num_operations
        online += sum(on)*num_operations
        communication += sum(com)*num_operations
    
    elif name.startswith('fc'):
        off_op, on_op, com_op = getcosts_fc(num_operations, int(name.split("_")[1]))
        offline += off_op
        online += on_op
        communication += com_op
    
    elif name.startswith('mp'):
        off_op, on_op, com_op = getcosts_mp(num_operations, int(name.split("_")[1]))
        offline += off_op
        online += on_op
        communication += com_op        

    return offline, online, communication