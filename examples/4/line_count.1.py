#!/usr/local/bin/python3.5 -u
import sys
# written by andrewt@cse.unsw.edu.au as a COMP2041 lecture example
# Count the number of lines on standard input.

line = ""
line_count = 0
for line in sys.stdin:
    line_count += 1
print("%s lines" % line_count)
