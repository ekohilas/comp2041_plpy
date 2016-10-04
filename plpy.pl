#!/usr/bin/perl
use strict;
use warnings;
use Term::ANSIColor;

#Recompile parser if old
if ((-M "plpy.pm" || "inf") > -M "plpy.yp"){
    system("yapp plpy.yp");
}

require plpy;
plpy->import();

my $code = do {
    local $/ = undef;
    <>;
};

#$code =~ s/^#![^\n]*//;
my $parser = new plpy;
$parser->YYData->{"DATA"} = $code;

my $output = $parser->YYParse(YYlex => \&plpy::Lexer) || "NULL";

$output =~ s/^#!.*/#!\/usr\/local\/bin\/python3.5 -u/;
#clean up strings in print statements
#$output =~ s/(print\(".*)\\n"\)/$1")/g;
while ($output =~ /int\(\d+\)/){
    $output =~ s/int\((\d+)\)/$1/g;
}

print $output;
