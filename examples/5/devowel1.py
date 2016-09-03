#!/usr/local/bin/python3.5 -u
import fileinput, re, sys
for _ in fileinput.input():
    _ = re.sub(r'[aeiou]', '', _, flags=re.I)
    sys.stdout.write(_)
