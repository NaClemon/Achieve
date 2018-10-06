# target 값을 만족하는 인덱스를 찾는 클래스 정의
class FindPair:
    # init 함수 정의: number 리스트를 받는다
    def __init__(self, numb):
        self.numb = numb

    # target을 만족하는 두 쌍의 인덱스를 찾는 함수 정의
    def find(self, target):
        # 리스트 원소 개수만큼 반복
        for i in self.numb:
            # target 값을 임시로 저장
            target_num = target

            # target 값보다 큰 값은 두 쌍을 구할 수 없기 때문에 패스
            if (i >= target_num):
                continue

            # 첫번째 값의 인덱스를 저장
            a = self.numb.index(i)
            # 나머지 값을 찾기 위해 target값에서 첫번째 값을 뺀다
            target_num -= i

            # 그 값이 리스트에 존재하지 않을 수도 있기 때문에 예외 처리를 해준다
            try:
                # 찾은 두번째 값의 인덱스를 저장한다
                b = self.numb.index(target_num)
                # 인덱스가 같다는 것은 중복되었다는 뜻이므로 패스한다
                if (a == b):
                    continue
            # 리스트에 두번째 값이 존재하지 않으면 패스
            except:
                continue

            # 첫번째, 두번째 값의 인덱스를 출력
            print("Output: %d, %d" % (a, b))

# 공백 리스트 생성
numbers = list()

# 사용자에게 배열을 입력받는다
while True:
    num = int(input("배열 num 입력(0입력 시 종료): "))
    # 0을 입력받으면 반복문을 탈출해 입력 종료
    if num == 0:
        break
    # 입력받은 값을 리스트에 추가
    numbers.append(num)
# 입력받은 배열을 보여준다
print(numbers)
# target number의 값을 입력받는다
target = int(input("target 값 입력: "))

# FindPair 클래스를 선언
finding = FindPair(numbers)
# target을 만족하는 두 쌍의 인덱스 값을 찾는 함수 실행
finding.find(target)
