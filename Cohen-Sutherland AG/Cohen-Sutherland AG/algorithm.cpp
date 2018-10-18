#include <iostream>
#include <string>

using namespace std;

// Cube ���� ����
#define x_max 1
#define x_min -1
#define y_max 1
#define y_min -1
#define z_max 1
#define z_min -1

// Point�� ���� ���� ����
class Point
{
public:
	float x;
	float y;
	float z;
	float scalar;
	string binary;
	Point(float x, float y, float z);
	~Point();
	void MakeBinary();
	void Point_Scalar();
};

// ��ǥ ����
Point::Point(float x, float y, float z)
{
	this->x = x;
	this->y = y;
	this->z = z;
}

Point::~Point()
{
}

// Outcode ����
void Point::MakeBinary()
{
	binary = "000000";

	if (z > z_max)
		binary[0] = 1;
	else if (z < z_min)
		binary[1] = 1;

	if (y > y_max)
		binary[2] = 1;
	else if (y < y_min)
		binary[3] = 1;

	if (x < x_min)
		binary[4] = 1;
	else if (x > x_max)
		binary[5] = 1;
}

// ������ ��Į�� ���
void Point::Point_Scalar()
{
	scalar = (x * x) + (y * y) + (z * z);
}

// �� ���� ���� ���� ���
Point
Vector(Point bn_p1, Point bn_p2)
{
	float x, y, z;

	bn_p1.Point_Scalar();
	bn_p2.Point_Scalar();

	if (bn_p1.scalar >= bn_p2.scalar)
	{
		x = bn_p1.x - bn_p2.x;
		y = bn_p1.y - bn_p2.y;
		z = bn_p1.z - bn_p2.z;
	}
	else
	{
		x = bn_p2.x - bn_p1.x;
		y = bn_p2.y - bn_p1.y;
		z = bn_p2.z - bn_p1.z;
	}

	Point vector(x, y, z);

	return vector;
}

// 1���� ���� Cube �������� Ȯ��
bool
CheckPoint(string bn_p)
{
	if (bn_p == "000000")
		return true;
	else
		return false;
}

// ������ ���������� ���� ���� Cube�� ���ο� �ִ��� Ȯ��
bool
CheckInCube(float x, float y, float z)
{
	if ((x >= -1 && x <= 1)
		&& (y >= -1 && y <= 1)
		&& (z >= -1 && z <= 1))
		return true;
	else
		return false;
}

// Point�� ���� ��� ���
void
PrintResult(Point p)
{
	cout << p.x << " " << p.y << " " << p.z << " ";
}

// �� ���� ��� ���
void
PrintResult(float x, float y, float z)
{
	cout << x << " " << y << " " << z << " ";
}

// Cube���� ���� ���
void
Cube_Intersect(Point bn_p1, Point bn_p2, Point vector, int position[], int type)
{
	bool check_x = false;
	bool check_y = false;
	bool check_z = false;
	bool check_overlap = false;
	float temp_x, temp_y, temp_z;
	float fx, fy, fz;

	// Outcode�� Ȯ���Ͽ� 1�� �κ��� �ľ�
	// Cube�� ������ �̷� ���ɼ��� �ִ� �κ��� ã�Ƴ���
	for (int i = 0; i < 3; i++)
	{
		switch (position[i])
		{
		case 0:
			temp_z = 1;
			check_z = true;
			break;
		case 1:
			temp_z = -1;
			check_z = true;
			break;
		case 2:
			temp_y = 1;
			check_y = true;
			break;
		case 3:
			temp_y = -1;
			check_y = true;
			break;
		case 4:
			temp_x = -1;
			check_x = true;
			break;
		case 5:
			temp_x = 1;
			check_x = true;
			break;
		}
	}

	// �� �������� ���� ��ǥ�� ���� �� ���
	// ���ǿ� �¾� ���� ����ϸ� �� ���� ���� ����
	if (check_x && !check_overlap)
	{
		float coor_y, coor_z;

		// ������ �������� ���� ��ǥ ���
		fx = (temp_x - bn_p1.x) / vector.x;
		// ������ ���� 0�� ���(���)
		if (vector.x == 0)
			fx = vector.x;
		coor_y = vector.y *fx + bn_p1.y;
		coor_z = vector.z *fx + bn_p1.z;

		// ����� ���� ť�� ���� �ִ��� Ȯ��
		if (CheckInCube(temp_x, coor_y, coor_z))
		{
			// 0: ù��° ���� ����
			// 1: �ι�° ���� ����
			// �׿�: �Ѵ� �ܺ�
			switch (type)
			{
			case 0:
				PrintResult(bn_p1);
				break;
			case 1:
				PrintResult(bn_p2);
				break;
			default:
				break;
			}
			PrintResult(temp_x, coor_y, coor_z);
			check_overlap = true;
		}
	}
	// ���� ���� ����
	if (check_y && !check_overlap)
	{
		float coor_x, coor_z;
		fy = (temp_y - bn_p1.y) / vector.y;
		if (vector.y == 0)
			fy = vector.y;
		coor_x = vector.x *fy + bn_p1.x;
		coor_z = vector.z *fy + bn_p1.z;

		if (CheckInCube(coor_x, temp_y, coor_z))
		{
			switch (type)
			{
			case 0:
				PrintResult(bn_p1);
				break;
			case 1:
				PrintResult(bn_p2);
				break;
			default:
				break;
			}
			PrintResult(coor_x, temp_y, coor_z);
			check_overlap = true;
		}
	}
	// ���� ���� ����
	if (check_z && !check_overlap)
	{
		float coor_x, coor_y;
		fz = (temp_z - bn_p1.z) / vector.z;
		if (vector.z == 0)
			fz = vector.z;
		coor_x = vector.x *fz + bn_p1.x;
		coor_y = vector.y *fz + bn_p1.y;

		if (CheckInCube(coor_x, coor_y, temp_z))
		{
			switch (type)
			{
			case 0:
				PrintResult(bn_p1);
				break;
			case 1:
				PrintResult(bn_p2);
				break;
			default:
				break;
			}
			PrintResult(coor_x, coor_y, temp_z);
			check_overlap = true;
		}
	}

}

// 2���� ���� ���� Ȯ��
void
CheckLine(Point bn_p1, Point bn_p2, Point vector)
{
	float temp_x, temp_y, temp_z;

	float fx;
	float fy;
	float fz;

	// �� ���� ���ο� �ִٸ� �״�� ���
	if (bn_p1.binary == "000000" && bn_p2.binary == "000000")
	{
		PrintResult(bn_p1);
		PrintResult(bn_p2);
	}
	// �� �ϳ��� �ܺο� ���� ���
	else if (bn_p1.binary == "000000" && bn_p2.binary != "000000")
	{
		int position[3] = { -1, -1, -1 };
		int p_count = 0;

		// Outcode�� Ȯ���Ͽ� ���� ��� �ִ��� �ľ�
		for (int i = 0; i < 6; i++)
		{
			if (bn_p2.binary[i] != '0')
			{
				position[p_count] = i;
				p_count++;
			}
		}

		Cube_Intersect(bn_p1, bn_p2, vector, position, 0);
	}
	// ���������� �� �ϳ��� �ܺο� ���� ���(���� ���� ����)
	else if (bn_p1.binary != "000000" && bn_p2.binary == "000000")
	{
		int position[3] = { -1, -1, -1 };
		int p_count = 0;

		for (int i = 0; i < 6; i++)
		{
			if (bn_p1.binary[i] != '0')
			{
				position[p_count] = i;
				p_count++;
			}
		}

		Cube_Intersect(bn_p1, bn_p2, vector, position, 1);
	}
	// ���� �Ѵ� �ܺο� ���� ���
	else
	{
		int p1_count = 0;
		int p2_count = 0;
		int position[2][3] = { {-1,-1,-1}, {-1,-1,-1} };

		// ���� ������ ���� ��� Cube�� ������ �ʴ´�
		if (bn_p1.binary == bn_p2.binary)
		{
			cout << "�����ϴ�." << endl;
			return;
		}

		// Outcode�� ���� �� �Ѱ��� ��ġ��
		// ���� ����̹Ƿ� Cube�� ������ �ʴ´�
		for (int i = 0; i < 6; i++)
		{
			if (bn_p1.binary[i] == 1 && bn_p2.binary[i] == 1)
			{
				cout << "�����ϴ�." << endl;
				return;
			}
		}

		// ù��°, �ι�° ���� ��� �ִ��� Ȯ��
		for (int i = 0; i < 6; i++)
		{
			if (bn_p1.binary[i] != '0')
			{
				position[0][p1_count] = i;
				p1_count++;
			}
			if (bn_p2.binary[i] != '0')
			{
				position[1][p2_count] = i;
				p2_count++;
			}
		}

		// ù��°, �ι�° ���� Cube���� ����(���� ��) ���
		Cube_Intersect(bn_p1, bn_p2, vector, position[0], -1);
		Cube_Intersect(bn_p1, bn_p2, vector, position[1], -1);
	}
}

int
main()
{
	float temp[6];
	int count = 0;

	cout << "�����ϰ��� �ϴ� �� Ȥ�� ������ �Է��Ͻÿ�: ";

	// ���� �Է� �޴´�
	do
	{
		cin >> temp[count];
		count++;
	} while (getc(stdin) != '\n');

	// �Ѱ��� ���� �Էµ� ���
	if (count == 3)
	{
		Point p1(temp[0], temp[1], temp[2]);

		p1.MakeBinary();

		
		if (CheckPoint(p1.binary))
			cout << "���ο� ����" << endl;
		else
			cout << "�ܺο� ����" << endl;
	}
	// �ΰ��� ���� �Էµ� ���(����)
	else if (count == 6)
	{
		Point p1(temp[0], temp[1], temp[2]);
		Point p2(temp[3], temp[4], temp[5]);

		p1.MakeBinary();
		p2.MakeBinary();

		Point vector = Vector(p1, p2);

		CheckLine(p1, p2, vector);
	}
	else
	{
		cout << "�Է� ����" << endl;
	}

	return 0;
}