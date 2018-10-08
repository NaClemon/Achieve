#include <gl/glut.h>
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

#define MAX 50

struct vertex {
	GLfloat x;
	GLfloat y;
	GLfloat z;
};

struct face {
	int a;
	int b;
	int c;
};

struct normal {
	GLfloat x;
	GLfloat y;
	GLfloat z;
};

void
FileRead()
{
	struct vertex *v = new struct vertex[MAX];
	struct face *f = new struct face[MAX];
	struct normal *n = new struct normal[MAX];

	ifstream input("ex.obj");
	int vcount = 0;
	int fcount = 0;
	int ncount = 0;
	
	while (!input.eof())
	{
		string temp;
		input >> temp;

		if (temp.compare("v") == 0)
		{
			input >> v[vcount].x;
			input >> v[vcount].y;
			input >> v[vcount].z;
			vcount++;
		}
		else if (temp.compare("f") == 0)
		{
			input >> f[fcount].a;
			input >> f[fcount].b;
			input >> f[fcount].c;
			fcount++;
		}
		else if (temp.compare("vn") == 0)
		{
			input >> f[ncount].a;
			input >> f[ncount].b;
			input >> f[ncount].c;
			ncount++;
		}
	}
}

void
Polygon(int a, int b, int c)
{

}

int
main(int argc, char **argv)
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_DEPTH);
	glutInitWindowSize(500, 500);
	glutCreateWindow("OBJ");
	glClearColor(0.0, 0.0, 0.0, 1.0);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrtho(-1.0, 1.0, -1.0, 1.0, -1.0, 1.0);
}