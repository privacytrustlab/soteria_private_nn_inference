import torch
import torch.nn as nn
import numpy as np

class OP(nn.Module):
    def __init__(self):
        super(OP, self).__init__()

    def forward(self, *x):
        print("pure virtual operator is not callable.")
        assert 0


class Identity(OP):
    def __init__(self, C_prev, C):
        super(Identity, self).__init__()
        self.incdim = (C_prev != C)

    def tile(self, a, dim, n_tile):
        init_dim = a.size(dim)
        repeat_idx = [1] * a.dim()
        repeat_idx[dim] = n_tile
        a = a.repeat(*(repeat_idx))
        order_index = torch.cuda.LongTensor(np.concatenate([init_dim * np.arange(n_tile) + i for i in range(init_dim)]))
        return torch.index_select(a, dim, order_index)
    
    def forward(self, x):
        if self.incdim:
            x = self.tile(x, 1, 2)
        return x


def Binarize(tensor):
    return ((((tensor.sign() + 1.0)/3.0).round())*2.0 - 1.0).type(torch.cuda.FloatTensor)


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


class TernaryConv2d_3(nn.Conv2d):

    def __init__(self, *kargs, **kwargs):
        super(TernaryConv2d_3, self).__init__(*kargs, **kwargs)


    def forward(self, input):
        input.data = Binarize(input.data)
        if not hasattr(self.weight,'org'):
            self.weight.org=self.weight.data.clone()
        self.weight.data=Ternarize(self.weight.org)
        out = nn.functional.conv2d(input, self.weight, None, self.stride, 1, self.dilation, self.groups)
        return out


class TernaryConv2d_5(nn.Conv2d):

    def __init__(self, *kargs, **kwargs):
        super(TernaryConv2d_5, self).__init__(*kargs, **kwargs)


    def forward(self, input):
        input.data = Binarize(input.data)
        if not hasattr(self.weight,'org'):
            self.weight.org=self.weight.data.clone()
        self.weight.data=Ternarize(self.weight.org)
        out = nn.functional.conv2d(input, self.weight, None, self.stride, 2, self.dilation, self.groups)
        return out


class TernaryMaxPool2d(nn.MaxPool2d):

    def __init__(self, C_prev, C, *kargs, **kwargs):
        super(TernaryMaxPool2d, self).__init__(*kargs, **kwargs)
        self.incdim = (C_prev != C)


    def tile(self, a, dim, n_tile):
        init_dim = a.size(dim)
        repeat_idx = [1] * a.dim()
        repeat_idx[dim] = n_tile
        a = a.repeat(*(repeat_idx))
        order_index = torch.cuda.LongTensor(np.concatenate([init_dim * np.arange(n_tile) + i for i in range(init_dim)]))
        return torch.index_select(a, dim, order_index)

    def forward(self, input):
        out = nn.functional.max_pool2d(input=input, kernel_size=2, stride=2)
        #return out.repeat(1,1,2,2)
        out = self.tile(self.tile(out, 3, 2), 2, 2)
        if self.incdim:
            out = self.tile(out, 1, 2)
        return out


OPS = {
    'identity'     : lambda C_prev, C: Identity(C_prev, C),
    'max_pool_2x2' : lambda C_prev, C : TernaryMaxPool2d(C_prev, C, kernel_size=2),
    'conv_3x3'     : lambda C_prev, C: TernaryConv2d_3(C_prev, C, kernel_size=3),
    'conv_5x5'     : lambda C_prev, C: TernaryConv2d_5(C_prev, C, kernel_size=5)
}
