#!/usr/local/bin/python3.5 -u
import fileinput, re

for line in fileinput.input():
    line = line.rstrip()
    line = re.sub(r'[aeiou]', '', line)
    print(line)
