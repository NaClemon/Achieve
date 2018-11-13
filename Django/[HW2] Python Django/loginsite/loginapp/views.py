from django.shortcuts import render
from django.contrib import messages
# Create your views here.
def login(request):
	if request.method == "POST":
		u = request.POST.get("username")
		p = request.POST.get("password")
		if (u == "admin" and p == "password"):
			messages.success(request, "Correct!")
		else:
			messages.error(request, "Incorrect!")
	return render(request, 'content/login.html')