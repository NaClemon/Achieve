#include <iostream>
#include "lex.h"

using namespace std;

int main()
{
	Lex l;

	l.Get_Gram();
	int * lex = l.Lexcal();
	
	int i = 0;
	cout << endl;
	while (lex[i] != 0)
	{
		cout << lex[i] << " ";
		i++;
	}
	cout << endl << endl;

	return 0;
}