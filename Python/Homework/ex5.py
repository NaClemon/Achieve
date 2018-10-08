# 제곱 계산 class 정의
class Pow:
    # init 함수 정의: 함수 역할을 출력하도록 함
    def __init__(self):
        print("implement pow")
    # 제곱 계산 함수 정의
    def power(self, x, n):
        # 결과 계산 및 정의를 위한 result 변수 초기화
        result = 1

        # exponent가 0일 경우 계산 미실시(결과값: 1)
        if(n == 0):
            return result

        # exponent가 양수일 경우
        elif(n > 0):
            # 반복을 통해 x를 n번 곱한다
            for i in range(n):
                result *= x
            # 계산 결과값 반환
            return result

        # exponent가 음수일 경우
        elif(n < 0):
            # 반복을 통해 1/x를 n번 곱한다. 이때, n은 음수이므로 absolute value를 취해준다.
            for i in range(abs(n)):
                result /= x
            # 계산 결과값 반환
            return result

# 클래스를 사용하기 위해 선언한다
calpow = Pow()

# base인 x와 exponent인 n을 입력받는다.
# 간단한 계산을 위해 n은 정수로 입력받는다.
x = float(input("x 입력: "))
n = int(input("n 입력: "))

# 제곱 계산 함수를 호출한다. 입력받은 값을 parameter로 전달해준다
result = calpow.power(x, n)

# 계산된 결과를 출력한다
print(result)