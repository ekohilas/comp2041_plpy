#!/usr/bin/perl -w
# written by andrewt@cse.unsw.edu.au as a COMP2041 lecture example
# Print lines read from stdin in reverse order.
# Using push & pop

while ($line = <STDIN>) {
    push @lines, $line;
}
while (@lines) {
    my $line = pop @lines;
    print $line;
}
