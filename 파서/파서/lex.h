#pragma once

class Lex
{
private:
	char * sentence;
	char * lex;

public:
	void Get_Gram();				// ������ �Է� �ޱ� ���� �Լ�
	int Check_Tokentype(char);		// id, ����, ����, �����ڸ� �����ϱ� ���� �Լ�
	int Pass(int, char *, int);		// id�� num�� �Ǵ� �Ҷ� 1���� ���� �Ǵ�, ������ �ѱ�� ����
	char * Lexcal();					// ��ū ��ȣ ���� �Լ�
	~Lex();
};

