# example train notebook using sklearn dataset
from sklearn import svm
from sklearn import datasets
import pickle
from sklearn.model_selection import train_test_split
import numpy as np

clf = svm.SVC(gamma='scale')
iris = datasets.load_iris()
X, y = iris['data'], iris['target']

# for simplicity's sake, just using the test set as the val set. not best practice
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=1)
np.savez('val_set.npz', X=X_test, y=y_test)

clf.fit(X, y)  

with open('ds_artifacts/fake.pkl', 'wb') as f:
    pickle.dump(clf, f)