class Brackets():
    count = 0
    def __init__(self, bra):
        self.bra = bra
    def Check(self):
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