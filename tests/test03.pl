#!/usr/bin/perl -w
# put your test script here
while ($line = <STDIN>){
   if ($line =~ /\/a\\\/(b)\\/i){
       print $1, "/\n";
   }
}
