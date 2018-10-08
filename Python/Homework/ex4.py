class FindPair:
    def __init__(self, numb):
        self.numb = numb
    def find(self, target):
        for i in self.numb:
            target_num = target
            if (i >= target_num):
                continue
            a = self.numb.index(i)
            target_num -= i
            try:
                b = self.numb.index(target_num)
                if (a == b):
                    continue
            except:
                continue
            print("Output: %d, %d" % (a, b))

numbers = list()
while True:
    num = int(input("배열 num 입력(0입력 시 종료): "))
    if num == 0:
        break
    numbers.append(num)
print(numbers)
target = int(input("target 값 입력: "))
finding = FindPair(numbers)
finding.find(target)
