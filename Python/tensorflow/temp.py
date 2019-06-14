import pandas as pd
from apyori import apriori

store_data = pd.read_csv('C:\\Users\\egnaro\\Desktop\\store_data.csv')

records = []
for i in range(0, 100):
    records.append([str(store_data.values[i,j]) for j in range(0, 20)])

association_rules = apriori(records, min_support=0.01, min_confidence=0.2)
association_results = list(association_rules)

print(len(association_results))

print(association_results[0])