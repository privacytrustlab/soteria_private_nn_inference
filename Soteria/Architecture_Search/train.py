# This is the main file that controls the training of the searched architecture to generate a fully-trained model.

import argparse
import os
import sys
import torch
import math
import numpy as np
import torch.nn as nn
import torchvision.datasets as dset
import torch.nn.functional as F
import utils
from model import *

parser = argparse.ArgumentParser("cifar")
parser.add_argument('--data', type=str, default='./data', help='location of the data corpus')
parser.add_argument('--batch_size', type=int, default=64, help='batch size')
parser.add_argument('--lr', type=float, default=0.01, help='init learning rate')
parser.add_argument('--momentum', type=float, default=0.9, help='momentum')
parser.add_argument('--wd', type=float, default=3e-4, help='weight decay')
parser.add_argument('--epochs', type=int, default=200, help='num of training epochs')
parser.add_argument('--init_channels', type=int, default=16, help='num of init channels')
parser.add_argument('--layers', type=int, default=3, help='total number of layers')
parser.add_argument('--model_path', type=str, default='saved_models', help='path to save the model')
parser.add_argument('--num_workers', type=int, default=2,help='the number of workers.')
parser.add_argument('--grad_clip', type=float, default=5, help='gradient clipping')

args = parser.parse_args()

class Trainer:
    def __init__(self):
        def _create_dataset():
            '''Obtain dataset, load and preprocess it'''
            train_transform, valid_transform = utils._data_transforms_cifar10(args)

            train_data = dset.CIFAR10(root=args.data, train=True, download=True, transform=train_transform)
            self.loader_train = torch.utils.data.DataLoader(
                train_data,
                batch_size=args.batch_size,
                pin_memory=True,
                num_workers=args.num_workers
            )

            valid_data = dset.CIFAR10(root=args.data, train=False, download=True, transform=valid_transform)
            self.loader_test = torch.utils.data.DataLoader(
                valid_data,
                batch_size=args.batch_size,
                pin_memory=True,
                num_workers=args.num_workers
            )
        
        def _weight_manipulation(x):
            '''Operation scores are adjusted according to the complexity of the operations''' 
            circuit_complexity_factor = 0.6     #Lambda
            complexities = [0.0, 0.41, 0.04, 1.0]
            weight_factor = torch.tensor([1-circuit_complexity_factor*complexity for complexity in complexities], requires_grad=False).cuda()
            x = x*weight_factor
            x = x/torch.sum(x)
            return x

        def _build_model():
            '''Build the model to be trained.'''
            dirname = os.path.dirname(__file__)
            pth = torch.load(os.path.join(dirname, './trained_model', 'nas_arch.pkl'))
            arch = {
                'normal' : F.softmax(pth['module.w_alpha_normal'],    1).cpu().numpy(),
            }
            self.model = nn.DataParallel(NetworkCIFAR(C=args.init_channels,num_classes=10, layers=args.layers,arch=arch)).cuda()
            self.loss_func = torch.nn.CrossEntropyLoss().cuda()

            self.opt = torch.optim.SGD(
                self.model.parameters(),      
                lr=args.lr,
                momentum=args.momentum,
                weight_decay=args.wd
            )

            self.opt_sche = torch.optim.lr_scheduler.CosineAnnealingLR(
                self.opt, 
                float(args.epochs)
            )

        _create_dataset()
        _build_model()
    
    def save_model(self):
        '''Save model in torch pickle file'''
        dirname = os.path.dirname(__file__)
        save_folder = os.path.join(dirname, './trained_model')
        if not os.path.exists(save_folder):
            os.makedirs(save_folder)
        torch.save(self.model.state_dict(), os.path.join(save_folder, 'nas_model.pkl'))

    def eval(self):
        '''Evaluate the performance of the model on a test set'''
        self.model.eval()
        objs = utils.AvgrageMeter()
        top1 = utils.AvgrageMeter()
        top5 = utils.AvgrageMeter()

        for step, (input, target) in enumerate(self.loader_test):
            input, target = input.cuda(), target.cuda()
            logits, _ = self.model(input)
            loss = self.loss_func(logits, target)

            prec1, prec5 = utils.accuracy(logits, target, topk=(1, 5))
            loss, prec1, prec5 = float(loss), float(prec1), float(prec5)
            n = input.size(0)
            objs.update(loss,  n)
            top1.update(prec1, n)
            top5.update(prec5, n)

        self.model.train()
        return top1.avg, top5.avg, objs.avg

    def train(self):
        '''Train the model on the training set'''
        sche, opt = self.opt_sche, self.opt
        pre_best_acc = 0
        for epoch in range(1, args.epochs+1):
            self.model.train()
            #print(self.model)
            sche.step()
            objs = utils.AvgrageMeter()
            top1 = utils.AvgrageMeter()
            top5 = utils.AvgrageMeter()
            lr   = sche.get_lr()[0]
            print('epoch: {} lr: {}'.format(epoch, round(lr, 8)))
            if epoch == 1 or epoch%10==0:
                print(self.model)


            for step, (input, target) in enumerate(self.loader_train):
                n = input.size(0)
                input, target = input.cuda(), target.cuda()
                logits, logits_aux = self.model(input)
                loss = self.loss_func(logits, target)
                opt.zero_grad()
                loss.backward()
                nn.utils.clip_grad_norm_(self.model.parameters(), args.grad_clip)
                opt.step()

                prec1, prec5 = utils.accuracy(logits, target, topk=(1, 5))
                loss, prec1, prec5 = float(loss), float(prec1), float(prec5)
                objs.update(loss,  n)
                top1.update(prec1, n)
                top5.update(prec5, n)

                #print('train => [(epoch: {}), (loss: {}), (prec1: {}), (prec5: {})]'.format(epoch, round(objs.avg, 6), round(top1.avg, 4), round(top5.avg, 4)))

            #evalute the model
            acc_tp1, acc_tp5, obj_avg = self.eval()
            if acc_tp1 > pre_best_acc:
                pre_best_acc = acc_tp1
                self.save_model()

            print('test  => [(loss: {}), (prec1: {}), (prec5: {})]'.format(round(obj_avg, 6), round(acc_tp1, 4), round(acc_tp5, 4)))

if __name__ == '__main__':
    trainer = Trainer()
    trainer.train()