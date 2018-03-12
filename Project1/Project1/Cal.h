#pragma once

class Calculator
{
private:
	int add_count;
	int min_count;
	int mul_count;
	int div_count;

public:
	void Init();
	double Add(double a, double b);
	double Min(double a, double b);
	double Mul(double a, double b);
	double Div(double a, double b);
	void ShowOpCount();
};