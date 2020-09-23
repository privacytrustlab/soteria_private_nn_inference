import os
import torch
import logging.config
import shutil

def save_checkpoint(state, is_best, path=os.path.dirname(__file__), filename='checkpoint.pth.tar', save_all=False):
    '''Save model checkpoint during training'''
    filename = os.path.join(path, filename)
    torch.save(state, filename)
    if is_best:
        shutil.copyfile(filename, os.path.join(path, 'model_best.pth.tar'))
    if save_all:
        shutil.copyfile(filename, os.path.join(
            path, 'checkpoint_epoch_%s.pth.tar' % state['epoch']))


__optimizers = {
    'SGD': torch.optim.SGD,
    'ASGD': torch.optim.ASGD,
    'Adam': torch.optim.Adam,
    'Adamax': torch.optim.Adamax,
    'Adagrad': torch.optim.Adagrad,
    'Adadelta': torch.optim.Adadelta,
    'Rprop': torch.optim.Rprop,
    'RMSprop': torch.optim.RMSprop
}

def accuracy(output, target, topk=(1,)):
    """Computes the precision@k for the specified values of k"""
    maxk = max(topk)
    batch_size = target.size(0)

    _, pred = output.float().topk(maxk, 1, True, True)
    pred = pred.t()
    correct = pred.eq(target.view(1, -1).expand_as(pred))

    res = []
    for k in topk:
        correct_k = correct[:k].view(-1).float().sum(0)
        res.append(correct_k.mul_(100.0 / batch_size))
    return res