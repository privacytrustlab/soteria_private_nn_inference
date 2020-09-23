import os
from getresults import GetResults

def CreateRunTest(filename, optype):
    '''Test environment executor'''
    os.system("python3 testrun_main.py " + str(filename) + " " + optype " > resultsfile")
    return GetResults("resultsfile", 3.0)
