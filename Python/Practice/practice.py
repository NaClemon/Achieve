a=123
b="python"
c=[1,2,3]
print(a)
print(b)
print(c)
print('life' 'is' 'too short')
print('life' +'is'+'too short')
print("life","is","too short")
for i in reversed(c):
    print("%2d" %i, end='')
print("\n")
m1 = "life is too short\nYou need python"
m2 = """Life is too short
You need python"""
print(m1)
print(m2)

str="Python is Good"
print(str)
print(str.upper())
print(str.count('P'))
print(str.find('t'))
print(str.index('t'))
ch = ','
print(ch.join(str))
print(str.lstrip())
print(str.rstrip())
print(str.strip())

lista = [3, 2, 1, 4, 5]
tuplea = (3, 2, 1, 4, 5)
tupleb = (4)
lista.sort()
print(lista)

stuinfo = {'name': 'John', 'stu_ID': '10239', 'major':'software', 'birth':'1212', 'grade':'b'}
for i in stuinfo.items():
    print(i)
print(stuinfo.get('major'))
print('name' in stuinfo)

s1 = set([1, 2, 3, 4, 5, 6])
s2 = set([4, 5, 6, 7, 8, 9])
print(s1 & s2)
print(s1.intersection(s2))
print(s1 | s2)
print(s1.union(s2))
print(s1 - s2)
print(s1.difference(s2))
s1, s2 = s2, s1
print(s1)

def sum(a, b):
    c = a + b
    return c

m = sum(4, 7)
print('m = ', m)

def sum_many(*args):
    sum = 0
    for i in args:
        sum += i
    return sum

m = sum_many(1, 2, 3)
print('m = ', m)

num = []
for i in range(0, 10):
    m = int(input())
    num.append(m)

temp = set(num)
print(temp)
for i in temp:
    a = num.count(i)
    print("%d의 개수: %d" % (i, a))