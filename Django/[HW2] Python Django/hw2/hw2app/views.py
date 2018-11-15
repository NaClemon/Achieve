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

notes = {'Title': [], 'Note': []}
title = ""
note = ""

def note(request):
    return render(request, 'content/note.html')

def list(request):
    if request.method == "POST":
        try:
            title = request.POST.get("title")
            note = request.POST.get("note")
            notes['Title'].append(title)
            notes['Note'].append(note)
        except Exception as e:
            messages.error(request, repr(e))
    return render(request, 'content/list.html')

def home(request):
    return render(request, 'content/home.html')