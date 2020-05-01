def check_last_git(number: int):
    z6 = number % 10
    number = number//10
    z5 = number % 10
    number = number//10
    z4 = number % 10
    number = number//10
    z3 = number % 10
    number = number//10
    z2 = number % 10
    number = number//10
    z1 = number
    sum = z1+(2*z2)+(3*z3)+(4*z4)+(5*z5)+(6*z6)
    checkdigit = (sum%11)%10
    return checkdigit