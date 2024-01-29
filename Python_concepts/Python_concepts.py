# ................  2nd highest  ................

print("_____Welcome to python basic concepts_____")

print("_____To print second highest number_____")

numbers = [1,5,8,8,9,5,2,7,1,8,9,9,2,10]
# mt = []
# for i in numbers:
#     if i not in mt:
#         mt.append(i)
# mt.remove(max(mt))
# print(max(mt))

a = set(numbers)
b = list(a)[-2]
print(f"The 2nd highest number from the given data is {b}")



print("_____Mapping function_____")

def additon(a,b):
    return a+b
num1 = (1,2,3)
num2 = (4,5,6)

b = map(additon,num1,num2)
print(list(b))


print("_____Iteration concept_____")

mystr = "banana"
myit = iter(mystr)
print(list(myit))

print("_____Lmabda function_____")

x = lambda a, b, c : a + b + c

print(f"Lambda function result is {x(5, 6, 2)}")

def myfunc(n):
  return lambda a : a * n

mydoubler = myfunc(2)
mytripler = myfunc(3)

print(mydoubler(11))
print(mytripler(11))


print("_____Reverse of a string_____")

def reverses(s):
    string = "".join(reversed(s))
    return string
s = "gunaseelan"
print(f"_____Reverse of the string is {reverses(s)}_____")

def my_function(x):
  return x[::-1]

txt = "I wonder how this text looks like backwards"
mytxt = my_function(txt)

print(f"Reverse of the string {txt} is {mytxt}")

#.....square of number

print("_____Square of number_____")

n = 1,2,3,4,6,7
for i in n:
    print(i*i)



print("_____Cube of number_____")

n = 1,2,3,4,6,7
for i in n:
    print(f"Cube of {n} is {i*i*i}")

print("_____sum of even number and product of odd number_____")

even_sum = 0
odd_product = 1
number = 1,2,3,4,5,6,7,8,9
for i in number:
    if i % 2 == 0:
        even_sum += i
    else:
        odd_product *= i
print(f"Sum of even digits: {even_sum}")
print(f"Product of odd digits: {odd_product}")

print("_____Find the prime number_____")

num = 15
if num > 1:
	for i in range(2, int(num/2)+1):
		if (num % i) == 0:
			print(num, "is not a prime number")
			break
	else:
		print(num, "is a prime number")
else:
	print(num, "is not a prime number")

print("_____Sum of the given numbers_____")

def sumnum(n):
    sum = 0
    for i in str(n):
        sum += int(i)
    print(sum)
n = 5667


print("_____Product of a given number_____")

def multiply(n):
    product = 1
    for i in n :
        product *= int(i)
    print(product)
n = "4354"
print(f"Product of {n} is  {multiply(n)}")

print("_____Find Square of a number_____")

def square_number(n):
    result = 0
    for _ in range(n):
        result += n
    return result
n = 5
print(f"Square of {n} is {square_number(n)}")


print("_____Find square and cube root_____")

n=9
for i in str(n):
    a = n**3
    b = n **2
    print(f"The cube root of {n} is {a}")
    print(f"The square root of {n} is {b}")

print("_____Find the given number is palindrome or not_____")

t = "909090"
print(t[::-1])
rev = t[::-1]
status = t == rev
print(status)
if status == True :
    print(t , " is a palindrome number")
else:
    print(t , " is not a palindrome number")

print("_____Find given number is armstrong number or not_____")

def armstrong(n):
    strn = str(n)
    l = len(strn)
    s = 0

    for i in strn :
        s += int(i)**l
    if s == n :
        print(n, "is an armstrong number")
    else:
        print(n, "is not an armstrong number")
n = 407
armstrong(n)

print("_____Find the factors of the number_____")

def factors(n):
    for i in range(1, n+1):
        if n % i == 0:
            print(f"The factor of {n} is {i}")
n = 850
factors(n)
   #-------------------swap cases ------------------------
def swap_case(s):
    string = ""
    for i in s:
        if i.isupper() == True:
            string+= (i.lower())
        else:
            string+= (i.upper())
    print(string)
s = "gunaSEELAN"
swap_case(s)

#-------------------- Anagram --------------------

s1 = "dog"
s2 = "gdo"

if sorted(s1) == sorted(s2):
    print("yes")
else:
    print("no")

#--------------- count of each day in the list ----------------
weekdays = ['sun','mon','tue','wed','thu','fri','sun','mon','mon']
print("Number of mondays in the given list is : " + str(weekdays.count('mon')))

name = "guna:seelan"
print(name.split(":"))

#------------------Input: s = "is2 sentence4 This1 a3"Output: "This is a sentence"--------------
new_string = ""
for i in string1:
    if not i.isdigit():
        new_string = new_string+i
print(new_string)

new_string = new_string.split(" ")
c= new_string[2] + " " + new_string[0] + " " + new_string[-1] + " " + new_string[1]
print(c)


#-------------------- AABBBCCDDAAAACCCEEF' >> 'A2B3C2D2A4C3E2F1' ---------------------------

def solve(s):
   res = ""
   cnt = 1
   for i in range(1, len(s)):
      if s[i - 1] == s[i]:
         cnt += 1
      else:
         res = res + s[i - 1]
         if cnt > 1:
            res += str(cnt)
         cnt = 1
   res = res + s[-1]
   if cnt > 1:
      res += str(cnt)
   return res

s = "AABBBCCDDAAAACCCEEF"
print(solve(s))











