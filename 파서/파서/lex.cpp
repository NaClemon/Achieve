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

char * Lex::Lexcal()
{
	int i = 0;
	int count = 0;
	lex = new char[strlen(sentence) + 2]{ 0, };
	while (sentence[i] != '\0')
	{
		int chtoken = Check_Tokentype(sentence[i]);
		if (chtoken == 0)
		{
			lex[count] = 'i';
			i = Pass(i, sentence, 0);
			count++;
		}
		else if (chtoken == 1)
		{
			lex[count] = 'n';
			i = Pass(i, sentence, 1);
			count++;
		}
		else if (chtoken == 2)			// 공백 무시
			i++;
		else if (chtoken == 3)
		{
			lex[count] = sentence[i];
			i++;
			count++;
		}
	}
	lex[count] = '$';
	return lex;
}

Lex::~Lex()
{
	delete[] sentence;
	delete[] lex;
}