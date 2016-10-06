#!/usr/bin/perl
use strict;
use warnings;
use Term::ANSIColor;

#Recompile parser if old
if ((-M "plpy.pm" || "inf") > -M "plpy.yp"){system("yapp plpy.yp")}

require plpy;
plpy->import();

my $input = do {
    local $/ = undef;
    <>;
};

# PRE PARSE
# Change STDIN based on context
$input =~ s/@\w+\s*=\s*\K<STDIN>/<\@STDIN>/;

my $parser = new plpy;

$parser->YYData->{"DATA"} = $input;
$parser->YYData->{"DEBUG"} = 1;
$parser->YYData->{"IMPORTS"} = ();
$parser->YYData->{"PRELUDE"} = ();

my $output = $parser->YYParse(YYlex => \&plpy::Lexer) || "NULL\n";

# POST PARSE
#replace the hashbang
my $hashbang = "#!/usr/local/bin/python3.5 -u";
$output =~ s/^#!.*//;

#remove redundant int casts
while ($output =~ /int\(\d+\)/){
    $output =~ s/int\((\d+)\)/$1/g;
}

#print hashbang
print "$hashbang\n";

#print imports
if ($parser->YYData->{"IMPORTS"}){
    print "$_\n" for keys $parser->YYData->{"IMPORTS"};
}

#print prelude
if ($parser->YYData->{"PRELUDE"}){
    print "$_\n" for keys $parser->YYData->{"PRELUDE"};
}

print $output;
