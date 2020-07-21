import torch
import torch.nn as nn
from operators2 import *
from utils import *
import numpy as np

PRIMITIVES = [
    'identity',     # Optional
    'conv_3x3',
    'max_pool_2x2',
    'conv_5x5',
]

inputsize = 32


class Cell(nn.Module): 
    def __init__(self, steps, multiplier, C_prev, C, weight):
        super(Cell, self).__init__()
        self.C = C
        self.incrflag = False
        self.C_prev = C_prev
        self.steps = steps
        self.multiplier = multiplier
        self.arch = self._parse_arch_(weight)
        self._compile_(self.arch)

    def _parse_arch_(self, weight):
        arch = []
        for i_b in range(self.steps):
            for i_n in range(2):
                W = 1*(weight[i_b*2 + i_n].copy())
                i_op_best = np.argmax(W)
                op_chosen = PRIMITIVES[i_op_best]
                arch.append((op_chosen, i_b*2 + i_n))

        return arch

    def _compile_(self, arch):
        global inputsize
        self._ops = nn.ModuleList()
        c_1, c_2 = self.C_prev, self.C 
        for (op_name, i_n) in arch:
            if 'max_pool_2x2' in op_name:
                if inputsize >= 2:
                    inputsize = int(inputsize/2)
                else:
                    self._ops.append(OPS['identity'](c_1, c_2))
                    continue

            self._ops.append(OPS[op_name](c_1, c_2))
            if 'conv' in op_name:
                c_1 = c_2
                self.incrflag = True

    def forward(self, s0):
        stats = [s0]

        for i_b in range(self.steps):
            for i_n in range(2):
                res = self._ops[2*i_b + i_n](stats[2*i_b + i_n])
                stats.append(res)

        return stats[-1]


class NetworkCIFAR(nn.Module):
    def __init__(self, C, num_classes, layers, steps=2, multiplier=2, tail_scaling_factor=8, arch=None):
        super(NetworkCIFAR, self).__init__()
        self.layers = layers

        stem_multiplier = 1
        C_curr = C
        self.stem = nn.Sequential(
            nn.Conv2d(3, C_curr, 3, padding=1, bias=False),
            nn.BatchNorm2d(C_curr),
            nn.CELU()
        )

        C_prev = C_curr
        self.cells = nn.ModuleList()
        weight = arch['normal']
        for i_c in range(layers):
            cell = Cell(steps, multiplier, C_prev, C_curr, weight)
            self.cells.append(cell)
            if cell.incrflag:
                C_prev, C_curr = C_curr, multiplier*C_curr

        self.classifier = nn.Sequential(
            TernaryLinear(C_prev*inputsize*inputsize, 128*tail_scaling_factor, bias = False),
            nn.BatchNorm1d(128*tail_scaling_factor),
            TernaryLinear(128*tail_scaling_factor, 10, bias=False),
            nn.BatchNorm1d(10),
            nn.LogSoftmax()
        )

    def forward(self, input):
        logits_aux = None
        s0 = self.stem(input)
        for i, cell in enumerate(self.cells):
            s1 = cell(s0)
            s0 = s1
        logits = self.classifier(s0.view(s0.shape[0], -1))
        return logits, logits_aux