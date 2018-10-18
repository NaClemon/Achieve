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
	int d;
};

// normal 벡터를 저장할 구조체
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
		
		// Geometry에 object에 대한 정보가 있다.
		if (strcmp(token, "Geometry") == 0)
		{
			// quad를 사용하는 두번째 Geometry에서 정보를 받아오기 위함
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

					// 좌표에 대한 정보를 받음
					if (strcmp(token, "Vertices") == 0 && !quad_polygon)
					{
						char vertices[1000];
						fgets(vertices, sizeof(vertices), obj);

						// 좌표 이전의 값은 버린다
						char * point = strtok_s(vertices, ":,", &content);
						int xyz = 0;

						while (true)
						{
							// ','로 분리되어 있는 좌표를 읽기 위함
							char * temp = strtok_s(NULL, ":,", &content);
							// 마지막까지 읽고 탈출
							if (temp == NULL)
								break;
							// 각 값을 저장
							v[vcount].point[xyz] = atof(temp);
							xyz++;
							// 3차원 좌표이므로 3번째 값이 들어오면
							// vertex 개수 증가
							if (xyz == 3)
							{
								xyz = 0;
								vcount++;
							}
						}
					}
					// face에 대한 정보를 받는다
					else if (strcmp(token, "PolygonVertexIndex") == 0 && !quad_polygon)
					{
						char index[1000];
						fgets(index, sizeof(index), obj);

						// 좌표 이전의 값은 버린다
						char * point = strtok_s(index, ":,", &content);
						int abcd = 0;

						while (true)
						{
							// ','로 분리되어 있는 값들을 읽기 위함
							char * temp = strtok_s(NULL, ":,", &content);
							// 마지막 까지 읽고 탈출
							if (temp == NULL)
								break;
							int order = atoi(temp);
							// 4개의 vertex 정보를 받기 위함
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
								// 4번째 값은 음수이므로 양수로 치환
								// 2의 보수 이용
								// 4개 후 face 개수 증가
								f[fcount].d = -1 * order - 1;
								abcd = 0;
								fcount++;
								break;
							}
						}
					}
					// normal에 대한 정보를 받는다
					else if (strcmp(token, "Normals") == 0 && !quad_polygon)
					{
						char normal[1000];
						fgets(normal, sizeof(normal), obj);
						// 좌표 이전 값은 버린다
						char * point = strtok_s(normal, ":,", &content);
						int xyz = 0;

						// vertex와 같은 과정을 가진다
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
/// 폴리건 생성 함수
/// </summary>
/// <param name="a">a 번째 vertex 및 normal 벡터</param>
/// <param name="b">b 번째 vertex 및 normal 벡터</param>
/// <param name="c">c 번째 vertex 및 normal 벡터</param>
/// <param name="d">d 번째 vertex 및 normal 벡터</param>
/// <param name="e">폴리건 생성 순으로 r 색상 -> object 파악 위함</param>
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