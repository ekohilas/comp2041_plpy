#!/usr/bin/perl
use strict;
use warnings;

#Recompile parser if old
if ((-M "plpy.pm" || "inf") > -M "plpy.yp"){
    system("yapp plpy.yp");
}

require plpy;
plpy->import();

my $code = do {
    local $/ = undef;
    <STDIN>;
};

my $parser = new plpy;
$parser->YYData->{"DATA"} = $code;

my $output = $parser->YYParse(YYlex => \&plpy::Lexer);
print $output || "no output\n";
