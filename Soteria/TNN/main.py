
from __future__ import print_function
import argparse
import os
import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
from torchvision import datasets, transforms
from torch.autograd import Variable
from modules import  TernaryLinear,TernaryConv2d, Ternarize
import utils
import numpy as np
from collections import OrderedDict
import pickle

import warnings
warnings.filterwarnings('ignore')

parser = argparse.ArgumentParser(description='PyTorch MNIST Example')
parser.add_argument('--batch-size', type=int, default=64, metavar='N',
                    help='input batch size for training (default: 256)')
parser.add_argument('--test-batch-size', type=int, default=1000, metavar='N',
                    help='input batch size for testing (default: 1000)')
parser.add_argument('--epochs', type=int, default=100, metavar='N',
                    help='number of epochs to train (default: 10)')
parser.add_argument('--lr', type=float, default=0.01, metavar='LR',
                    help='learning rate (default: 0.001)')
parser.add_argument('--momentum', type=float, default=0.5, metavar='M',
                    help='SGD momentum (default: 0.5)')
parser.add_argument('--no-cuda', action='store_true', default=False,
                    help='disables CUDA training')
parser.add_argument('--gpus', default=0,
                    help='gpus used for training - e.g 0,1,3')
parser.add_argument('--log-interval', type=int, default=200, metavar='N',
                    help='how many batches to wait before logging training status')
args = parser.parse_args()
args.cuda = not args.no_cuda and torch.cuda.is_available()


kwargs = {'num_workers': 0, 'pin_memory': True} if args.cuda else {}
train_loader = torch.utils.data.DataLoader(
    datasets.MNIST('../data', train=True, download=True,
                   transform=transforms.Compose([
                       transforms.ToTensor(),
                       transforms.Normalize((0.1307,), (0.3081,))
                   ])),
    batch_size=args.batch_size, shuffle=True, **kwargs)
test_loader = torch.utils.data.DataLoader(
    datasets.MNIST('../data', train=False, transform=transforms.Compose([
                       transforms.ToTensor(),
                       transforms.Normalize((0.1307,), (0.3081,))
                   ])),
    batch_size=args.test_batch_size, shuffle=True, **kwargs)




class Net(nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        self.infl_ratio=3
        self.conv_fp = nn.Conv2d(1, 16*self.infl_ratio, kernel_size=3, padding=1)
        self.htanh_fp = nn.Hardtanh()
        self.bn_fp = nn.BatchNorm2d(int(16*self.infl_ratio))
        self.conv1 = TernaryConv2d(16*self.infl_ratio, 16*self.infl_ratio, kernel_size=3, padding=1, bias=False)
        self.mp1 = nn.MaxPool2d(kernel_size=2, stride=2)
        self.htanh1 = nn.Hardtanh()
        self.conv2 = TernaryConv2d(16*self.infl_ratio, 16*self.infl_ratio, kernel_size=5, padding=2, bias=False)
        self.htanh2 = nn.Hardtanh()
        self.fc1 = TernaryLinear(int(16*self.infl_ratio*14*14), int(100*self.infl_ratio), bias=False)
        self.htanh_fc1 = nn.Hardtanh()
        self.bn_fc1 = nn.BatchNorm1d(int(100*self.infl_ratio), affine=False)
        self.fc2 = TernaryLinear(int(100*self.infl_ratio), 10, bias=False)
        self.logsoftmax=nn.LogSoftmax()

    def forward(self, x):
        x = self.conv_fp(x)
        x = self.bn_fp(x)
        x = self.htanh_fp(x)
        x = self.conv1(x)
        x = self.mp1(x)
        x = self.htanh1(x)
        x = self.conv2(x)
        x = self.htanh2(x)
        x = x.view(-1, int(16*self.infl_ratio*14*14))
        x = self.fc1(x)
        x = self.bn_fc1(x)
        x = self.htanh_fc1(x)
        x = self.fc2(x)
        return self.logsoftmax(x)


model = Net()
if args.cuda:
    torch.cuda.set_device(0)
    model.cuda()


criterion = nn.CrossEntropyLoss()
optimizer = optim.Adam(model.parameters(), lr=args.lr)


def train(epoch):
    model.train()
    for batch_idx, (data, target) in enumerate(train_loader):
        if args.cuda:
            data, target = data.cuda(), target.cuda()
        data, target = Variable(data), Variable(target)
        optimizer.zero_grad()
        output = model(data)
        loss = criterion(output, target)

        if epoch%40==0:
            optimizer.param_groups[0]['lr']=optimizer.param_groups[0]['lr']*0.1

        optimizer.zero_grad()
        loss.backward()
        for p in list(model.parameters()):
            if hasattr(p,'org'):
                p.data.copy_(p.org)
        optimizer.step()
        for p in list(model.parameters()):
            if hasattr(p,'org'):
                p.org.copy_(p.data.clamp_(-1,1))

        if batch_idx % args.log_interval == 0:
            print('Train Epoch: {} [{}/{} ({:.0f}%)]\tLoss: {:.6f}'.format(
                epoch, batch_idx * len(data), len(train_loader.dataset),
                100. * batch_idx / len(train_loader), loss.item()))

best_acc = 0.0

def test():
    global best_acc
    model.eval()
    test_loss = 0
    correct = 0
    with torch.no_grad():
        for data, target in test_loader:
            if args.cuda:
                data, target = data.cuda(), target.cuda()
            data, target = Variable(data), Variable(target)
            output = model(data)
            test_loss += criterion(output, target).item() # sum up batch loss
            pred = output.data.max(1, keepdim=True)[1] # get the index of the max log-probability
            correct += pred.eq(target.data.view_as(pred)).cpu().sum()

    test_loss /= len(test_loader.dataset)
    print('\nTest set: Average loss: {:.4f}, Accuracy: {}/{} ({:.0f}%)\n'.format(
        test_loss, correct, len(test_loader.dataset),
        100. * correct / len(test_loader.dataset)))
    
    if correct/len(test_loader.dataset) > best_acc:
        utils.save_checkpoint({
            'epoch': epoch + 1,
            'state_dict': model.state_dict()
        }, True)
    best_acc = correct/len(test_loader.dataset)

for epoch in range(1, args.epochs + 1):
    train(epoch)
    test()


def save_model():
    # Saving Model architecture
    dirname = os.path.dirname(__file__)
    f = open(os.path.join(dirname, "model_architecture.dat"), 'w')
    f.write(str(model))
    f.close()

    def check_valid_param(name):
        name = name.strip().split(".")
        if name[1] != 'weight':
            return False
        elif 'conv' not in name[0] and 'fc' not in name[0]:
            return False
        elif len([i for i in name[0] if i.isdigit()]) == 0:
            return False
        else:
            return True

    weights_dict = OrderedDict()

    # Saving weights
    for name, param in model.named_parameters():
        if check_valid_param(name):
            weights_dict[name.split(".")[0]] = param.data.cpu().numpy()
    weights_file = open(os.path.join(dirname, "weights.dat"), 'wb')
    pickle.dump(weights_dict, weights_file)
    weights_file.close()

save_model()