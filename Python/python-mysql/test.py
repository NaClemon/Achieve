import mysql.connector

mydb = mysql.connector.connect(
    host='localhost',
    user='root',
    passwd='tmvjswl@2877'
)

mycursor = mydb.cursor()

mycursor.execute("CREATE DATABASE mydatabase")