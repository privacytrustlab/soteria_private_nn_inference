import re
import sys

def GetResults(filename, tsc_freq_GHz = None):
    tsc_freq_GHz = float(tsc_freq_GHz)*10e9
    f = open(filename).read()
    garbling_times = re.findall(r'Alice garbling time \(cc\) = ([0-9]+)', f)
    garbling_times = [int(x) for x in garbling_times]
    garbling_min = min(garbling_times)

    eval_times = re.findall(r'Bob evaluation time \(cc\) = ([0-9]+)', f)
    eval_times = [int(x) for x in eval_times]
    eval_min = min(eval_times)

    comm_times = re.findall(r'Alice communication time \(cc\) = ([0-9]+)', f)
    comm_times = [int(x) for x in comm_times]
    comm_min = min(comm_times)

    offline = garbling_min
    online = eval_min + comm_min

    communication = re.findall(r'Garbled Tables Data Sent: *([0-9]+)', f)
    if communication != []:
        communication = [int(x) for x in communication]
        communication_min = min(communication)
        communication_MB = float(communication_min)/(8*1024*1024)
    else:
        communication_MB = "NaN"


    if tsc_freq_GHz != None:
        offline_ms = round(offline*1000.0/tsc_freq_GHz, 2)
        online_ms = round(online*1000.0/tsc_freq_GHz, 2)
        return offline_ms, online_ms, communication_MB
    else:
        return offline, online, communication_min


if __name__=="__main__":
    filename = sys.argv[1]
    tsc_freq_GHz = sys.argv[2]
    print("Offline = {} ms\nOnline = {} ms\nCommunication = {} MB".format(*GetResults(filename, tsc_freq_GHz)))