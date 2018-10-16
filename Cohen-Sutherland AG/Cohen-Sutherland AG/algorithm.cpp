#include <iostream>
#include <string>

using namespace std;

// Cube 범위 설정
#define x_max 1
#define x_min -1
#define y_max 1
#define y_min -1
#define z_max 1
#define z_min -1

// Point에 대한 정보 저장
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

// 좌표 저장
Point::Point(float x, float y, float z)
{
	this->x = x;
	this->y = y;
	this->z = z;
}

Point::~Point()
{
}

// Outcode 생성
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

// 벡터의 스칼라값 계산
void Point::Point_Scalar()
{
	scalar = (x * x) + (y * y) + (z * z);
}

// 두 점에 대한 벡터 계산
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

// 1개의 점이 Cube 내부인지 확인
bool
CheckPoint(string bn_p)
{
	if (bn_p == "000000")
		return true;
	else
		return false;
}

// 직선의 방정식으로 구한 점이 Cube의 내부에 있는지 확인
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

// Point에 대한 결과 출력
void
PrintResult(Point p)
{
	cout << p.x << " " << p.y << " " << p.z << " ";
}

// 각 점의 결과 출력
void
PrintResult(float x, float y, float z)
{
	cout << x << " " << y << " " << z << " ";
}

// Cube와의 교점 출력
void
Cube_Intersect(Point bn_p1, Point bn_p2, Point vector, int position[], int type)
{
	bool check_x = false;
	bool check_y = false;
	bool check_z = false;
	bool check_overlap = false;
	float temp_x, temp_y, temp_z;
	float fx, fy, fz;

	// Outcode를 확인하여 1인 부분을 파악
	// Cube와 교점을 이룰 가능성이 있는 부분을 찾아낸다
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

	// 각 교차점에 대해 좌표를 구한 후 출력
	// 조건에 맞아 값을 출력하면 그 외의 과정 생략
	if (check_x && !check_overlap)
	{
		float coor_y, coor_z;

		// 직선의 방정식을 토대로 좌표 계산
		fx = (temp_x - bn_p1.x) / vector.x;
		// 나누는 값이 0일 경우(평면)
		if (vector.x == 0)
			fx = vector.x;
		coor_y = vector.y *fx + bn_p1.y;
		coor_z = vector.z *fx + bn_p1.z;

		// 계산한 점이 큐브 내에 있는지 확인
		if (CheckInCube(temp_x, coor_y, coor_z))
		{
			// 0: 첫번째 점이 내부
			// 1: 두번째 점이 내부
			// 그외: 둘다 외부
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
	// 위와 같은 과정
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
	// 위와 같은 과정
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

// 2개의 점에 대한 확인
void
CheckLine(Point bn_p1, Point bn_p2, Point vector)
{
	float temp_x, temp_y, temp_z;

	float fx;
	float fy;
	float fz;

	// 두 점이 내부에 있다면 그대로 출력
	if (bn_p1.binary == "000000" && bn_p2.binary == "000000")
	{
		PrintResult(bn_p1);
		PrintResult(bn_p2);
	}
	// 점 하나가 외부에 있을 경우
	else if (bn_p1.binary == "000000" && bn_p2.binary != "000000")
	{
		int position[3] = { -1, -1, -1 };
		int p_count = 0;

		// Outcode를 확인하여 점이 어디에 있는지 파악
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
	// 마찬가지로 점 하나가 외부에 있을 경우(위와 같은 과정)
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
	// 점이 둘다 외부에 있을 경우
	else
	{
		int p1_count = 0;
		int p2_count = 0;
		int position[2][3] = { {-1,-1,-1}, {-1,-1,-1} };

		// 같은 구역에 있을 경우 Cube와 접하지 않는다
		if (bn_p1.binary == bn_p2.binary)
		{
			cout << "없습니다." << endl;
			return;
		}

		// Outcode의 원소 중 한개라도 겹치면
		// 같은 평면이므로 Cube와 접하지 않는다
		for (int i = 0; i < 6; i++)
		{
			if (bn_p1.binary[i] == 1 && bn_p2.binary[i] == 1)
			{
				cout << "없습니다." << endl;
				return;
			}
		}

		// 첫번째, 두번째 점이 어디에 있는지 확인
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

		// 첫번째, 두번째 점과 Cube와의 교점(내부 점) 출력
		Cube_Intersect(bn_p1, bn_p2, vector, position[0], -1);
		Cube_Intersect(bn_p1, bn_p2, vector, position[1], -1);
	}
}

int
main()
{
	float temp[6];
	int count = 0;

	cout << "시험하고자 하는 점 혹은 선분을 입력하시오: ";

	// 점을 입력 받는다
	do
	{
		cin >> temp[count];
		count++;
	} while (getc(stdin) != '\n');

	// 한개의 점이 입력된 경우
	if (count == 3)
	{
		Point p1(temp[0], temp[1], temp[2]);

		p1.MakeBinary();

		
		if (CheckPoint(p1.binary))
			cout << "내부에 있음" << endl;
		else
			cout << "외부에 있음" << endl;
	}
	// 두개의 점이 입력된 경우(선분)
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
		cout << "입력 오류" << endl;
	}

	return 0;
}