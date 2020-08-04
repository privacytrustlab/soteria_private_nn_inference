import torch
import pdb
import torch.nn as nn
import math
from torch.autograd import Variable
from torch.autograd import Function
import numpy as np

def Binarize(tensor):
    return ((((tensor.sign() + 1.0)/3.0).round())*2.0 - 1.0).type(torch.FloatTensor).cuda()


class BinaryLinear(nn.Linear):

    def __init__(self, *kargs, **kwargs):
        super(BinaryLinear, self).__init__(*kargs, **kwargs)

    def forward(self, input):

        input.data=Binarize(input.data)
        if not hasattr(self.weight,'org'):
            self.weight.org=self.weight.data.clone()
        self.weight.data=Binarize(self.weight.org)
        out = nn.functional.linear(input, self.weight)

        return out

class BinaryConv2d(nn.Conv2d):

    def __init__(self, *kargs, **kwargs):
        super(BinaryConv2d, self).__init__(*kargs, **kwargs)


    def forward(self, input):
        input.data = Binarize(input.data)
        if not hasattr(self.weight,'org'):
            self.weight.org=self.weight.data.clone()
        self.weight.data=Binarize(self.weight.org)

        out = nn.functional.conv2d(input, self.weight, None, self.stride,
                                   self.padding, self.dilation, self.groups)
        return out
