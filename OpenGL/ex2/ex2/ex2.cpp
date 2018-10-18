#include <gl/glut.h>

int Width, Height;

void
Init()
{
	glClearColor(1.0, 1.0, 1.0, 1.0);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrtho(-2.0, 2.0, -2.0, 2.0, 0.5, 5.0);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
}

void
DrawScene()
{
	glColor3f(0.7, 0.7, 0.7);
	glPushMatrix();
}

void
MyDisplay()
{
	glClear(GL_COLOR_BUFFER_BIT);
	glColor3f(1.0, 1.0, 1.0);
	glViewport(0, 0, Width / 2, Height / 2);
	glPushMatrix();		// �� �Լ��� �Ҹ��� ���� ��ȯ ��ǥ�� ����
	gluLookAt(0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
	DrawScene();
	glPopMatrix();
	glViewport(Width / 2, 0, Width / 2, Height / 2);
}

int
