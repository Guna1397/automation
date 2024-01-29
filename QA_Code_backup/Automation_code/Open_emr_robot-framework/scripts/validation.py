import os

def Compare_to_lower(strA, strB):
    if strA.lower() != strB.lower():
        return False
    else:
        return True

def set_to_lower(strA):
    return strA.lower()

def get_captialized(strA):
    return strA.capitalize()