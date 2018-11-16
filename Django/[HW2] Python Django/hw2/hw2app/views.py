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
    avggrade = 0
    if request.method == "POST":
        try:
            count = request.POST.get("count")
            sumgrade = 0
            sumunits = 0
            for i in range(0, int(count)):
                stri = str(i)
                grade = request.POST.get("grade" + stri)
                unit = request.POST.get("unit" + stri)
                sumgrade += float(grade)*float(unit)
                sumunits += float(unit)
            avggrade = sumgrade / sumunits
        except Exception as e:
            messages.error(request, repr(e))
    return render(request, 'content/note.html', {'avg': avggrade})

notes = []

def memo(request):
    stri = ""
    if request.method == "POST":
        try:
            title = request.POST.get("title")
            note = request.POST.get("memo")
            notes.append([title, note])
            temp = len(notes)
            for row in range(0, temp):
                stri = notes[row][0] + " / " + notes[row][1] + "\n"
                messages.info(request, stri)
        except Exception as e:
            messages.error(request, repr(e))
    return render(request, 'content/memo.html')


def home(request):
    return render(request, 'content/home.html')