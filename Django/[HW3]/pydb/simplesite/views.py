from django.shortcuts import render
from django.contrib import messages
import mysql.connector
import json

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
stid = ""
phone = ""
email = ""
adviser = ""
dept_name = ""
dept_loc = ""
prof_result = []

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
                return render(request, 'content/main.html', {"stdname": stu_name})
            else:
                messages.error(request, "There are no user inform. Try again")
        except:
            messages.error(request, "There are no user inform. Try again")
    return render(request, 'content/login.html')

def main(request):
    return render(request, 'content/main.html', {"stdname": stu_name})

def home(request):
    global user
    global stu_name
    global stid, phone, email, adviser, dept_name, dept_loc
    sql_stu = 'select st.id, st.name, st.phone, st.email, ' \
              'prof.name from student as st join professor as prof' \
              ' on st.adviser = prof.id where st.id="' + user + '"'
    sql_dept = 'select dept.name, dept.location from department as dept join student as st ' \
               'on dept.id = st.dept where st.id="' + user + '"'
    try:
        mycursor.execute(sql_stu)
        stu_result = mycursor.fetchone()
        stid = stu_result[0]
        phone = stu_result[2]
        email = stu_result[3]
        adviser = stu_result[4]
        mycursor.execute(sql_dept)
        dept_result = mycursor.fetchone()
        dept_name = dept_result[0]
        dept_loc = dept_result[1]
    except:
        messages.error(request, "")
    return render(request, 'content/home.html', {"stdname": stu_name, "id": stid, "phone": phone,
                                                 "email": email, "adviser": adviser,
                                                 "dept_name": dept_name, "dept_loc": dept_loc})


def prof(request):
    global prof_result
    sql_prof = 'select prof.name, prof.phone, prof.email from professor as prof join department as dept ' \
               'on dept.id = prof.dept where dept.id = (select dept from student ' \
               'where id="' + user + '")'
    try:
        mycursor.execute(sql_prof)
        prof_result = mycursor.fetchall()
    except:
        messages.error(request, "")

    return render(request, 'content/prof.html', {"stdname": stu_name, "prof_result": prof_result})