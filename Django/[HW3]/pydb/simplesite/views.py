from django.shortcuts import render
from django.contrib import messages
import mysql.connector

mydb = mysql.connector.connect(
    host = 'localhost',
    user = 'root',
    passwd = 'tmvjswl@2877',
    database = 'hw3'
)
mycursor = mydb.cursor()

# Create your views here.

def login(request):
    return request(request, 'content/login.html')