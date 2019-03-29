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

def test_fails():
        assert 1 == 2
# def test_accuracy_is_greater_than_eighty_percent():
#     val_data = np.load('ds_artifacts/val_set.npz')
#     X_val = val_data['X']
#     y_val = val_data['y']

#     score = model.score(X_val, y_val)

#     assert (score > .8)
