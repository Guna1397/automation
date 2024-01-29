def swap_case(s):
    string = ""
    for i in s:
        if i.isupper() == True:
            string+= (i.lower())
        else:
            string+= (i.upper())
    print(string)
s = str(input())
swap_case(s)

def fact(n):
    for i in range(1,n+1):
        if n % i == 0:
            print(i)
n = 500
fact(n)
