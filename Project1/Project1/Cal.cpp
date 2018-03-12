#include <iostream>
#include "Cal.h"

using namespace std;

void Calculator::Init()
{
	add_count = 0;
	min_count = 0;
	mul_count = 0;
	div_count = 0;
}
double Calculator::Add(double a, double b)
{
	add_count += 1;
	return a + b;
}
double Calculator::Min(double a, double b)
{
	min_count += 1;
	return a - b;
}
double Calculator::Mul(double a, double b)
{
	mul_count += 1;
	return a * b;
}
double Calculator::Div(double a, double b)
{
	div_count += 1;
	return a / b;
}
void Calculator::ShowOpCount()
{
	cout << "����: " << add_count << " ����: " << min_count << " ����: " << mul_count << " ������: " << div_count << endl;
}