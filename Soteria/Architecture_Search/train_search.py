# This is the main file that controls the search process.


import argparse
import os
import sys
import torch
import math
import numpy as np
import torch.nn as nn
import torchvision.datasets as dset
import utils
from model_search import Network

parser = argparse.ArgumentParser(description = 'model searcher.')
parser.add_argument('--batch_size', type=int, default=64, help='the batch size')
parser.add_argument('--lr', type=float, default=0.01, help='init learning rate')
parser.add_argument('--m_lr',type=float, default=0.005, help='min learning rate')
parser.add_argument('--momentum',type=float, default=0.9, help='momentum')
parser.add_argument('--wd', type=float, default=3e-4, help='weight decay')
parser.add_argument('--epochs', type=int, default=100, help='num of training epochs')
parser.add_argument('--init_channels', type=int, default=8,help='num of init channels')
parser.add_argument('--layers', type=int,default=3,help='total number of layers')
parser.add_argument('--model_path', type=str,default='saved_models', help='path to save the model')
parser.add_argument('--grad_clip', type=float, default=5, help='gradient clipping')
parser.add_argument('--data',type=str,default='./data',help='the data folder')
parser.add_argument('--num_workers', type=int,default=2,help='the number worker.')
args = parser.parse_args()

class Trainer:
    def __init__(self):
        def _create_dataset():
            train_transform, valid_transform = utils._data_transforms_cifar10(args)
            train_data = dset.CIFAR10(root=args.data, train=True, download=True, transform=train_transform)
            num_train = len(train_data)
            indices   = list(range(num_train))

            self.loader_train = torch.utils.data.DataLoader(
                train_data,
                batch_size=args.batch_size,
                sampler=torch.utils.data.sampler.SubsetRandomSampler(indices[:num_train]),
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
        
        def _build_model():
            self.model = nn.DataParallel(Network(C=args.init_channels,num_classes=10, layer=args.layers)).cuda()
            self.loss_func = torch.nn.CrossEntropyLoss().cuda()
            self.opt = torch.optim.SGD(
                self.model.parameters(),      
                lr=args.lr,
                momentum=args.momentum,
                weight_decay=args.wd
            )

            self.opt_sche = torch.optim.lr_scheduler.CosineAnnealingLR(
                self.opt, 
                float(args.epochs), 
                eta_min=args.m_lr
            )
           
        _create_dataset()
        _build_model()
        print(self.model)
    
    def save_model(self):
        dirname = os.path.dirname(__file__)
        save_folder = os.path.join(dirname, './trained_model')
        if not os.path.exists(save_folder):
            os.makedirs(save_folder)
        torch.save(self.model.state_dict(), os.path.join(save_folder, 'nas_arch.pkl'))

    def eval(self):
        self.model.eval()
        objs = utils.AvgrageMeter()
        top1 = utils.AvgrageMeter()
        top5 = utils.AvgrageMeter()

        for step, (input, target) in enumerate(self.loader_test):
            input, target = input.cuda(), target.cuda()
            logits = self.model(input)
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
        sche, opt = self.opt_sche, self.opt
        pre_best_acc = 0
        for epoch in range(args.epochs):
            self.model.train()
            sche.step()
            objs = utils.AvgrageMeter()
            top1 = utils.AvgrageMeter()
            top5 = utils.AvgrageMeter()
            lr   = sche.get_lr()[0]
            print('epoch: {} lr: {}'.format(epoch, round(lr, 8)))
            counter = 0
            for step, (input, target) in enumerate(self.loader_train):
                n = input.size(0)
                input, target = input.cuda(), target.cuda()
                logits = self.model(input)
                loss = self.loss_func(logits, target)
                opt.zero_grad()
                loss.backward()
                nn.utils.clip_grad_norm_(self.model.parameters(), args.grad_clip)
                opt.step()
                counter += 1

                prec1, prec5 = utils.accuracy(logits, target, topk=(1, 5))
                loss, prec1, prec5 = float(loss), float(prec1), float(prec5)
                objs.update(loss,  n)
                top1.update(prec1, n)
                top5.update(prec5, n)


            #evalute the model
            acc_tp1, acc_tp5, obj_avg = self.eval()
            if acc_tp1 > pre_best_acc:
                print('found better architecture with [acc: {}]'.format(round(acc_tp1, 4)))
                pre_best_acc = acc_tp1
                self.save_model()

            print('test  => [(loss: {}), (prec1: {}), (prec5: {})]'.format(round(obj_avg, 6), round(acc_tp1, 4), round(acc_tp5, 4)))

        print(self.model)

    def show_weight(self):
        print(self.model.module.w_alpha_normal[0])

if __name__ == '__main__':
    trainer = Trainer()
    trainer.train()
