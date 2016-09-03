#!/usr/bin/perl -w
while (<>) {
    s/[aeiou]//gi;
    print;
}
