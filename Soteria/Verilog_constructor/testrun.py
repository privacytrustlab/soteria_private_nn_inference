import os
from getresults import GetResults

def CreateRunTest(filename, optype):
    os.system("python3 testrun_main.py " + str(filename) + " " + optype " > resultsfile")
    return GetResults("resultsfile", 3.0)
