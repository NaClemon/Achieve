import numpy as np
from sklearn.linear_model import LinearRegression

x = np.array([95,85,80,70,60]).reshape((-1,1))
y = np.array([85,95,70,65,70])

print(x)
print(y)

model = LinearRegression()
model.fit(x, y)
print(model)

r_sq = model.score(x, y)
print(r_sq)

print(model.intercept_)
print(model.coef_)

y_pred = model.predict([[50]])
print(y_pred, sep='\n')
y_pred = model.intercept_ + model.coef_*x
print(y_pred, sep='\n')