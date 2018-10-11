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

// normal 벡터를 저장할 구조체
struct normal {
	GLfloat point[3];
};

struct vertex *v = new struct vertex[MAX];
struct normal *n = new struct normal[MAX];

int vcount = 0;
int ncount = 0;
int max_scale = 0;

void
FileRead()
{

	FILE *obj;
	fopen_s(&obj, "ex.stl", "r");

	while (!feof(obj))
	{
		char temp[100];
		fscanf_s(obj, "%s", temp, sizeof(temp));

		if (strcmp(temp, "vertex") == 0)
		{
			// vertex 좌표 저장(x, y, z)
			fscanf_s(obj, "%f %f %f", &v[vcount].point[0], &v[vcount].point[1], &v[vcount].point[2]);
			vcount++;
		}
		else if (strcmp(temp, "normal") == 0)
		{
			// normal 좌표 저장
			fscanf_s(obj, "%f %f %f", &n[ncount].point[0], &n[ncount].point[1], &n[ncount].point[2]);
			ncount++;
		}
	}

	fclose(obj);
}

/// <summary>
/// 폴리건 생성 함수
/// </summary>
/// <param name="num">num번째 삼각형의 vertex와 normal을 위함</param>
/// <param name="d">폴리건 생성 순으로 r 색상 -> object 파악 위함</param>
void
Polygon(int num, float d)
{
	GLfloat temp[3] = { d, 0.0, 0.0 };
	int vertex_number = num * 3;
	glColor3fv(temp);
	glNormal3fv(n[num].point);
	glVertex3fv(v[vertex_number].point);
	glColor3fv(temp);
	glVertex3fv(v[vertex_number + 1].point);
	glColor3fv(temp);
	glVertex3fv(v[vertex_number + 2].point);
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
	for (int i = 0; i < ncount; i++)
	{
		// 폴리곤 생성 및 색 부여
		Polygon(i, (i*0.05) + 0.05);
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
	glutCreateWindow("STL");
	glClearColor(1.0, 1.0, 1.0, 1.0);
	glOrtho(-4.0, 4.0, -4.0, 4.0, -4.0, 4.0);
	glEnable(GL_DEPTH_TEST);
	glutDisplayFunc(Display);
	glutMainLoop();

	delete[] v;
	delete[] n;

	return 0;
}