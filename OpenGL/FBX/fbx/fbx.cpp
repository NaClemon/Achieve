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
	bool quad_polygon = true;

	while (!feof(obj))
	{
		char temp[100];
		char *token;
		char *content;
		fgets(temp, sizeof(temp), obj);

		token = strtok_s(temp, ":\t", &content);
		
		// Geometry�� object�� ���� ������ �ִ�.
		if (strcmp(token, "Geometry") == 0)
		{
			// quad�� ����ϴ� �ι�° Geometry���� ������ �޾ƿ��� ����
			if (quad_polygon)
			{
				quad_polygon = false;
				continue;
			}
			else
			{
				while (!feof(obj))
				{
					fgets(temp, sizeof(temp), obj);
					token = strtok_s(temp, ":\t", &content);

					// ��ǥ�� ���� ������ ����
					if (strcmp(token, "Vertices") == 0 && !quad_polygon)
					{
						char vertices[1000];
						fgets(vertices, sizeof(vertices), obj);

						// ��ǥ ������ ���� ������
						char * point = strtok_s(vertices, ":,", &content);
						int xyz = 0;

						while (true)
						{
							// ','�� �и��Ǿ� �ִ� ��ǥ�� �б� ����
							char * temp = strtok_s(NULL, ":,", &content);
							// ���������� �а� Ż��
							if (temp == NULL)
								break;
							// �� ���� ����
							v[vcount].point[xyz] = atof(temp);
							xyz++;
							// 3���� ��ǥ�̹Ƿ� 3��° ���� ������
							// vertex ���� ����
							if (xyz == 3)
							{
								xyz = 0;
								vcount++;
							}
						}
					}
					// face�� ���� ������ �޴´�
					else if (strcmp(token, "PolygonVertexIndex") == 0 && !quad_polygon)
					{
						char index[1000];
						fgets(index, sizeof(index), obj);

						// ��ǥ ������ ���� ������
						char * point = strtok_s(index, ":,", &content);
						int abcd = 0;

						while (true)
						{
							// ','�� �и��Ǿ� �ִ� ������ �б� ����
							char * temp = strtok_s(NULL, ":,", &content);
							// ������ ���� �а� Ż��
							if (temp == NULL)
								break;
							int order = atoi(temp);
							// 4���� vertex ������ �ޱ� ����
							switch (abcd)
							{
							case 0:
								f[fcount].a = order;
								abcd++;
								break;
							case 1:
								f[fcount].b = order;
								abcd++;
								break;
							case 2:
								f[fcount].c = order;
								abcd++;
								break;
							case 3:
								// 4��° ���� �����̹Ƿ� ����� ġȯ
								// 2�� ���� �̿�
								// 4�� �� face ���� ����
								f[fcount].d = -1 * order - 1;
								abcd = 0;
								fcount++;
								break;
							}
						}
					}
					// normal�� ���� ������ �޴´�
					else if (strcmp(token, "Normals") == 0 && !quad_polygon)
					{
						char normal[1000];
						fgets(normal, sizeof(normal), obj);
						// ��ǥ ���� ���� ������
						char * point = strtok_s(normal, ":,", &content);
						int xyz = 0;

						// vertex�� ���� ������ ������
						while (true)
						{
							char * temp = strtok_s(NULL, ":,", &content);
							if (temp == NULL)
								break;
							n[ncount].point[xyz] = atof(temp);
							xyz++;
							if (xyz == 3)
							{
								xyz = 0;
								ncount++;
							}
						}
					}

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
/// <param name="d">d ��° vertex �� normal ����</param>
/// <param name="e">������ ���� ������ r ���� -> object �ľ� ����</param>
void
Polygon(int a, int b, int c, int d, float e)
{
	GLfloat temp[3] = { e, 0.0, 0.0 };
	glBegin(GL_POLYGON);
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
	glVertex3fv(v[d].point);
	glEnd();
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

	for (int i = 0; i < fcount; i++)
	{
		// ������ ���� �� �� �ο�
		Polygon(f[i].a, f[i].b, f[i].c, f[i].d, (i*0.15) + 0.1);
	}
	
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
	glOrtho(-120.0, 120.0, -120.0, 120.0, -120.0, 120.0);
	glEnable(GL_DEPTH_TEST);
	glutDisplayFunc(Display);
	glutMainLoop();

	delete[] v;
	delete[] n;
	delete[] f;

	return 0;
}