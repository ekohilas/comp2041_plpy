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
$parser->YYData->{"DEBUG"} = 0;

=pod
$parser->YYData->{"INDENT_NUM"} = 0;
$parser->YYData->{"INDENT_TYPE"} = ' ' x 4;
$parser->YYData->{"INDENT"} = $parser->YYData->{"INDENT_TYPE"} x $parser->YYData->{"INDENT_NUM"};
#print '{', $parser->YYData->{"INDENT"}, "}\n";
=cut

my $output = $parser->YYParse(YYlex => \&plpy::Lexer) || "NULL";

$output =~ s/^#!.*/#!\/usr\/local\/bin\/python3.5 -u/;
while ($output =~ /int\(\d+\)/){
    $output =~ s/int\((\d+)\)/$1/g;
}

print $output;
