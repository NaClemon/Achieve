#include <iostream>
#include <string>
#include <ctype.h>
#include "lex.h"

using namespace std;

void Lex::Get_Gram()
{
	string temp;

	cout << "C > lexcal" << endl << endl;
	cout << "문장 입력: ";
	getline(cin, temp, '\n');

	sentence = new char[temp.size() + 1];

	strcpy_s(sentence, temp.size() + 1, temp.c_str());
}

int Lex::Check_Tokentype(char ch)
{
	if (isalpha(ch) || ch == '_')
		return 0;
	else if (isdigit(ch))
		return 1;
	else if (ch == ' ')
		return 2;
	else
		return 3;
}

int Lex::Pass(int i, char * sen, int id)
{
	if (id == 0)
	{
		while (isalpha(sen[i]) || sen[i] == '_' || isdigit(sen[i]))
			i++;
	}
	else if (id == 1)
	{
		while (isdigit(sen[i]))
			i++;
	}

	return i;
}

int Lex::Check_Operator(char ch)
{
	int toknum;
	switch (ch)
	{
	case '+':
		toknum = static_cast<int>(TokenNum::plus);
		break;
	case '-':
		toknum = static_cast<int>(TokenNum::min);
		break;
	case '*':
		toknum = static_cast<int>(TokenNum::mul);
		break;
	case '/':
		toknum = static_cast<int>(TokenNum::div);
		break;
	case '(':
		toknum = static_cast<int>(TokenNum::opar);
		break;
	case ')':
		toknum = static_cast<int>(TokenNum::cpar);
		break;
	default:
		break;
	}

	return toknum;
}

int * Lex::Lexcal()
{
	int i = 0;
	int count = 0;
	lex = new int[strlen(sentence) + 1]{ 0, };
	while (sentence[i] != '\0')
	{
		int chtoken = Check_Tokentype(sentence[i]);
		if (chtoken == 0)
		{
			lex[count] = static_cast<int>(TokenNum::id);
			i = Pass(i, sentence, 0);
			count++;
		}
		else if (chtoken == 1)
		{
			lex[count] = static_cast<int>(TokenNum::num);
			i = Pass(i, sentence, 1);
			count++;
		}
		else if (chtoken == 2)			// 공백 무시
			i++;
		else if (chtoken == 3)
		{
			lex[count] = Check_Operator(sentence[i]);
			i++;
			count++;
		}
	}
	return lex;
}

Lex::~Lex()
{
	delete[] sentence;
	delete[] lex;
}