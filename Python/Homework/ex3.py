class Brackets:
    change_result = list()
    count = 0
    def __init__(self, bra):
        self.bra = bra
    def switch(self, x):
        return {'(':1, '{':2, '[':3, ')':4, '}':5, ']':6}.get(x, 0)
    def changenum(self):
        for i in self.bra:
            Brackets.change_result.append(Brackets.switch(i))
    def check(self):
        for i in self.bra:
            if(i == '('):
                

        if(len(self.bra) % 2 != 0):
            return "Invalid"
        for i in range(len(self.bra) + 1):
            rev = (-1 * i) - 1
            if(self.bra[i] == '('):
                if(self.bra[rev] == ')' or self.bra[i + 1] == ')'):
                    continue
            elif (self.bra[i] == '('):
                if (self.bra[rev] == ')' or self.bra[i + 1] == ')'):
                    continue
            elif (self.bra[i] == '('):
                if (self.bra[rev] == ')' or self.bra[i + 1] == ')'):
                    continue



        for i in Brackets.change_result:
            if(i > 3):
                i -= 3
        temp1 = Brackets.change_result
        temp2 = Brackets.change_result.reverse()


        if(len(temp1) % 2 == 1):
            return "Invalid"
        if(temp1 == temp2):
            return  "Valid"
        else:
            for()
        Brackets.count += 1
        self.check()
        if(self.bra[Brackets.count] == '(' or self.bra[Brackets.count] == '{' or self.bra[Brackets.count] == '['):
            if(Brackets.count >= int(len(self.bra)/2)):
                return "Invalid"
            Brackets.count += 1
            self.Check()
        elif(self.bra[Brackets.count] == ')' or self.bra[Brackets.count] == '}' or self.bra[Brackets.count] == ']'):
            if(Brackets.count < int(len(self.bra)/2)):
                return "Invalid"
            Brackets.count += 1
            self.Check()

strcheck = Brackets(input("입력하세요."))
print(strcheck.Check())