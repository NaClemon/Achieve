from django.shortcuts import render
from django.contrib import messages
import json

# Create your views here.
def home(request):
    return render(request, 'content/main.html')

notes = []
title = ""
note = ""

def note(request):
    return render(request, 'content/note.html')

def list(request):
    if request.method == "POST":
        try:
            title = request.POST.get("title")
            note = request.POST.get("note")
            notes.append([title, note])
        except Exception as e:
            messages.error(request, repr(e))
    return render(request, 'content/list.html', {'List': title, 'Note': note})