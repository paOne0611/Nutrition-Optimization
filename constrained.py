import pyreadr
import cvxpy as cp
import pandas as pd
import numpy as np

loc=""   ##give location where saved the .RData file in your device containing the objects
x= pyreadr.read_r(loc)
x.keys()


###nutrients in proportions for 100g lunch given the consumed items
data=x['sample_prop']

body=5
ear_g=x['ear_sub'].iloc[0:6,]
tul_g=x['tul']
rda_prop= x['rda_prop']
t=tul_g.iloc[body,]
tul_prop=t[3:]/sum(t[3:])
e= ear_g.iloc[body,]
ear_prop= e[3:]/sum(e[3:])


breakfast_item = data[data["breakfast"]==1].sample(n=1, replace= False)
dinner_item = data[data["dinner"]==1].sample(n=1, replace= False)
lunch_item = data[data["lunch"]==1]
snacks_item = data[data["snacks"]==1].sample(n=1, replace= False)

consumed = pd.concat(
    [breakfast_item, dinner_item, snacks_item],
    axis=0)

consumed_prop = consumed.iloc[:, 1:10].mean()

r1= abs(pd.to_numeric(rda_prop[body, 3:] - consumed_prop)).to_numpy()
r1= r1/sum(r1)
m = abs(pd.to_numeric(tul_prop- consumed_prop)).to_numpy()
m= m/m.sum()
n = abs(pd.to_numeric(ear_prop - consumed_prop)).to_numpy()
n= n/n.sum()
n = np.minimum(m, n)

var = cp.Variable(9)
obj = cp.Minimize(cp.sum(cp.kl_div(var, r1))) #(KL Divergence to reference r)
cons = [
    var <= m, 
    var >= n,
    cp.sum(var)==1
]

prob = cp.Problem(obj, cons)
prob.solve()

x['rda_sub'].iloc[body,3:]
rda_prop.iloc[body,3]
consumed.iloc[:,0]
print("Status:", prob.status)
if prob.status == 'optimal':
    print("Optimal Nutrients:\n", var.value)



