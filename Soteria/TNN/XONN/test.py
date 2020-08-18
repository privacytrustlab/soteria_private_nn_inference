import pickle


with open('weights.dat', 'rb') as f:
    x = pickle.load(f)
    print(x.keys())
    for key in x.keys():
        print(x[key].shape)
