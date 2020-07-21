
from __future__ import print_function
import argparse
import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
from torchvision import datasets, transforms
from torch.autograd import Variable
from modules import  TernaryLinear,TernaryConv2d
from modules import  Binarize, Ternarize
import numpy as np
import re
import random

torch.set_printoptions(linewidth=160, threshold=5000)
torch.set_num_threads(1) 
torch.set_default_tensor_type('torch.cuda.FloatTensor')

# Training settings
parser = argparse.ArgumentParser(description='PyTorch CIFAR Example')
parser.add_argument('--epochs', type=int, default=100, metavar='N',
                    help='number of epochs to train (default: 10)')
parser.add_argument('--lr', type=float, default=0.01, metavar='LR',
                    help='learning rate (default: 0.01)')
parser.add_argument('--momentum', type=float, default=0.5, metavar='M',
                    help='SGD momentum (default: 0.5)')
parser.add_argument('--no-cuda', action='store_true', default=False,
                    help='disables CUDA training')
parser.add_argument('--seed', type=int, default=154, metavar='S',
                    help='random seed (default: 1)')
parser.add_argument('--gpus', default=3,
                    help='gpus used for training - e.g 0,1,3')
parser.add_argument('--log-interval', type=int, default=100, metavar='N',
                    help='how many batches to wait before logging training status')
args = parser.parse_args()

batch_size = 100
printtofile = False

args.cuda = True
torch.manual_seed(args.seed)
if args.cuda:
    torch.cuda.manual_seed(args.seed)


kwargs = {'num_workers': 1, 'pin_memory': True} if args.cuda else {}

import pickle

def unpickle(file):
    
    with open(file, 'rb') as fo:
        dictionary = pickle.load(fo, encoding='bytes')
    return dictionary

def shuffle(a, b):
    rng_state = np.random.get_state()
    np.random.shuffle(a)
    np.random.set_state(rng_state)
    np.random.shuffle(b)


def loadCIFAR(batchsize = 1):
    train_data = np.array([])
    train_labels = np.array([])
    for i in range(1, 6):
        datadict = unpickle("data/data_batch_" + str(i))
        data = np.reshape(datadict[b'data'], (10000,3,32,32))
        if train_data.size == 0:
            train_data = data
        else:
            train_data = np.concatenate((train_data, data), axis=0)
        if train_labels.size == 0:
            train_labels = np.array(datadict[b'labels'])
        else:
            train_labels = np.concatenate((train_labels, np.array(datadict[b'labels'])), axis=0)

    ###### Data Augmentation #########
    data_flip_samples = 10000
    lr_flip_samples = 10000
    td_flip_samples = 10000

    diag_flip = random.sample(range(50000), data_flip_samples)
    lr_flip = random.sample(range(50000), lr_flip_samples)
    td_flip = random.sample(range(50000), td_flip_samples)
    
    new_images = []
    new_images_labels = []


    for i in diag_flip:
        new_img = np.flip(train_data[i], (1,2))
        new_img_label = train_labels[i]
        new_images.append(new_img)
        new_images_labels.append(new_img_label)


    for i in lr_flip:
        new_img = np.flip(train_data[i], 2)
        new_img_label = train_labels[i]
        new_images.append(new_img)
        new_images_labels.append(new_img_label)

    for i in td_flip:
        new_img = np.flip(train_data[i], 1)
        new_img_label = train_labels[i]
        new_images.append(new_img)
        new_images_labels.append(new_img_label)


    new_images = np.array(new_images)
    new_images_labels = np.array(new_images_labels)

    train_load = 50000 + data_flip_samples + lr_flip_samples + td_flip_samples
    test_load = 10000

    train_split_size = train_load//batchsize
    test_split_size = test_load//batchsize


    train_data = np.concatenate((train_data, new_images), axis=0)
    train_data = train_data/255.0
    train_labels = np.concatenate((train_labels, new_images_labels), axis=0)

    shuffle(train_data, train_labels) 

    train_images_batches = np.array(np.split(train_data, train_split_size)).astype(np.float32)

    train_labels_batches = np.array(np.split(train_labels, train_split_size)).astype(np.int_)
    train_labels_batches = train_labels_batches.reshape(train_labels_batches.shape[:2])
    
    datadict = unpickle("data/test_batch")
    test_data = np.reshape(datadict[b'data'], (10000,3,32,32))
    test_labels = np.array(datadict[b'labels'])

    test_images_batches = np.array(np.split(test_data, test_split_size)).astype(np.float32)
    test_labels_batches = np.array(np.split(test_labels, test_split_size)).astype(np.int_)
    test_labels_batches = test_labels_batches.reshape(test_labels_batches.shape[:2])

    train_set = list(zip(train_images_batches, train_labels_batches))
    test_set = list(zip(test_images_batches, test_labels_batches))

    return train_set, test_set

train_loader, test_loader = loadCIFAR(batchsize=batch_size)

class Net(nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        self.infl_ratio=3
        self.test = False
        self.features = nn.Sequential(
            nn.Conv2d(3, 128*self.infl_ratio, kernel_size=3, padding=1,bias=False),
            nn.Hardtanh(),
            nn.BatchNorm2d(128*self.infl_ratio),
            nn.CELU(),

            nn.ConstantPad2d(1, 0),
            TernaryConv2d(128*self.infl_ratio, 128*self.infl_ratio, kernel_size=3, bias=False),
            nn.MaxPool2d(kernel_size=2, stride=2),
            nn.Hardtanh(),

            nn.ConstantPad2d(1, 0),
            TernaryConv2d(128*self.infl_ratio, 256*self.infl_ratio, kernel_size=3, bias=False),
            nn.Hardtanh(),

            nn.ConstantPad2d(1, 0),            
            TernaryConv2d(256*self.infl_ratio, 256*self.infl_ratio, kernel_size=3,bias=False),
            nn.MaxPool2d(kernel_size=2, stride=2),
            nn.Hardtanh(),

            nn.ConstantPad2d(1, 0),
            TernaryConv2d(256*self.infl_ratio, 512*self.infl_ratio, kernel_size=3, bias=False),
            nn.Hardtanh(),

            nn.ConstantPad2d(1, 0),
            TernaryConv2d(512*self.infl_ratio, 512*self.infl_ratio, kernel_size=3, bias=False),
            nn.MaxPool2d(kernel_size=2, stride=2),
            nn.Hardtanh(),
        )
        
        self.classifier = nn.Sequential(
            TernaryLinear(512*self.infl_ratio*4*4, 1024, bias=False),
            nn.BatchNorm1d(1024),
            nn.Dropout(0.5),
            nn.Hardtanh(),
            TernaryLinear(1024, 10, bias=False),
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
if printtofile:
    resultsfile = open("results", "w+")

def train(epoch):
    model.train()
    for batch_idx, (data, target) in enumerate(train_loader):
        if args.cuda:
            data, target = Variable(torch.from_numpy(data).cuda()),Variable(torch.from_numpy(target).cuda())
        else:
            data, target = Variable(torch.from_numpy(data)),Variable(torch.from_numpy(target))

        
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
            if printtofile:
                resultsfile.write('Train Epoch: {} [{}/{} ({:.0f}%)]\tLoss: {:.6f}\n'.format(
                    epoch, batch_idx * len(data), len(train_loader)*batch_size,
                    100. * batch_idx / len(train_loader), loss.data.item()))
                resultsfile.flush()
            else:
                print('Train Epoch: {} [{}/{} ({:.0f}%)]\tLoss: {:.6f}'.format(
                    epoch, batch_idx * len(data), len(train_loader)*batch_size,
                    100. * batch_idx / len(train_loader), loss.data.item()))

def test():
    model.eval()
    test_loss = 0
    correct = 0
    for data, target in test_loader:
        if args.cuda:
            data, target = Variable(torch.from_numpy(data).cuda(), volatile=True), Variable(torch.from_numpy(target).cuda())
        else:
            data, target = Variable(torch.from_numpy(data), volatile=True), Variable(torch.from_numpy(target))
        
        output = model(data)
        test_loss += criterion(output, target).data.item() # sum up batch loss
        pred = output.data.max(1, keepdim=True)[1] # get the index of the max log-probability
        correct += pred.eq(target.data.view_as(pred)).cpu().sum()

    test_loss /= len(test_loader)
    if printtofile:
        resultsfile.write('\nTest set: Average loss: {:.4f}, Accuracy: {}/{} ({:.0f}%)\n\n'.format(
            test_loss, correct, len(test_loader)*batch_size,
            100. * correct / (len(test_loader)*batch_size)))
        resultsfile.flush()
    else:
        print('\nTest set: Average loss: {:.4f}, Accuracy: {}/{} ({:.0f}%)\n'.format(
            test_loss, correct, len(test_loader)*batch_size,
            100. * correct / (len(test_loader)*batch_size)))


for epoch in range(1, args.epochs + 1):
    train(epoch)
    test()

