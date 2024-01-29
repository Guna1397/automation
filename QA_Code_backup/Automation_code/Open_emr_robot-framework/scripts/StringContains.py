import os


class StringContains:
    def string_contains(self, arg1, arg2):
        if arg1.lower() in arg2.lower():
            return True
        else:
            return False
