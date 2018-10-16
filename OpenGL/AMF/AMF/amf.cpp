#include <gl/glut.h>
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

#define MAX 100

// vertex 좌표를 저장할 구조체
struct vertex {
	GLfloat point[3];
};

// 폴리곤을 구성하는 vertex 번호를 저장할 구조체
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
	fopen_s(&obj, "ex.amf", "r");
	bool quad_polygon = true;

	while (!feof(obj))
	{
		char temp[500];
		char *token;
		char *content;
		fgets(temp, sizeof(temp), obj);

		token = strtok_s(temp, " <>\"=", &content);

		// vertex 값 저장
		if (strcmp(token, "vertex") == 0)
		{
			char * vertex;

			while (true)
			{
				char * temp_token = strtok_s(NULL, " <>", &content);
				if (temp_token == NULL)
					break;

				// x, y, z에 있는 값을 vertex에 넣는다
				if (strcmp(temp_token, "x") == 0)
				{
					vertex = strtok_s(NULL, " <>", &content);
					v[vcount].point[0] = atof(vertex);
				}
				else if (strcmp(temp_token, "y") == 0)
				{
					vertex = strtok_s(NULL, " <>", &content);
					v[vcount].point[1] = atof(vertex);
				}
				else if (strcmp(temp_token, "z") == 0)
				{
					vertex = strtok_s(NULL, " <>", &content);
					v[vcount].point[2] = atof(vertex);
					vcount++;
				}
			}
		}
		// 각 면을 구성하는 vertex에 대한 정보 저장
		else if (strcmp(token, "triangle") == 0)
		{
			char * face;

			while (true)
			{
				char * temp_token = strtok_s(NULL, " <>", &content);
				if (temp_token == NULL)
					break;

				// v1, v2, v3에 대한 값을 넣는다
				if (strcmp(temp_token, "v1") == 0)
				{
					face = strtok_s(NULL, " <>", &content);
					f[fcount].a = atoi(face);
				}
				else if (strcmp(temp_token, "v2") == 0)
				{
					face = strtok_s(NULL, " <>", &content);
					f[fcount].b = atoi(face);
				}
				else if (strcmp(temp_token, "v3") == 0)
				{
					face = strtok_s(NULL, " <>", &content);
					f[fcount].c = atoi(face);
					fcount++;
				}
			}
		}
	}

	fclose(obj);
}

/// <summary>
/// 폴리건 생성 함수
/// </summary>
/// <param name="a">a 번째 vertex 및 normal 벡터</param>
/// <param name="b">b 번째 vertex 및 normal 벡터</param>
/// <param name="c">c 번째 vertex 및 normal 벡터</param>
/// <param name="e">폴리건 생성 순으로 r 색상 -> object 파악 위함</param>
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
/// cube 생성 및 회전
/// </summary>
void
Cube()
{
	// cube 회전
	glRotatef(40, 0.0f, 0.0f, 1.0f);
	glRotatef(60, 1.0f, 0.0f, 0.0f);
	glRotatef(70, 0.0f, 1.0f, 0.0f);
	
	for (int i = 0; i < fcount; i++)
	{
		// 폴리곤 생성 및 색 부여
		Polygon(f[i].a, f[i].b, f[i].c, (i*0.08) + 0.08);
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
	glutCreateWindow("amf");
	glClearColor(1.0, 1.0, 1.0, 1.0);
	glOrtho(-2.0, 2.0, -2.0, 2.0, -2.0, 2.0);
	glEnable(GL_DEPTH_TEST);
	glutDisplayFunc(Display);
	glutMainLoop();

	delete[] v;
	delete[] f;

	return 0;
}