# 괄호문의 유효성을 검사하는 클래스 정의
class Brackets:
    # 초기화 메소드로 문자열을 받아온다
    def __init__(self, bra):
        self.bra = bra\
    # 문자열의 유효성을 검사하는 함수 정의
    def check(self):
        # 문자열을 한개씩 읽으며 검사
        for i in self.bra:
            try:
                # 배열의 다음 값 또는 뒤에서 부터의 값을 찾기 위해 인덱스+1을 저장
                temp = self.bra.index(i) + 1
                # 괄호가 '('일때
                if(i == '('):
                    # 다음 기호 또는 뒷부분에 닫는 기호가 있는지 검사
                    if(self.bra[temp] == ')' or self.bra[(-1 * temp)] == ')'):
                        # 있다면 계속
                        continue
                    # 없다면 유효하지 않음
                    return "Invalid"

                # '('의 과정과 동일
                elif(i == '{'):
                    if (self.bra[temp] == '}' or self.bra[(-1 * temp)] == '}'):
                        continue
                    return "Invalid"

                # '('의 과정과 동일
                elif(i == '['):
                    if (self.bra[temp] == ']' or self.bra[(-1 * temp)] == ']'):
                        continue
                    return "Invalid"

            # 예외 처리(배열의 원소가 하나일 때)
            except IndexError:
                # '(', '}' 등 한개이면 또는 마지막에 있으면 + 1 시 오류
                # 이 경우는 유효하지 않으므로 예외 처리로 Invalid 출력
                return "Invalid"

        # 이상 없이 for문을 다 돌면 Valid 출력
        return "Valid"

# 사용자로부터 문자열을 입력받는다
# 그 문자열을 매개변수로 괄호 검사 클래스 선언
strcheck = Brackets(input("입력하세요: "))

# 문자열의 유효성 검사후 결과 출력
print(strcheck.check())