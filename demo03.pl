#!/usr/bin/perl -w
#taken from examples
#shows use of functions, and regex

while ($line = <>) {
    chomp $line;
    $line =~ s/[aeiou]//g;
    print "$line\n";
}
