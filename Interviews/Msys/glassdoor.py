#-------------------- Anagram --------------------

s1 = "dady"
s2 = "addy"

if sorted(s1) == sorted(s2):
    print("yes")
else:
    print("no")

#--------------- count of each day in the list ----------------
weekdays = ['sun','mon','tue','wed','thu','fri','sun','mon','mon']
print("Number of mondays in the given list is : " + str(weekdays.count('mon')))