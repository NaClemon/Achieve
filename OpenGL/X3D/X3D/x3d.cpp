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

struct vertex *v = new struct vertex[MAX];
struct face *f = new struct face[MAX];

int vcount = 0;
int fcount = 0;

void
FileRead()
{

	FILE *obj;
	fopen_s(&obj, "ex.x3d", "r");
	bool quad_polygon = true;

	while (!feof(obj))
	{
		char temp[1000];
		char *token;
		char *content;
		fgets(temp, sizeof(temp), obj);

		token = strtok_s(temp, " <>:\t=\"", &content);

		// face�� ������ ������ �ִ� ���� �κ��� ã�´�
		if (strcmp(token, "IndexedFaceSet") == 0)
		{
			while (true)
			{
				int abc = 0;
				// �� �پ� �д´�
				fgets(temp, sizeof(temp), obj);
				token = strtok_s(temp, " ", &content);

				if (strcmp(token, "\">\n") == 0)
					break;

				// ù��° vertex ��ȣ�� �����Ѵ�
				f[fcount].a = atoi(token);
				abc++;

				while (true)
				{
					// �̾ ���� ���� ��� �о� ������
					char * vertex = strtok_s(NULL, " ", &content);

					if (vertex == NULL)
						break;

					// �ι�° vertex ��ȣ ����
					else if (abc == 1)
					{
						f[fcount].b = atoi(vertex);
						abc++;
					}
					// ����° vertex ��ȣ ���� �� face ���� ����
					else if (abc == 2)
					{
						f[fcount].c = atoi(vertex);
						abc++;
						fcount++;
						break;
					}
				}
			}
		}
		// vertex�� ������ ���� �ִ� ���� ã�´�
		else if (strcmp(token, "Coordinate") == 0)
		{
			int xyz = 0;
			fgets(temp, sizeof(temp), obj);
			token = strtok_s(temp, " <>=\"/", &content);
			
			// ù��° ��ū�� v1�� x��ǥ�̴�
			v[vcount].point[xyz] = atof(token);
			xyz++;

			while (true)
			{
				// �̾ �ش� ���� �д´�
				char * vertex = strtok_s(NULL, " <>=\"/\n", &content);

				if (vertex == NULL)
					break;

				// �� ��ǥ�� �����Ѵ�
				v[vcount].point[xyz] = atof(vertex);
				xyz++;

				// z ��ǥ�� �Է� �Ǹ� ���� vertex�� x��ǥ�� �Է¹޴´�
				if (xyz == 3)
				{
					xyz = 0;
					vcount++;
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
/// <param name="e">������ ���� ������ r ���� -> object �ľ� ����</param>
void
Polygon(int a, int b, int c, float e)
{
	GLfloat temp[3] = { e, 0.0, 0.0 };
	glBegin(GL_POLYGON);
	glColor3fv(temp);
	glVertex3fv(v[a].point);
	glColor3fv(temp);
	glVertex3fv(v[b].point);
	glColor3fv(temp);
	glVertex3fv(v[c].point);
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
		Polygon(f[i].a, f[i].b, f[i].c, (i*0.03) + 0.03);
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
	glOrtho(-0.5, 0.5, -0.5, 0.5, -0.5, 0.5);
	glEnable(GL_DEPTH_TEST);
	glutDisplayFunc(Display);
	glutMainLoop();

	delete[] v;
	delete[] f;

	return 0;
}