#include <iostream>
#include "lex.h"

using namespace std;

#define shift 20
#define reduce 21
#define accept 22
#define error 23
#define Goto 24

// 파싱 테이블을 만들기 위한 구조체
typedef struct ParsingTable {
	int now_stack;
	int token;
	int action;
	int next_stack;
}Ptable;

// 파싱 테이블 입력
Ptable table[] = {
{ 0, '(', shift, 4 },
{ 0, 'i', shift, 5 },
{ 0, 'n', shift, 6 },
{ 0, 'E', Goto, 1 },
{ 0, 'T', Goto, 2 },
{ 0, 'F', Goto, 3 },

{ 1, '+', shift, 7 },
{ 1, '-', shift, 8 },
{ 1, '$', accept, -1 },

{ 2, '+', reduce, 3 },
{ 2, '-', reduce, 3 },
{ 2, '*', shift, 9 },
{ 2, '/', shift, 10 },
{ 2, ')', reduce, 3 },
{ 2, '$', reduce, 3 },

{ 3, '+', reduce, 6 },
{ 3, '-', reduce, 6 },
{ 3, '*', reduce, 6 },
{ 3, '/', reduce, 6 },
{ 3, ')', reduce, 6 },
{ 3, '$', reduce, 6 },

{ 4, '(', shift, 4 },
{ 4, 'i', shift, 5 },
{ 4, 'n', shift, 6 },
{ 4, 'E', Goto, 11 },
{ 4, 'T', Goto, 2 },
{ 4, 'F', Goto, 3 },

{ 5, '+', reduce, 8 },
{ 5, '-', reduce, 8 },
{ 5, '*', reduce, 8 },
{ 5, '/', reduce, 8 },
{ 5, ')', reduce, 8 },
{ 5, '$', reduce, 8 },

{ 6, '+', reduce, 9 },
{ 6, '-', reduce, 9 },
{ 6, '*', reduce, 9 },
{ 6, '/', reduce, 9 },
{ 6, ')', reduce, 9 },
{ 6, '$', reduce, 9 },

{ 7, '(', shift, 4 },
{ 7, 'i', shift, 5 },
{ 7, 'n', shift, 6 },
{ 7, 'T', Goto, 12 },
{ 7, 'F', Goto, 3 },

{ 8, '(', shift, 4 },
{ 8, 'i', shift, 5 },
{ 8, 'n', shift, 6 },
{ 8, 'T', Goto, 13 },
{ 8, 'F', Goto, 3 },

{ 9, '(', shift, 4 },
{ 9, 'i', shift, 5 },
{ 9, 'n', shift, 6 },
{ 9, 'F', Goto, 14 },

{ 10, '(', shift, 4 },
{ 10, 'i', shift, 5 },
{ 10, 'n', shift, 6 },
{ 10, 'F', Goto, 15 },

{ 11, '+', shift, 7 },
{ 11, '-', shift, 8 },
{ 11, ')', shift, 16 },

{ 12, '+', reduce, 1 },
{ 12, '-', reduce, 1 },
{ 12, '*', shift, 9 },
{ 12, '/', shift, 10 },
{ 12, ')', reduce, 1 },
{ 12, '$', reduce, 1 },

{ 13, '+', reduce, 2 },
{ 13, '-', reduce, 2 },
{ 13, '*', shift, 9 },
{ 13, '/', shift, 10 },
{ 13, ')', reduce, 2 },
{ 13, '$', reduce, 2 },

{ 14, '+', reduce, 4 },
{ 14, '-', reduce, 4 },
{ 14, '*', reduce, 4 },
{ 14, '/', reduce, 4 },
{ 14, ')', reduce, 4 },
{ 14, '$', reduce, 4 },

{ 15, '+', reduce, 5 },
{ 15, '-', reduce, 5 },
{ 15, '*', reduce, 5 },
{ 15, '/', reduce, 5 },
{ 15, ')', reduce, 5 },
{ 15, '$', reduce, 5 },

{ 16, '+', reduce, 7},
{ 16, '-', reduce, 7 },
{ 16, '*', reduce, 7 },
{ 16, '/', reduce, 7 },
{ 16, ')', reduce, 7 },
{ 16, '$', reduce, 7 },
};

int lex_count = 0;

bool CheckLong(int);			// 문법에 따른 스택 위치 조정
char Reducing(int);				// 문법에 따른 reduce 실행
int Check(int, char *, char *);	// 스택에 입력 문장 삽입 및 action 실행
void PrintParser(int, char *, char *, int, int);	// 각 동작 출력
void PrintLex(int);				// reduce한 문법 출력

int main()
{
	Lex l;

	l.Get_Gram();
	char * lex = l.Lexcal();
	char * stack = new char[100]{ 0, };

	cout << "스택\t\t\t\t" << "입력\t\t\t\t" << "동작\t\t\t\t" << endl;
	// 동작을 한단계씩 진행
	for (int k = 0; k != -1;)
	{
		k = Check(k, stack, lex);
	}

	return 0;
}

bool CheckLong(int next)
{
	if (next == 1 || next == 2 || next == 4 || next == 5 || next == 7)
		return true;
	else
		return false;
}

char Reducing(int lexical)
{
	if (lexical == 1 || lexical == 2 || lexical == 3)
		return 'E';
	else if (lexical == 4 || lexical == 5 || lexical == 6)
		return 'T';
	else if (lexical == 7 || lexical == 8 || lexical == 9)
		return 'F';
}

int Check(int k, char * stack, char * lexeme)
{
	for (int i = 0; i < sizeof(table) / (4*sizeof(int)); i++)			// 구조체를 반복해 현재 스택과 토큰에 맞는 동작 판별
	{
		if (stack[k] == table[i].now_stack)
		{
			if (lexeme[lex_count] == table[i].token)
			{
				PrintParser(k, stack, lexeme, table[i].action, table[i].next_stack);
				if (table[i].action == shift)
				{
					stack[k + 1] = table[i].token;
					stack[k + 2] = table[i].next_stack;
					lexeme[lex_count++] = 0;
					k += 2;
					break;
				}
				else if (table[i].action == reduce)
				{
					if (CheckLong(table[i].next_stack))
						k -= 5;
					else
						k -= 1;
					for (int i = k; stack[i] != 0; i++)
					{
						stack[i] = 0;
					}
					stack[k] = Reducing(table[i].next_stack);
					for (int i = 0; i < sizeof(table) / (4 * sizeof(int)); i++)		// 현재 스택에 reduce한 토큰 및 다음 상태값 삽입
					{
						if (stack[k - 1] == table[i].now_stack)
							if (stack[k] == table[i].token)
							{
								stack[k + 1] = table[i].next_stack;
								PrintParser(k, stack, lexeme, table[i].action, table[i].next_stack);
								break;
							}
					}
					k += 1;
					break;
				}
				else if (table[i].action == accept)		// 완료된 경우 종료 값 반환
				{
					return table[i].next_stack;
				}
			}
		}
	}
	return k;
}

void PrintParser(int k, char * stack, char * lexeme, int action, int nexttoken)
{
	for (int i = 0; i <= k; i++)
	{
		if (stack[i] >= 0 && stack[i] <= 16)
			cout << (int)stack[i];
		else if (stack[i] == 'i')
			cout << "id";
		else if (stack[i] == 'n')
			cout << "num";
		else
			cout << stack[i];
	}
	cout << "\t\t\t\t";
	int i = 0;
	do
	{
		cout << lexeme[i];
	} while (lexeme[i++] != '$');
	cout << "\t\t\t\t";
	if (action == shift)
	{
		cout << "shift " << nexttoken << endl;
	}
	else if (action == reduce)
	{
		cout << "reduce by ";
		PrintLex(nexttoken);
		cout << endl;
	}
	else if (action == Goto)
	{
		cout << "Goto " << nexttoken << endl;
	}
	else if (action == accept)
	{
		cout << "accept" << endl;
	}
}

void PrintLex(int action)
{
	switch (action)
	{
	case 1:
		cout << "E -> E + T";
		break;
	case 2:
		cout << "E -> E - T";
		break;
	case 3:
		cout << "E -> T";
		break;
	case 4:
		cout << "T -> T * F";
		break;
	case 5:
		cout << "T -> T / F";
		break;
	case 6:
		cout << "T -> F";
		break;
	case 7:
		cout << "F -> (E)";
		break;
	case 8:
		cout << "F -> id";
		break;
	case 9:
		cout << "F -> num";
		break;
	default:
		break;
	}
}