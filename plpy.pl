#!/usr/bin/perl
use strict;
use warnings;

#Recompile parser if old
my $parser_file = "plpy";
if ((-M "$parser_file.pm" || "inf") > -M "$parser_file.yp"){
    system("yapp $parser_file.yp");
}

require plpy;
plpy->import();

my $code = do {
    local $/ = undef;
    <STDIN>;
}

my $parser = new plpy;
$parser->YYData->{"DATA"} = $code;

my $output = $parser->YYParse(YYlex => \&plpy::Lexer);
