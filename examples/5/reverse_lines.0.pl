#!/usr/bin/perl -w
# written by andrewt@cse.unsw.edu.au as a COMP2041 lecture example
# Print lines read from stdin in reverse order.
# In a C-style

while ($line = <STDIN>) {
    $line[$line_number++] = $line;
}


for ($line_number = $#line; $line_number >= 0 ; $line_number--) {
    print $line[$line_number];
}
