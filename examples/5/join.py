#!/usr/local/bin/python3.5 -u

def my_join(separator, list):
    if not list: return ""
    string = list.pop(0)
    for thing in list:
        string += separator + thing
    return string

a = ["Fish Fingers", "and", "Custard"];
b = my_join("   ",  a);
print(b)
