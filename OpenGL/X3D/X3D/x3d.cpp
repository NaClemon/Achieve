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
	fopen_s(&obj, "ex.x3d", "r");

	while (!feof(obj))
	{
		char temp[100];
		fscanf_s(obj, "%s", temp, sizeof(temp));

		if (strcmp(temp, "point=\"") == 0)
		{
			int xyz_check = 0;
			// vertex 좌표 저장(x, y, z)
			while (true)
			{
				char find[50];
				fscanf_s(obj, "%s", find, sizeof(find));
				if (!strcmp(find, "\"/>"))
					break;
				else
				{
					v[vcount].point[xyz_check] = atof(find);
					xyz_check++;
					if (xyz_check == 4)
					{
						xyz_check = 0;
						vcount++;
					}
				}
			}
		}
		else if (strcmp(temp, "coordIndex=\"") == 0)
		{
			// 폴리곤 생성을 위한 vertex 번호 저장
			while (true)
			{
				char tmpnum[3][50];
				char end[50];
				fscanf_s(obj, "%s %s %s", tmpnum[0], sizeof(tmpnum[0]), tmpnum[1], sizeof(tmpnum[1]), tmpnum[2], sizeof(tmpnum[2]));
				f[fcount].a = atoi(tmpnum[0]);
				f[fcount].b = atoi(tmpnum[1]);
				f[fcount].c = atoi(tmpnum[2]);
				fcount++;

				fscanf_s(obj, "%s", end, sizeof(end));
				if (!strcmp(end, "-1"))
					break;
			}
		}
	}

	fclose(obj);
}

void
Normal(int a, int b, int c)
{
	GLfloat AB[3];
	GLfloat AC[3];

	for (int i = 0; i < 3; i++)
	{
		AB[i] = v[b].point[i] - v[a].point[i];
		AC[i] = v[c].point[i] - v[a].point[i];
	}

	n[ncount].point[0] = 
}

/// <summary>
/// 폴리건 생성 함수
/// </summary>
/// <param name="a">a 번째 vertex 및 normal 벡터</param>
/// <param name="b">b 번째 vertex 및 normal 벡터</param>
/// <param name="c">c 번째 vertex 및 normal 벡터</param>
/// <param name="d">폴리건 생성 순으로 r 색상 -> object 파악 위함</param>
void
Polygon(int a, int b, int c, float d)
{
	GLfloat temp[3] = { d, 0.0, 0.0 };
	glColor3fv(temp);
	glVertex3fv(v[a].point);
	glColor3fv(temp);
	glVertex3fv(v[b].point);
	glColor3fv(temp);
	glVertex3fv(v[c].point);
}

/// <summary>
/// cube 생성 및 회전
/// </summary>
void
Cube()
{
	// cube 회전
	glRotatef(45, 1.0f, 0.0f, 0.0f);
	glRotatef(45, 0.0f, 0.0f, 1.0f);

	glBegin(GL_POLYGON);
	//for (int i = 0; i < fcount; i++)
	//{
	//	// 폴리곤 생성 및 색 부여
	//	Polygon(f[i].a - 1, f[i].b - 1, f[i].c - 1, (i*0.05) + 0.05);
	//}
	Polygon(2, 7, 19, 1);
	Polygon(19, 10, 2, 1);
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
	delete[] f;

	return 0;
}