import pytest
import pickle
import sklearn
import numpy as np

passed = True

pkl_file = './ds_artifacts/fake.pkl'

model = None

def test_pkl_file_loads():
    global model
    try:
        with open(pkl_file, 'rb') as f:
            model = pickle.load(f)
    except Exception as e:
        pytest.fail(e)

def test_accuracy_is_greater_than_eighty_percent():
        with np.load('./ds_artifacts/val_set.npz') as val_data:
                X_val = val_data['X']
                y_val = val_data['y']

        score = model.score(X_val, y_val)

        assert (score > .8)

def test_fail():
        assert 1 == 2
