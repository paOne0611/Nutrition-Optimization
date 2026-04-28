import pyreadr
import cvxpy as cp
import pandas as pd
import numpy as np

loc=""   ##give location where saved the .RData file in your device containing the objects
x= pyreadr.read_r(loc)
x.keys()

###nutrients in proportions for 100g lunch given the consumed items
data=x['sample_prop']

mij=x['mij']
nij=x['nij']
rda_prop= x['rda_prop']
#print(data.count())
#print(data.shape)
xij= data.iloc[:, 1:10]

m = pd.to_numeric(mij.iloc[0, 4:]).to_numpy()
m= m/m.sum()
n = pd.to_numeric(nij.iloc[0, 4:]).to_numpy()
n= n/n.sum()
rda = pd.to_numeric(rda_prop.iloc[0,4:]).to_numpy()

# fix lower bounds that exceed upper bounds
n_fixed = np.minimum(n, m)

breakfast_item = data[data["breakfast"]==1].sample(n=1, replace= False)
dinner_item = data[data["dinner"]==1].sample(n=1, replace= False)
lunch_item = data[data["lunch"]==1]
snacks_item = data[data["snacks"]==1].sample(n=1, replace= False)

consumed = pd.concat(
    [breakfast_item, dinner_item, snacks_item],
    axis=0)

consumed_prop = consumed.iloc[:, 1:10].mean()
r1 = abs(rda_prop.iloc[0, 4:13] - consumed_prop)

#r1 = np.abs(rda_prop.iloc[0, 4:13] - consumed.iloc[:, 1:10].sum())


var = cp.Variable(9)
obj = cp.Minimize(cp.sum(cp.kl_div(var, r1))) #(KL Divergence to reference r)
cons = [
    var <= m, 
    var >= n_fixed,
    cp.sum(var)==1
]

prob = cp.Problem(obj, cons)
prob.solve()

print("Status:", prob.status)
if prob.status == 'optimal':
    print("Optimal Nutrients:\n", var.value)

