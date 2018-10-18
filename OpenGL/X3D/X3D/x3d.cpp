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
	fopen_s(&obj, "ex.x3d", "r");
	bool quad_polygon = true;

	while (!feof(obj))
	{
		char temp[1000];
		char *token;
		char *content;
		fgets(temp, sizeof(temp), obj);

		token = strtok_s(temp, " <>:\t=\"", &content);

		// face의 정보를 가지고 있는 시작 부분을 찾는다
		if (strcmp(token, "IndexedFaceSet") == 0)
		{
			while (true)
			{
				int abc = 0;
				// 한 줄씩 읽는다
				fgets(temp, sizeof(temp), obj);
				token = strtok_s(temp, " ", &content);

				if (strcmp(token, "\">\n") == 0)
					break;

				// 첫번째 vertex 번호를 저장한다
				f[fcount].a = atoi(token);
				abc++;

				while (true)
				{
					// 이어서 같은 줄을 계속 읽어 나간다
					char * vertex = strtok_s(NULL, " ", &content);

					if (vertex == NULL)
						break;

					// 두번째 vertex 번호 저장
					else if (abc == 1)
					{
						f[fcount].b = atoi(vertex);
						abc++;
					}
					// 세번째 vertex 번호 저장 후 face 개수 증가
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
		// vertex의 정보를 갖고 있는 곳을 찾는다
		else if (strcmp(token, "Coordinate") == 0)
		{
			int xyz = 0;
			fgets(temp, sizeof(temp), obj);
			token = strtok_s(temp, " <>=\"/", &content);
			
			// 첫번째 토큰은 v1의 x좌표이다
			v[vcount].point[xyz] = atof(token);
			xyz++;

			while (true)
			{
				// 이어서 해당 줄을 읽는다
				char * vertex = strtok_s(NULL, " <>=\"/\n", &content);

				if (vertex == NULL)
					break;

				// 각 좌표를 저장한다
				v[vcount].point[xyz] = atof(vertex);
				xyz++;

				// z 좌표가 입력 되면 다음 vertex의 x좌표를 입력받는다
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
	glRotatef(30, 1.0f, 0.0f, 0.0f);
	glRotatef(30, 0.0f, 0.0f, 1.0f);

	for (int i = 0; i < fcount; i++)
	{
		// 폴리곤 생성 및 색 부여
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