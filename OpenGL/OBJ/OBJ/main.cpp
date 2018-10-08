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
	GLfloat x;
	GLfloat y;
	GLfloat z;
};

void
FileRead()
{
	struct vertex *v = new struct vertex[MAX];
	struct face *f = new struct face[MAX];
	ifstream input("ex.obj");
	int vcount = 0;
	int fcount = 0;
	
	while (!input.eof())
	{
		char temp;
		input >> temp;

		if (temp == 'v')
		{
			input >> v[vcount].x;
			input >> v[vcount].y;
			input >> v[vcount].z;
			vcount++;
		}
		else if (temp == 'f')
		{
			input >> f[fcount].x;
			input >> f[fcount].y;
			input >> f[fcount].z;
			fcount++;
		}
	}
}

void
Polygon()
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