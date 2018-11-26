import mysql.connector

mydb = mysql.connector.connect(
    host='cbnuclouddb.cn25twnqpp2k.ap-northeast-2.rds.amazonaws.com',
    user='cbnuclouddb',
    passwd='aziz1234'
)

mycursor2 = mydb.cursor()

sql2 = 'create table skh2 (num int not null primary key, name varchar(32), age int)'
sql1 = 'create table skh1 (id int not null primary key, name varchar(32) not null' \
            ', email varchar(32) not null, guide_num int, foreign key(guide_num) references' \
       'skh2(num))'
sql3 = "show databases"

sql_test = 'show table'

mycursor2.execute(sql3)

for x in mycursor2:
    print(x)

