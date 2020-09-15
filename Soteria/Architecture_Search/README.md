## Architecture Search

#### Steps

1. First, a suitable model for a given dataset is searched using DARTS architecture search. 
    - The included code uses the 'CIFAR10' dataset.
2. Then, the model is trained fully.

Executing this code may take a few hours, depending on your machine configuration.

#### Search model

    $ python3 /app/Soteria/Architecture_Search/train_search.py

This will save a architecture pickle file `nas_arch.pkl` under directory `/app/Soteria/Architecture_Search/trained_model`. 

**If a pre-searched DARTS architecture exists:** Place the architecture pickle file in this directory.

A pre-searched architecture pickle file can be found [here.](https://drive.google.com/file/d/1jvXTzDp53w4U3KJkFyNR-QK_ddFcZiEc/view?usp=sharing) Place the trained architecture file directly in the directory `/app/Soteria/Architecture_Search/trained_model`.

The hyperparameters used to obtain this architecture are listed in file `hyperparameters.csv`. 

#### Train searched model

    $ python3 /app/Soteria/Architecture_Search/train.py

This will train the model fully.

The pre-trained model pickle for the architecture above can be found [here.](https://drive.google.com/file/d/1oXCj69NhkMGuCS-lWNTD3wy1EmS9SzMe/view?usp=sharing) Place the trained model file directly in the directory `/app/Soteria/Architecture_Search/trained_model`.