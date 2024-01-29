string1 = "is2 sentence4 This1 a3"


new_string = ""
for i in string1:
    if not i.isdigit():
        new_string = new_string+i
# print(new_string)
new_string = new_string.split(" ")
# print(new_string)
c= new_string[2] + " " + new_string[0] + " " + new_string[-1] + " " + new_string[1]
print(c)