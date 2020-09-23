import os
import torch
import logging.config
import shutil

def save_checkpoint(state, is_best, path=os.path.dirname(__file__), filename='checkpoint.pth.tar', save_all=False):
    '''Save trained model checkpoints during training'''
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