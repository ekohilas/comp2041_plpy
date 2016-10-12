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

# Change backrefernces for later searching
$input =~ s{(?<!\\)(?:\\\\)*\K\$([1-9&])}{
            $& =~ /\$(\d)/ ? "\$__$1__" : "\$__0__";
        }ge;

#$input =~ s/^@\s*\(w+)\s*;$/$1 = [];/mg;

my $parser = new plpy;

$parser->YYData->{"DATA"} = $input;
$parser->YYData->{"DEBUG"} = 1;
$parser->YYData->{"IMPORTS"} = ();
$parser->YYData->{"PRELUDE"} = ();

my $output = $parser->YYParse(YYlex => \&plpy::Lexer) || "NULL\n";

# POST PARSE
#replace the hashbang
my $hashbang = "#!/usr/local/bin/python3.5 -u";
$output =~ s/^#!.*\n//;

# replace temp back references with matches 
$output =~ s/(?<!\\)(?:\\\\)*\K__([0-9])__/__MATCH__.group($1)/g;

# taken from Donny's Asssignment
#remove redundant casting
while ($output =~ /eval\(str\((-?\d+(?:\.\d+)?)\)\)/){
    $output =~ s/eval\(str\((-?\d+(?:\.\d+)?)\)\)/$1/g;
}
#remove trailing spaces
$output =~ s/\s+$//gm; 

#replace 3 or more blank lines with 1
$output =~ s/\n{3,}/\n\n/g;

#shink trailing newlines to 1
$output =~ s/\n*$/\n/;

# OUTPUT
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
