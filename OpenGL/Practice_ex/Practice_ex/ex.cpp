#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <gl/glut.h>

#define GAP 16

GLuint window, world, screen, command;
GLfloat fDelta = 0.0f;
GLboolean bBlend = true;
GLboolean sSmooth = true;
GLfloat Red = 0.0;
GLfloat Green = 0.0;
GLfloat Blue = 0.0;
GLint Index = 0;

unsigned char PALETTE[16][3] = {
	{255, 255, 255},
	{0, 255, 255},
	{255, 0, 255},
	{0, 0, 255},
	{192, 192, 192},
	{128, 128, 128},
	{0, 128, 128},
	{128, 0, 128},
	{0, 0, 128},
	{255, 255, 0},
	{0, 255, 0},
	{128, 128, 0},
	{0, 128, 0},
	{255, 0, 0},
	{128, 0, 0},
	{0, 0, 0}
};


void
main_display()
{
	glClearColor(0.8, 0.8, 0.8, 0.0);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);		// 윈도우 비트 평면 영역을 glClearColor()로 설정된 값으로 변경
	glutSwapBuffers();
}

void
world_display()
{
	Red = PALETTE[Index][0] / 255.0f;
	Green = PALETTE[Index][1] / 255.0f;
	Blue = PALETTE[Index][2] / 255.0f;
	glColor3f(Red, Green, Blue);
	
	if (bBlend)
	{
		glEnable(GL_BLEND);
		glBindTexture(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	}
	if (sSmooth)
	{
		glEnable(GL_LINE_SMOOTH);
		glHint(GL_LINE_SMOOTH, GL_NICEST);
	}

	glBegin(GL_LINES);
	glVertex3f(-1.0 + fDelta, 1.0, 0.0);
	glVertex3f(1.0 - fDelta, -1.0, 0.0);
	glVertex3f(-1.0, -1.0 + fDelta, 0.0);
	glVertex3f(1.0, 1.0 - fDelta, 0.0);
	glEnd();

	if (bBlend)
		glDisable(GL_BLEND);
	if (sSmooth)
		glDisable(GL_LINE_SMOOTH);
	
	glutSwapBuffers();	// 프런트 버퍼와 백 버퍼가 바뀜, 이 함수가 실행되면 glFlush가 호출됨
}

void
screen_display()
{
	static unsigned char buffer[128 * 128 * 4 * 2];
	glutSetWindow(world);
	glReadPixels(0, 0, 128, 128, GL_RGBA, GL_UNSIGNED_BYTE, buffer);	// 해당 영역의 픽셀 값을 gl_unsigned_byte 형태로 읽어옴

	glutSetWindow(screen);
	glPixelZoom(4, 4);
	glDrawPixels(128, 128, GL_RGBA, GL_UNSIGNED_BYTE, buffer);	// 해당 영역에 픽셀 값을 gl_unsigned_byte 형태로 그려줌

	glPixelZoom(0, 0);
	glutSwapBuffers();
}

void
redisplay_all()
{
	glutSetWindow(command);
	glutPostRedisplay();
	glutSetWindow(world);
	glutPostRedisplay();
	glutSetWindow(screen);
	glutPostRedisplay();
}

void
main_keyboard(unsigned char key, int x, int y)
{
	switch (key)
	{
	case 'b':
		bBlend = !bBlend;
		break;
	case 's':
		sSmooth = !sSmooth;
		break;
	case 't':
		if (!bBlend)
			bBlend = sSmooth = true;
		else
			bBlend = sSmooth = false;
		break;
	case 27:
		exit(0);
	}

	glutSetWindow(command);
	glutPostRedisplay();
	
	glutSetWindow(world);
	glutPostRedisplay();

	glutSetWindow(screen);
	glutPostRedisplay();
}

void
world_timer(int Value)
{
	if (fDelta < 2.0f)
	{
		fDelta = fDelta + 0.1;
	}
	else
	{
		fDelta = 0.0;

		if (++Index >= 15)
			Index = 0;

		glClear(GL_COLOR_BUFFER_BIT); // 버퍼들을 미리 설정된 값으로 지움
	}

	redisplay_all();
	glutTimerFunc(100, world_timer, 1);
}

int
main(int argc, char ** argv)
{
	glutInitDisplayMode(GLUT_RGB | GLUT_DEPTH | GLUT_DOUBLE);
	glutInitWindowSize(128 + 512 + GAP * 3, 512 + GAP * 2);
	glutInitWindowPosition(0, 0);
	glutInit(&argc, argv);

	window = glutCreateWindow("Line Antialiasing Demo");
	glutDisplayFunc(main_display);
	glutKeyboardFunc(main_keyboard);
	
	world = glutCreateSubWindow(window, GAP, GAP, 128, 128);
	glutDisplayFunc(world_display);
	glutKeyboardFunc(main_keyboard);
	
	screen = glutCreateSubWindow(window, GAP + 128 + GAP, GAP, 512, 512);
	glutDisplayFunc(screen_display);
	glutKeyboardFunc(main_keyboard);

	redisplay_all();
	glutTimerFunc(100, world_timer, 1);
	glutMainLoop();

	return 0;
}