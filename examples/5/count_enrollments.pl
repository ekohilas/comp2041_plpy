#!/usr/bin/perl -w
# written by andrewt@cse.unsw.edu.au as a 2041 lecture example
# count how many people enrolled in each course

open F, "<course_codes";
while ($line = <F>) {
    if ($line =~ /(\S+)\s+(.*\S)/) {
        $course_names{$1} = $2;
    }
}
close F;

while ($line = <>) {
    chomp $line;
    $course = $line;
    $course =~ s/\|.*//;
    $count{$course}++;
}

foreach $course (sort keys %count) {
    print "$course_names{$course} has $count{$course} students enrolled\n";
}
