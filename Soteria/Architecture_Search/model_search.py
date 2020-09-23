# This file contains the model architecture class used to conduct the search.

from operators import *
import torch
import torch.nn as nn
import torch.nn.functional as F

PRIMITIVES = [
    'identity',        # Optional
    'conv_3x3',
    'max_pool_2x2',
    'conv_5x5',
]

class Node(nn.Module):
    def __init__(self, C_prev, C):
        super(Node, self).__init__()
        self._ops = nn.ModuleList()
        for primitive in PRIMITIVES:
            op = OPS[primitive](C_prev, C)
            self._ops.append(op)
    
    def forward(self, x, weights):
        out = None
        for w, op in zip(weights, self._ops):
            res = w*op(x)
            if out == None:
                out = res
            else:
                out += res
        return out        


class Cell(nn.Module):
    def __init__(self, steps, multiplier, C_prev, C):
        super(Cell, self).__init__()
        self.steps      = steps
        self.multiplier = multiplier

        c_1, c_2 = C_prev, C
        self._ops = nn.ModuleList()
        for i_b in range(self.steps):
            for i_n in range(2):
                self._ops.append(Node(c_1, c_2))
                c_1 = c_2

    def forward(self, s0, weights):
        stats = [s0]
 
        for i_b in range(self.steps):
            for i_n in range(2):
                res = self._ops[2*i_b + i_n](stats[2*i_b + i_n], weights[2*i_b + i_n])
                stats.append(res)
        return stats[-1]

class Network(nn.Module):
    def __init__(self, C, num_classes, layer, steps=2, multiplier=2, tail_scaling_factor=8):
        super(Network, self).__init__()
        self.C = C
        self.num_classes = num_classes
        self.steps = steps
        self.multiplier = multiplier
        self.layer = layer
        C_curr = C
        self.stem = nn.Sequential(
            nn.Conv2d(3, C_curr, 3, padding=1, bias=False),
            nn.BatchNorm2d(C_curr),
            nn.CELU()
        )
        C_prev = C_curr
        self.cells = nn.ModuleList()
        for i_c in range(layer):
            self.cells.append(Cell(steps, multiplier, C_prev, C_curr))
            C_prev, C_curr = C_curr, multiplier*C_curr
        
        self._initialize_alphas()

        self.classifier = nn.Sequential(
            TernaryLinear(C_prev*32*32, 128*tail_scaling_factor, bias = False),
            nn.BatchNorm1d(128*tail_scaling_factor),
            TernaryLinear(128*tail_scaling_factor, 10, bias=False),
            nn.BatchNorm1d(10),
            nn.LogSoftmax()
        )
    
    def weight_manipulation(self, x):
        circuit_complexity_factor = 0.6     #Lambda
        complexities = [0.0, 0.41, 0.04, 1.0]
        weight_factor = torch.tensor([1-circuit_complexity_factor*complexity for complexity in complexities], requires_grad=True).cuda()
        x = x*weight_factor
        x = x/torch.sum(x)
        return x
    
    def forward(self, x):
        s0 = self.stem(x)
        w_alpha_normal    = F.softmax(self.weight_manipulation(self.w_alpha_normal),    1)
        for i_c, cell in enumerate(self.cells):
            s1 = cell(s0, w_alpha_normal)
            s0 = s1
        return self.classifier(s0.view(s0.shape[0], -1))

    def _initialize_alphas(self):
        c_op   = len(PRIMITIVES)
        c_node = sum(2 for i_b in range(self.steps))
        self.register_parameter('w_alpha_normal',    nn.Parameter(torch.rand((c_node, c_op))))