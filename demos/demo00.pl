#!/usr/bin/perl -w
$var = "including %";
print "I can handle strings\n";
print 'Single quote', "and multiple\n", "newlines\n"; 
print ("aswell as arguments", 'or different format', "\n"); 
print "$var", "$var and no new lines";
