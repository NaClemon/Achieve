import matplotlib.pyplot as plt
import matplotlib.animation as anim
from pymongo import MongoClient

client = MongoClient('mongodb://admin:sps1@15.164.220.159:27017/')
database = client.test
collection = database.test

