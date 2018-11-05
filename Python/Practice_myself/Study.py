<<<<<<< HEAD
import random

a=[1,2,3]
a.append(4)
a.extend([4, 5, 6])
a.sort()
a.reverse()
a.insert(2,3)
b=a.index(2)

b=a
c=a[:]
dic = {'a':'b', 'c':2}
print(dic)
print(dic['a'])
print(dic.get('a'))

def a(a, *args):
    return True

a = 2
b = 6
print(a, b)
a, b = b, a
print(a, b)
(a, b) = ('python', 'life')
print(a, b)

height = int(input("삼각형의 높이를 입력: "))
for i in range(1, height+1):
    print((" "*(height - i)) + ("*" * (i * 2 - 1)))

print()
for x in range(1, height * 2, 2):
    print((" " * ( (height * 2 - 1 - x) // 2 )) + ("*" * x))

ans = random.randrange(1, 101, 1)
num = -1
count = 0

while (ans != num):
    num = int(input("숫자: "))
    if(ans > num):
        print("up")
    elif (ans < num):
        print("down")
    count += 1
print(count, "정답")
=======
class JustCounter:
    __secretCount = 0

    def count(self):
        self.__secretCount += 1
        print(self.__secretCount)



counter = JustCounter()
counter.count()
counter.count()
print(counter._JustCounter__secretCount)

>>>>>>> d9250d1baf19be59860aaea87b46f7793238fb74
