from pymongo import MongoClient
import matplotlib.pyplot as plt

client = MongoClient('mongodb://admin:sps1@13.124.105.25:27017/')
database = client.test
collection = database.test

informs = collection.find()

for inform in informs:
    print(inform)