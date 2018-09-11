#pragma once

class Lex
{
private:
	char * sentence;
	int * lex;

public:
	void Get_Gram();				// ������ �Է� �ޱ� ���� �Լ�
	int Check_Tokentype(char);		// id, ����, ����, �����ڸ� �����ϱ� ���� �Լ�
	int Pass(int, char *, int);		// id�� num�� �Ǵ� �Ҷ� 1���� ���� �Ǵ�, ������ �ѱ�� ����
	int Check_Operator(char);		// ������ �Ǻ�
	int * Lexcal();					// ��ū ��ȣ ���� �Լ�
	~Lex();
};

enum class TokenNum		// ��ū ��ȣ �Ҵ�
{
	plus = 1, min, mul, div, opar, cpar, id, num
};