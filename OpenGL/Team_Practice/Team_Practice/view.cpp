#include <gl/glut.h>

GLfloat viewx = 0.0, viewz = 0.0;
GLfloat eyeX = 0.0, eyeY = 0.0;

GLfloat vertices[][3] = {
	{-1.0,-1.0,1.0},
	{1.0,-1.0,1.0},
	{1.0,1.0,1.0},
	{-1.0,1.0,1.0},
	{-1.0,-1.0,-1.0},
	{1.0,-1.0,-1.0},
	{1.0,1.0,-1.0},
	{-1.0,1.0,-1.0}
};

GLfloat colors[][3] = { {0.0,0.0,0.0},{1.0,0.0,0.0},
{1.0,1.0,0.0}, {0.0,1.0,0.0}, {0.0,0.0,1.0},
{1.0,0.0,1.0}, {1.0,1.0,1.0}, {0.0,1.0,1.0} };

void polygon(int a, int b, int c, int d)
{
	glBegin(GL_POLYGON);
	glColor3fv(colors[a]);
	glVertex3fv(vertices[a]);
	glColor3fv(colors[b]);
	glVertex3fv(vertices[b]);
	glColor3fv(colors[c]);
	glVertex3fv(vertices[c]);
	glColor3fv(colors[d]);
	glVertex3fv(vertices[d]);
	glEnd();
}

void colorcube(void)
{
	polygon(0, 3, 2, 1);
	polygon(1, 2, 6, 5);
	polygon(4, 7, 6, 5);
	polygon(4, 7, 3, 0);
	polygon(3, 7, 6, 2);
	polygon(0, 4, 5, 1);
}

void
Display()
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	gluLookAt(viewx, 0.0, viewz, eyeX, eyeY, -100.0, 1.0, 1.0, 0.0);
	glRotatef(45.0, 1.0, 0.0, 0.0);
	glRotatef(45.0, 0.0, 1.0, 0.0);
	glRotatef(45.0, 0.0, 0.0, 1.0);
	colorcube();
	glFlush();
	glutSwapBuffers();
}

void
Keyboard(unsigned char key, int x, int y)
{
	switch (key)
	{
	case 'w':
	case 'W':
		viewx += 0.1;
		break;
	case 's':
	case 'S':
		viewx -= 0.1;
		break;
	case 'd':
	case 'D':
		viewz += 0.1;
		break;
	case 'a':
	case 'A':
		viewz -= 0.1;
		break;
	default:
		break;
	}
	glutPostRedisplay();
}

void
Mouse(int  x, int y)
{
	eyeX = x;
	eyeY = y;
	glutPostRedisplay();
}

void
MouseState(int state)
{
	if (state == GL_LEFT)
	{
		state = GLUT_ENTERED;
	}
}

int
main(int argc, char ** argv)
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA | GLUT_DEPTH);
	glutInitWindowSize(1280, 720);
	glutInitWindowPosition(500, 300);
	glutCreateWindow("Team Project Practice");
	glClearColor(0.0, 0.0, 0.0, 1.0);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrtho(-4.0, 4.0, -4.0, 4.0, -4.0, 4.0);
	glutDisplayFunc(Display);
	glutKeyboardFunc(Keyboard);
	glutPassiveMotionFunc(Mouse);
	glutEntryFunc(MouseState);
	glutMainLoop();

	return 0;
}