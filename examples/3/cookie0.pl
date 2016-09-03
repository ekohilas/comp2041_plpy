#!/usr/bin/perl -w

while (1) {
    print "Give me cookie\n";
    $line = <STDIN>;
    chomp $line;
    if ($line eq "cookie") {
        last;
    }
}
print "Thank you\n";
