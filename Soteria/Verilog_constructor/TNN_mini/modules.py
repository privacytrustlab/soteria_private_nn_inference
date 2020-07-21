import torch
import pdb
import torch.nn as nn
import math
from torch.autograd import Variable
from torch.autograd import Function
import numpy as np

def Binarize(tensor):
    return ((((tensor.sign() + 1.0)/3.0).round())*2.0 - 1.0).type(torch.FloatTensor).cuda()
    


def Delta(tensor):
    c = 0.7
    n = tensor[0].nelement()
    if(len(tensor.size()) == 4):     #convolution layer
        delta = c * tensor.norm(1,3).sum(2).sum(1).div(n)
    elif(len(tensor.size()) == 2):   #fc layer
        delta = c * tensor.norm(1,1).div(n)
    return delta


def Ternarize(tensor):
    output = torch.cuda.FloatTensor(tensor.size()).fill_(0)
    delta = Delta(tensor)
    for i in range(tensor.size()[0]):
        for w in tensor[i].view(1,-1):
            pos_one = (w > delta[i]).float()
            neg_one = torch.mul((w < -delta[i]).float(),-1)
        out = torch.add(pos_one,neg_one).view(tensor.size()[1:])
        output[i] = torch.add(output[i],out).cuda()
    return output


class TernaryLinear(nn.Linear):

    def __init__(self, *kargs, **kwargs):
        super(TernaryLinear, self).__init__(*kargs, **kwargs)

    def forward(self, input):

        input.data=Binarize(input.data)
        if not hasattr(self.weight,'org'):
            self.weight.org=self.weight.data.clone()
        self.weight.data=Ternarize(self.weight.org)
        out = nn.functional.linear(input, self.weight)

        return out

class TernaryConv2d(nn.Conv2d):

    def __init__(self, *kargs, **kwargs):
        super(TernaryConv2d, self).__init__(*kargs, **kwargs)


    def forward(self, input):
        input.data = Binarize(input.data)
        if not hasattr(self.weight,'org'):
            self.weight.org=self.weight.data.clone()
        self.weight.data=Ternarize(self.weight.org)

        out = nn.functional.conv2d(input, self.weight, None, self.stride,
                                   self.padding, self.dilation, self.groups)
        return out
