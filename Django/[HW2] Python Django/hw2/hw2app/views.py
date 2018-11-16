from django.shortcuts import render
from django.contrib import messages
import json

# Create your views here.
def main(request):
    return render(request, 'content/main.html')

def login(request):
    return render(request, 'content/login.html')

def loginact(request):
    if (request.method == 'POST'):
        username = request.POST.get("username")
        password = request.POST.get("password")
        if (username == "skh" and password == "1018"):
            return render(request, 'content/main.html')
        else:
            messages.error(request, "Go Away! You're Not Son!")
    return render(request, 'content/loginact.html')

def info(request):
    return render(request, 'content/intro.html')

def note(request):
    if request.method == "POST":
        try:
            count = request.POST.get("count")
            sumgrade = 0
            sumunits = 0
            for i in range(0, int(count)):
                stri = str(i)
                grade = request.POST.get("grade" + stri)
                unit = request.POST.get("unit" + stri)
                sumgrade += float(grade)
                sumunits += float(unit)
            avggrade = sumgrade / sumunits
            messages.info(request, "평균 학점: " + str(avggrade))
        except Exception as e:
            messages.error(request, repr(e))
    return render(request, 'content/note.html')

def home(request):
    return render(request, 'content/home.html')