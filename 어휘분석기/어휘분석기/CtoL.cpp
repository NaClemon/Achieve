#include <iostream>
#include <string>

using namespace std;


char * Get_Gram(); // 토큰열 입력받기


				   // 읽기

int Token(char);// 스위치로 토큰 번호 부여

char * Mid_Lex(char *); // num과 id 식별

int main()
{
	char * sentence = Get_Gram();

	Mid_Lex(sentence);
	cout << sentence << endl;


	delete[]sentence;
	return 0;
}

char * Get_Gram()
{
	string temp;

	cout << "토큰열 입력: ";
	getline(cin, temp, '\n');

	char * sentence = new char[temp.size() + 1];

	strcpy_s(sentence, temp.size() + 1, temp.c_str());

	return sentence;
}

char * Mid_Lex(char * sen)
{
	int i = 0;

	char * mid_lex = new char[strlen(sen) + 1];

	while (sen[i] != '\0')
	{
		if (sen[i] >= 'a' || sen[i] <= 'z' || sen[i] >= 'A' || sen[i] <= 'Z')
		{
			strcat(mid_lex, "id");
		}
		else if (sen[i] >= 0 || sen[i] <= 9)
		{
			strcat(mid_lex, "num");
		}
		else
		{
			strcat(mid_lex, sen[i]);
		}
	}
}