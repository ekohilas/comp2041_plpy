#!/usr/bin/perl -w
#from examples 4
#shows effective translation of if/elif/else and print
print "Enter a number: ";
$a = <STDIN>;
if ($a < 0) {
    print "negative\n";
} elsif ($a == 0) {
    print "zero\n";
} elsif ($a < 10) {
    print "small\n";
} else {
    print "large\n";
}
