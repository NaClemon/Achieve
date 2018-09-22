import timeit

print('우리', '학교', sep=' - ', end=' ')
print('Hello')

a = 123
print(a)
a = 'Python'
print(a)
a = [1, 2, 3]
print(a)
print('Life' 'is' 'too short')
print('Life' + 'is' + 'too short')
print('Life', 'is', 'too short')
for i in range(10):
    print('%2d' % i, end=' ')
"""x = input()
print(x)

x = int(input())
x = pow(x, 2)
print('x =', x)

x = float(input())
x = x * 2.0
print('x =', x)"""
#주석
"""주석테스트
print('a')"""

x = 2 ** 4
print(x)

if 2 > 1:
    print('a')
else:
    print('b')

for i in range(1, 10):
    print('%d' %i, end=' ')
    if i == 10 - 1:
        print('')

"""radius = float(input('반지름을 입력하세요: '))
area = 3.14 * radius ** 2
print('원의 면적 =', area)"""

'''x = int(input('정수 x = '))
y = int(input('정수 y = '))
print(x, '+', y, '=', x + y)
print(x, '-', y, '=', x - y)
print(x, '*', y, '=', x * y)
print(x, '/', y, '=', x / y)
print('%d + %d = %d' %(x, y, x + y))
print('%d - %d = %d' %(x, y, x - y))
print('%d * %d = %d' %(x, y, x * y))
print('%d / %d = %d' %(x, y, x / y))'''

'''x = int(input('정수 x = '))
start = timeit.default_timer() #실행시간 측정
if (x % 2 == 1):
    print('홀수')
else:
    print('짝수')
print((timeit.default_timer() - start))'''

score = int(input('점수 = '))
if (score >= 90):
    print('A학점')
elif (score >= 80):
    print('B학점')
elif (score >= 70):
    print('C학점')
elif (score >= 60):
    print('D학점')
else:
    print('F학점')
