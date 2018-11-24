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

user = ""
stu_name = ""

def login(request):
    global user
    global stu_name
    if (request.method == 'POST'):
        userid = request.POST.get('userid')
        password = request.POST.get('password')
        user = userid
        sql = 'select pw, name from student where id="' + userid + '"'
        mycursor.execute(sql)
        try:
            result = mycursor.fetchone()
            sqlpw = result[0]
            stu_name = result[1]
            if (password == sqlpw):
                return render(request, 'content/home.html', {"stdname": stu_name})
            else:
                messages.error(request, "There are no user inform. Try again")
        except:
            messages.error(request, "There are no user inform. Try again")
    return render(request, 'content/login.html')

def home(request):
    sql_stu = 'select st.* from student as st where id="' + user + '"'
    sql_dept = 'select dept.* from department as dept join student as st ' \
               'on dept.id = st.dept where st.id="' + user + '"'
    sql = 'select pw, name from student where id="' + user + '"'
    mycursor.execute(sql_stu)
    stu_result = mycursor.fetchall()
    mycursor.execute(sql_dept)
    dept_result = mycursor.fetchall()
    return render(request, 'content/home.html', {"stdname": stu_name})


def prof(request):
    sql_prof = 'select prof.* from professor as prof join department as dept ' \
               'on dept.id = prof.dept where dept.id = (select dept from student ' \
               'where id="' + user + '"'
    mycursor.execute(sql_prof)
    return render(request, 'content/prof.html')