#!/usr/bin/perl -w
# written by andrewt@cse.unsw.edu.au as a COMP2041 lecture example
# Print lines read from stdin in reverse order.
# More succintly with pop

@lines = <STDIN>;
while (@lines) {
    print pop @lines;
}
