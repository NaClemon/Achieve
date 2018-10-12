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
	int d;
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
	fopen_s(&obj, "ex.fbx", "r");

	while (!feof(obj))
	{
		char temp[100];
		bool quad_polygon = false;
		char *token;
		fgets(temp, sizeof(temp), obj);

		token = strtok(temp, ":");

		if (strcmp(token, "Geometry") == 0 && !quad_polygon)
		{
			quad_polygon = true;
			continue;
		}
		if (strcmp(token, "Vertices") == 0)
		{
			char vertices[250];
			fgets(vertices, sizeof(vertices), obj);

			char * point = strtok(vertices, ":,");
			int xyz = 0;

			while (point != NULL)
			{
				strtok(NULL, ":,");
				v[vcount].point[xyz] = atof(point);
				xyz++;
				if (xyz == 4)
				{
					xyz = 0;
					vcount++;
				}
			}
		}
		else if (strcmp(token, "PolygonVertexIndex") == 0)
		{
			char index[250];
			fgets(index, sizeof(index), obj);

			char * point = strtok(index, ":,");
			int abcd = 0;

			while (point != NULL)
			{
				strtok(NULL, ":,");
				int order = atoi(point);
				switch (order)
				{
				case 0:
					f[fcount].a = order;
					break;
				case 1:
					f[fcount].b = order;
					break;
				case 2:
					f[fcount].c = order;
					break;
				case 3:
					f[fcount].d = -1 * order;
					fcount++;
					break;
				}
			}
		}
		else if (strcmp(token, "Normals") == 0)
		{
			char normal[250];
			fgets(normal, sizeof(normal), obj);

			char * point = strtok(normal, ":,");
			int xyz = 0;

			while (point != NULL)
			{
				strtok(NULL, ":,");
				n[ncount].point[xyz] = atof(point);
				xyz++;
				if (xyz == 4)
				{
					xyz = 0;
					ncount++;
				}
			}
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
Polygon(int a, int b, int c, int d, float e)
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
	glColor3fv(temp);
	glNormal3fv(n[d].point);
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
		Polygon(f[i].a - 1, f[i].b - 1, f[i].c - 1, f[i].d - 1, (i*0.05) + 0.05);
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
	glutCreateWindow("fbx");
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