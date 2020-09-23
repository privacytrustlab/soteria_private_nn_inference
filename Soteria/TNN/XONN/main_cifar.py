
from __future__ import print_function
import argparse
import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
from torchvision import datasets, transforms
from torch.autograd import Variable
from modules import  BinaryLinear, BinaryConv2d
from modules import  Binarize
import numpy as np
import re
import random
import pickle
import os
from collections import OrderedDict


torch.set_printoptions(linewidth=160, threshold=5000)
torch.set_num_threads(1) 
torch.set_default_tensor_type('torch.cuda.FloatTensor')

# Training settings
parser = argparse.ArgumentParser(description='PyTorch CIFAR Example')
parser.add_argument('--epochs', type=int, default=10, metavar='N',
                    help='number of epochs to train (default: 10)')
parser.add_argument('--lr', type=float, default=0.01, metavar='LR',
                    help='learning rate (default: 0.01)')
parser.add_argument('--momentum', type=float, default=0.5, metavar='M',
                    help='SGD momentum (default: 0.5)')
parser.add_argument('--batch_size', type=int, default=64, metavar='B',
                    help='Batch Size (default 64)')
parser.add_argument('--test-batch-size', type=int, default=32, metavar='T',
                    help='input batch size for testing (default: 1000)')
parser.add_argument('--no-cuda', action='store_true', default=False,
                    help='disables CUDA training')
parser.add_argument('--seed', type=int, default=154, metavar='S',
                    help='random seed (default: 1)')
parser.add_argument('--gpus', default=3,
                    help='gpus used for training - e.g 0,1,3')
parser.add_argument('--log-interval', type=int, default=100, metavar='L',
                    help='how many batches to wait before logging training status')
args = parser.parse_args()

batch_size = 100
printtofile = False

args.cuda = True
torch.manual_seed(args.seed)
if args.cuda:
    torch.cuda.manual_seed(args.seed)


kwargs = {'num_workers': 0, 'pin_memory': False} if args.cuda else {}

train_loader = torch.utils.data.DataLoader(
    datasets.CIFAR10('./data', train=True, download=True,
                   transform=transforms.Compose([
                       transforms.ToTensor(),
                       transforms.Normalize((0.1307,), (0.3081,))
                   ])),
    batch_size=args.batch_size, shuffle=True, **kwargs)
test_loader = torch.utils.data.DataLoader(
    datasets.CIFAR10('./data', train=False, transform=transforms.Compose([
                       transforms.ToTensor(),
                       transforms.Normalize((0.1307,), (0.3081,))
                   ])),
    batch_size=args.test_batch_size, shuffle=True, **kwargs)



class Net(nn.Module):
    '''Model architecture is to be defined in this class.'''
    def __init__(self):
        super(Net, self).__init__()
        self.infl_ratio=1
        self.features = nn.Sequential(
            nn.Conv2d(3, 128*self.infl_ratio, kernel_size=3, padding=1, bias=False),
            nn.BatchNorm2d(128*self.infl_ratio),

            BinaryConv2d(128*self.infl_ratio, 128*self.infl_ratio, kernel_size=3, padding=1, bias=False),
            nn.MaxPool2d(kernel_size=2, stride=2),

            BinaryConv2d(128*self.infl_ratio, 256*self.infl_ratio, kernel_size=3, padding=1, bias=False),

            BinaryConv2d(256*self.infl_ratio, 256*self.infl_ratio, kernel_size=3,padding=1, bias=False),
            nn.MaxPool2d(kernel_size=2, stride=2),

            BinaryConv2d(256*self.infl_ratio, 512*self.infl_ratio, kernel_size=3, padding=1, bias=False),

            BinaryConv2d(512*self.infl_ratio, 512*self.infl_ratio, kernel_size=3, padding=1, bias=False),
            nn.MaxPool2d(kernel_size=2, stride=2),
        )
        
        self.classifier = nn.Sequential(
            BinaryLinear(512*self.infl_ratio*4*4, 1024, bias=False),
            nn.BatchNorm1d(1024),
            nn.Dropout(0.5),
            nn.Hardtanh(),
            BinaryLinear(1024, 10, bias=False),
            nn.LogSoftmax()
        )


    def forward(self, x):
        x = self.features(x)
        x = x.view(-1, 512*self.infl_ratio*4*4)
        x = self.classifier(x)
        return x



model = Net()
if args.cuda:
    print("Running on GPU")
    torch.cuda.set_device(0)
    model.cuda()


criterion = nn.CrossEntropyLoss()
optimizer = optim.AdamW(model.parameters(), lr=args.lr)
def train(epoch):
    '''Train the model for 1 epoch'''
    model.train()
    for batch_idx, (data, target) in enumerate(train_loader):
        if args.cuda:
            data, target = data.cuda(), target.cuda()
        data, target = Variable(data), Variable(target)
        optimizer.zero_grad()
        output = model(data)
        loss = criterion(output, target)

        if epoch%25==0:
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


def save_model():
    '''Saving model architecture and weights'''
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

best_acc = 0.0

def test():
    '''Evaluate the model on the test set'''
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
    
    if 100.*correct/len(test_loader.dataset) > best_acc:
        print("New Best accuracy achieved!")
        save_model()
        best_acc = 100.*correct/len(test_loader.dataset)

for epoch in range(1, args.epochs + 1):
    train(epoch)
    test()