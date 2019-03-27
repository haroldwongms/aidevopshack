import pickle
import sklearn

def call_score(data):
    pkl_file = 'fake.pkl'
    with open(pkl_file, 'rb') as f:
        model = pickle.load(f)

    # here is where you would mirror pre-processing from when you built the model
    prediction = model.predict(data)
    return prediction
