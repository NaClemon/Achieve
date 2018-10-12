#include <gl/glut.h>
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

#define MAX 100

// vertex ��ǥ�� ������ ����ü
struct vertex {
	GLfloat point[3];
};

// �������� �����ϴ� vertex ��ȣ�� ������ ����ü
struct face {
	int a;
	int b;
	int c;
};

// normal ���͸� ������ ����ü
struct normal {
	GLfloat point[3];
};

struct vertex *v = new struct vertex[MAX];
struct face *f = new struct face[MAX];
struct normal *n = new struct normal[MAX];

int vcount = 0;
int fcount = 0;
int ncount = 0;

void
FileRead()
{

	FILE *obj;
	fopen_s(&obj, "ex.obj", "r");

	while (!feof(obj))
	{
		char temp[100];
		fscanf_s(obj, "%s", temp, sizeof(temp));

		if (strcmp(temp, "v") == 0)
		{
			// vertex ��ǥ ����(x, y, z)
			fscanf_s(obj, "%f %f %f", &v[vcount].point[0], &v[vcount].point[1], &v[vcount].point[2]);
			vcount++;
		}
		else if (strcmp(temp, "f") == 0)
		{
			// ������ ������ ���� vertex ��ȣ ����
			char tmpnum[3][50];
			fscanf_s(obj, "%s %s %s", tmpnum[0], sizeof(tmpnum[0]), tmpnum[1], sizeof(tmpnum[1]), tmpnum[2], sizeof(tmpnum[2]));
			f[fcount].a = atoi(tmpnum[0]);
			f[fcount].b = atoi(tmpnum[1]);
			f[fcount].c = atoi(tmpnum[2]);
			fcount++;
		}
		else if (strcmp(temp, "vn") == 0)
		{
			// normal ��ǥ ����
			fscanf_s(obj, "%f %f %f", &n[ncount].point[0], &n[ncount].point[1], &n[ncount].point[2]);
			ncount++;
		}
	}

	fclose(obj);
}

/// <summary>
/// ������ ���� �Լ�
/// </summary>
/// <param name="a">a ��° vertex �� normal ����</param>
/// <param name="b">b ��° vertex �� normal ����</param>
/// <param name="c">c ��° vertex �� normal ����</param>
/// <param name="d">������ ���� ������ r ���� -> object �ľ� ����</param>
void
Polygon(int a, int b, int c, float d)
{
	GLfloat temp[3] = { d, 0.0, 0.0 };
	glColor3fv(temp);
	glNormal3fv(n[a].point);
	glVertex3fv(v[a].point);
	glColor3fv(temp);
	glNormal3fv(n[b].point);
	glVertex3fv(v[b].point);
	glColor3fv(temp);
	glNormal3fv(n[c].point);
	glVertex3fv(v[c].point);
}

/// <summary>
/// cube ���� �� ȸ��
/// </summary>
void
Cube()
{
	// cube ȸ��
	glRotatef(30, 1.0f, 0.0f, 0.0f);
	glRotatef(30, 0.0f, 0.0f, 1.0f);

	glBegin(GL_POLYGON);
	for (int i = 0; i < fcount; i++)
	{
		// ������ ���� �� �� �ο�
		Polygon(f[i].a - 1, f[i].b - 1, f[i].c - 1, (i*0.05) + 0.05);
	}
	glEnd();
	glutSwapBuffers();
}

void
Display()
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	FileRead();
	Cube();
	glFlush();
}

int
main(int argc, char **argv)
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_DEPTH);
	glutInitWindowSize(500, 500);
	glutInitWindowPosition(0, 0);
	glutCreateWindow("OBJ");
	glClearColor(1.0, 1.0, 1.0, 1.0);
	glOrtho(-4.0, 4.0, -4.0, 4.0, -4.0, 4.0);
	glEnable(GL_DEPTH_TEST);
	glutDisplayFunc(Display);
	glutMainLoop();

	delete[] v;
	delete[] n;
	delete[] f;

	return 0;
}