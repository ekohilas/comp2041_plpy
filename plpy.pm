####################################################################
#
#    This file was generated using Parse::Yapp version 1.05.
#
#        Don't edit this file, use source file instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
####################################################################
package plpy;
use vars qw ( @ISA );
use strict;

@ISA= qw ( Parse::Yapp::Driver );
use Parse::Yapp::Driver;

#line 8 "plpy.yp"

use Term::ANSIColor;
use feature "switch";

sub Lexer {
    my ($type, $value) = getToken($_[0]);

    if ($_[0]->YYData->{"DEBUG"}){
        print STDERR color('red');
        print STDERR "Removed: (", color('reset'), "'$type': '$value'",
        color('red'), ")\n";
        print STDERR color('reset');
    }

    return ($type, $value);
}

sub getToken {
    my $uni = "chomp|exit|pop|shift|scalar|close|keys";
    my $lop = "printf|print|join|split|push|unshift|reverse|open|sort";
    my @tokens = (
        # matches a string with double or escaped quotes 
        #["STRING", qr/"(?:\\"|""|\\\\|[^"])*"/],
        ["STRING", qr/^"(?:[^"\\]|\\.|"")*"/],
        # matches until first ', avoiding \'
        ["STRING", qr/'.*?(?<!\\)'/],
        # matches matching functions split (/foo/, $bar)
        ["PMFUNC", qr/split(?=\s*\(\s*\/)/],
        ["RESUB", qr/s\/(?:(?<!\\)(?:\\\\)*.*\/){2}[msixpodualngcer]?/],
        ["REMATCH", qr/m?\/(?<!\\)(?:\\\\)*.*\/[imnsxadlup]?/],
        #matches all functions with brackets
        ["FUNC1", qr/(?:${uni})(?=\s*\()/],
        ["UNIOP", qr/(?:${uni})(?!\s*\()/],
        ["FUNC", qr/(?:${lop})(?=\s*\()/],
        ["LSTOP", qr/(?:${lop})(?!\s*\()/],
        ["FHANDLE", qr/<.*?>/],
        ["ARGV", qr/ARGV/],
        ["COMMENT", qr/\#.*/],
        ["FOR", qr/foreach|for/],
        ["WHILE", qr/while/],
        ["ELSIF", qr/elsif/],
        ["ELSE", qr/else/],
        ["LOOPEX", qr/(last|next)(?=\s*;)/],
        ["ANDOP", qr/and/],
        ["NOTOP", qr/not/],
        ["SUB", qr/sub/],
        ["IF", qr/if/],
        ["MY", qr/my/],
        ["OROP", qr/or/],
        ["DOTDOT", qr/\.\./],
        ["EQOP", qr/==|!=|eq|<=>/],
        ["ANDAND", qr/&&/],
        ["MATCHOP", qr/=~/],
        ["POWOP", qr/\*\*/],
        ["POSTINC", qr/\+\+/],
        ["POSTDEC", qr/--/],
        ["DOLSHARP", qr/\$#/],
        ["ASSIGNOP", qr/=|\.=/],
        ["ADDOP", qr/[\+\.-]/],
        ["BITANDOP", qr/&/],
        ["BITOROP", qr/\|/],
        ["BITXOROP", qr/\^/],
        ["SHIFTOP", qr/>>|<</],
        ["RELOP", qr/<=|>=|lt|gt|le|ge/],
        ["RELOP", qr/>|</],
        ["MULOP", qr/[\/%\*]/],
        ["OROR", qr/\|\|/],
        ["~", qr/~/],
        [",", qr/,/],
        ["!", qr/!/],
        [")", qr/\)/],
        ["(", qr/\(/],
        ["{", qr/\{/],
        ["}", qr/\}/],
        [";", qr/;/],
        ["[", qr/\[/],
        ["]", qr/\]/],
        ["@", qr/@/],
        ["%", qr/%/],
        ["\$", qr/\$/],
        ["WORD", qr/\w+/a], #look at later
    );

    $_[0]->YYData->{"DATA"} =~ s/^\s+//;
    #adds a final ; in blocks if one doens't exist for syntax reasons
    $_[0]->YYData->{"DATA"} =~ s/(?!})^.*?\K;?\s*}/;}/;

    if ($_[0]->YYData->{"DEBUG"}){
        print STDERR color('blue');
        print STDERR "___Remaining___\n", $_[0]->YYData->{"DATA"};
        print STDERR color('reset');
    }

    my @length;
    my $found = 0;
    for (my $i; $i < scalar @tokens; $i++){
        my $token = $tokens[$i][0];
        my $re = $tokens[$i][1];
        $length[$i] = 0;
        if ($_[0]->YYData->{"DATA"} =~ /^${re}/){
            $found = 1;
            @length[$i] = length($&);
            #print "Found match ($token): ($&), $length[$i]\n";
        }
        #print "$token, $re\n";
    }

    if (!$found && length ($_[0]->YYData->{"DATA"})) {
        print STDERR "Unable to find token\n";
        print STDERR $_[0]->YYData->{"DATA"}, "\n";
        return ('', undef);
    }

    if (length ($_[0]->YYData->{"DATA"})) {
        my ($maxpos, $maxval) = 0; 
        for (my $i = 0; $i < scalar @tokens; $i++){
            if ($length[$i] > $maxval){
                $maxpos = $i;
                $maxval = $length[$i];
            }
        }
        #print "$tokens[$maxpos][0]\n";
        my $token = $tokens[$maxpos][0];
        my $re = $tokens[$maxpos][1];
        $_[0]->YYData->{"DATA"} =~ s/^${re}//;
        #print "$token : $&\n";
        return ($token, $&);
    }
    else {
        return ('', undef);
    }
}

sub printer {
    my @tokens = @{shift(@_)};
    my @words = @_;
    my $parser = shift(@tokens);
    my $first_word = shift(@words);
    my $word_string = $first_word." => ";
    $word_string .= join(" -> ", @words);
    my $token_string = "$first_word"." => ";
    $token_string .= join(" -> ", @tokens);
    
    if ($parser->YYData->{"DEBUG"}){
        print STDERR color('green');
        print STDERR "$word_string\n";
        print STDERR "$token_string\n";
        print STDERR "\n";
        #print STDERR "('", $parser->YYCurtok, "': '", $parser->YYCurval, "')\n";
        #print STDERR "YYExpect:\n", join("\n", $parser->YYExpect), "\n";
        print STDERR color('reset');
    }
}

sub func_printf {
    my @list;
    my ($string, @args) = split(/"(?:\\"|""|\\\\|[^"])*"\K,\s*/, $_[2]);

    my $re = qr/(?<!\\)(?:\\\\)*\K\$\w+(?:\[(?<!\\)(?:\\\\)*\$\w+\])?/;

    $string =~ s/(\$\w+){(.*?);?}/$1\[$2\]/g;
    my @matches = $string =~ /${re}|%[csduoxefgXEGi]/g;
    foreach my $match (@matches){
        if ($match =~ /\$\w+/){
            $string =~ s/${re}/%s/;
            my $var = $&;
            $var =~ s/(?<!\\)(?:\\\\)*\$(\w+)/$1/g;
            $var =~ s/^ARGV/sys.argv/;
            push(@list, $var);
        }
        elsif ($match =~ /%[csduoxefgXEGi]/){
            push(@list, shift(@args));
        }
    }

    # remove final newline
    my $list = join(', ', @list);
    if ($string =~ s/^.*\K(?:,\s*"\\n"$)|(?:(?<!\\)\\n(?=\s*"$))//) { #"
        return "print($string % ($list))";
    }
    else {
        return "print($string % ($list), end='')";
    }
}

sub func_print {

    my $new_line = 0;
    if ($_[2] =~ s/^.*\K(?:,\s*"\\n"$)|(?:(?<!\\)\\n(?=\s*"$))//){
        $new_line = 1; #"
    }

    my @printf; 
    foreach my $string ( split(/"(?:\\"|""|\\\\|[^"])*"\K,\s*/, $_[2])){
        $string =~ s/(\$\w+){(.*?);?}/$1\[$2\]/g;
        my $re = qr/(?<!\\)(?:\\\\)*\K\$\w+(\[(?<!\\)(?:\\\\)*\$\w+\])?/;
        if ($string =~ /${re}/){
            my @list;
            my @matches = $string =~ /${re}/g;
            foreach my $match (@matches){
                $string =~ s/${re}/%s/;
                my $var = $&;
                $var =~ s/(?<!\\)(?:\\\\)*\$(\w+)/$1/g;
                $var =~ s/^ARGV/sys.argv/;
                push(@list, $var);
            }
            push(@printf, "$string % (".join(', ', @list).")" );
        }
        else {
            push(@printf, $string);
        }
    }

    my $final = join(', ', @printf);
    # remove final newline
    if ($new_line) {
        return "print($final)";
    }
    else {
        return "print($final, end='')";
    }
}

sub func_join {
    my @list = split(', ', $_[2]);
    my $delim = shift @list;
    return "'$delim'.join(@list)";
}

sub func_push {
    my @list = split(', ', $_[2]);
    my $array = shift @list;
    return "$array.append(@list)";
}

sub func_unshift {
    my @list = split(', ', $_[2]);
    my $array = shift @list;
    return "$array.insert(0, @list)";
}

sub func_open {
    my @list = split(', ', $_[2]);
    my $handle = shift @list;
    my $file = shift @list;
    $file =~ s/^"(<|>>|>)/"/; #"

    my $mode;
    given ($1) {
        when ('<')  { $mode = "'r'" }
        when ('>>') { $mode = "'a'" }
        when ('>')  { $mode = "'w'" }
    }
    return "$handle = open($file, $mode)";
}

sub compile_flags {
    my @flags;
    if ($_[0] =~ /i/)   {push (@flags, "re.I")}
    if ($_[0] =~ /m/)   {push (@flags, "re.M")}
    if ($_[0] =~ /s/)   {push (@flags, "re.S")}
    return join('| ', @flags);
}


sub new {
        my($class)=shift;
        ref($class)
    and $class=ref($class);

    my($self)=$class->SUPER::new( yyversion => '1.05',
                                  yystates =>
[
	{#State 0
		DEFAULT => -2,
		GOTOS => {
			'prog' => 1,
			'lineseq' => 2
		}
	},
	{#State 1
		ACTIONS => {
			'' => 3
		}
	},
	{#State 2
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"~" => 9,
			'COMMENT' => 12,
			'MY' => 11,
			"%" => 10,
			'LSTOP' => 13,
			"!" => 16,
			'FHANDLE' => 17,
			'IF' => 19,
			"\$" => 18,
			'RESUB' => 21,
			'NOTOP' => 26,
			'PMFUNC' => 25,
			'SUB' => 29,
			'ARGV' => 28,
			"(" => 33,
			'FUNC1' => 34,
			'FOR' => 38,
			"+" => 39,
			'NOAMP' => 40,
			'DOLSHARP' => 41,
			'FUNC' => 42,
			'STRING' => 44,
			'LOOPEX' => 46,
			'WHILE' => 47,
			"&" => 49,
			'UNIOP' => 50
		},
		DEFAULT => -1,
		GOTOS => {
			'scalar' => 6,
			'subrout' => 35,
			'sideff' => 37,
			'function' => 36,
			'term' => 43,
			'loop' => 15,
			'ary' => 14,
			'expr' => 45,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23,
			'line' => 24,
			'cond' => 27,
			'arylen' => 48,
			'amper' => 30,
			'myattrterm' => 31,
			'subscripted' => 32,
			'argexpr' => 51
		}
	},
	{#State 3
		DEFAULT => 0
	},
	{#State 4
		DEFAULT => -82
	},
	{#State 5
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 52,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 6
		ACTIONS => {
			"[" => 53,
			"{" => 54
		},
		DEFAULT => -70
	},
	{#State 7
		ACTIONS => {
			'WORD' => 56,
			'ARGV' => 58,
			"\$" => 18,
			"{" => 59
		},
		GOTOS => {
			'scalar' => 55,
			'indirob' => 57,
			'block' => 60
		}
	},
	{#State 8
		DEFAULT => -63
	},
	{#State 9
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 61,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 10
		ACTIONS => {
			'WORD' => 56,
			'ARGV' => 58,
			"\$" => 18,
			"{" => 59
		},
		GOTOS => {
			'scalar' => 55,
			'indirob' => 62,
			'block' => 60
		}
	},
	{#State 11
		ACTIONS => {
			"(" => 66,
			"\@" => 7,
			"\$" => 18,
			"%" => 10
		},
		GOTOS => {
			'scalar' => 63,
			'myterm' => 67,
			'hsh' => 65,
			'ary' => 64
		}
	},
	{#State 12
		DEFAULT => -8
	},
	{#State 13
		ACTIONS => {
			"-" => 5,
			'WORD' => 68,
			'REMATCH' => 8,
			"\@" => 7,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'LSTOP' => 13,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 71,
			"(" => 33,
			'FUNC1' => 34,
			"+" => 39,
			'NOAMP' => 40,
			'DOLSHARP' => 41,
			'FUNC' => 42,
			'STRING' => 44,
			'LOOPEX' => 46,
			"&" => 49,
			'UNIOP' => 50,
			"{" => 59
		},
		DEFAULT => -101,
		GOTOS => {
			'scalar' => 69,
			'arylen' => 48,
			'indirob' => 70,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'termbinop' => 20,
			'block' => 60,
			'argexpr' => 73,
			'listexpr' => 72,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 14
		ACTIONS => {
			"[" => 74
		},
		DEFAULT => -72
	},
	{#State 15
		DEFAULT => -6
	},
	{#State 16
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 75,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 17
		DEFAULT => -62
	},
	{#State 18
		ACTIONS => {
			'WORD' => 56,
			'ARGV' => 58,
			"\$" => 18,
			"{" => 59
		},
		GOTOS => {
			'scalar' => 55,
			'indirob' => 76,
			'block' => 60
		}
	},
	{#State 19
		ACTIONS => {
			"(" => 77
		}
	},
	{#State 20
		DEFAULT => -60
	},
	{#State 21
		DEFAULT => -64
	},
	{#State 22
		DEFAULT => -71
	},
	{#State 23
		DEFAULT => -61
	},
	{#State 24
		DEFAULT => -4
	},
	{#State 25
		ACTIONS => {
			"(" => 78
		}
	},
	{#State 26
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'termbinop' => 20,
			'argexpr' => 79,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 27
		DEFAULT => -5
	},
	{#State 28
		DEFAULT => -65
	},
	{#State 29
		ACTIONS => {
			'WORD' => 80
		},
		GOTOS => {
			'subname' => 81
		}
	},
	{#State 30
		ACTIONS => {
			"(" => 82
		},
		DEFAULT => -76
	},
	{#State 31
		DEFAULT => -67
	},
	{#State 32
		ACTIONS => {
			"[" => 83,
			"{" => 84
		},
		DEFAULT => -74
	},
	{#State 33
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			")" => 86,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 85,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 34
		ACTIONS => {
			"(" => 87
		}
	},
	{#State 35
		DEFAULT => -3
	},
	{#State 36
		DEFAULT => -83
	},
	{#State 37
		ACTIONS => {
			";" => 88
		}
	},
	{#State 38
		ACTIONS => {
			"(" => 91,
			"\$" => 18,
			'MY' => 90
		},
		GOTOS => {
			'scalar' => 89
		}
	},
	{#State 39
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 92,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 40
		ACTIONS => {
			'WORD' => 93
		}
	},
	{#State 41
		ACTIONS => {
			'WORD' => 56,
			'ARGV' => 58,
			"\$" => 18,
			"{" => 59
		},
		GOTOS => {
			'scalar' => 55,
			'indirob' => 94,
			'block' => 60
		}
	},
	{#State 42
		ACTIONS => {
			"(" => 95
		}
	},
	{#State 43
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			'ASSIGNOP' => 97,
			'POSTINC' => 105,
			'BITOROP' => 106,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'DOTDOT' => 108,
			'MULOP' => 109,
			'BITXOROP' => 110,
			'SHIFTOP' => 100,
			'OROR' => 111,
			'ANDAND' => 101,
			'EQOP' => 102,
			'RELOP' => 103
		},
		DEFAULT => -35
	},
	{#State 44
		DEFAULT => -66
	},
	{#State 45
		ACTIONS => {
			'FOR' => 114,
			'OROP' => 113,
			'ANDOP' => 112,
			'WHILE' => 115
		},
		DEFAULT => -10
	},
	{#State 46
		DEFAULT => -80
	},
	{#State 47
		ACTIONS => {
			"(" => 116
		}
	},
	{#State 48
		DEFAULT => -73
	},
	{#State 49
		ACTIONS => {
			'WORD' => 56,
			'ARGV' => 58,
			"\$" => 18,
			"{" => 59
		},
		GOTOS => {
			'scalar' => 55,
			'indirob' => 117,
			'block' => 60
		}
	},
	{#State 50
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'LSTOP' => 13,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			"(" => 33,
			'FUNC1' => 34,
			"+" => 39,
			'NOAMP' => 40,
			'DOLSHARP' => 41,
			'FUNC' => 42,
			'STRING' => 44,
			'LOOPEX' => 46,
			"&" => 49,
			'UNIOP' => 50,
			"{" => 59
		},
		DEFAULT => -84,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 118,
			'ary' => 14,
			'termbinop' => 20,
			'block' => 119,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 51
		ACTIONS => {
			"," => 120
		},
		DEFAULT => -32
	},
	{#State 52
		ACTIONS => {
			'POSTINC' => 105,
			'POWOP' => 98,
			'POSTDEC' => 107
		},
		DEFAULT => -54
	},
	{#State 53
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 121,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 54
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 122,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 55
		DEFAULT => -113
	},
	{#State 56
		DEFAULT => -111
	},
	{#State 57
		DEFAULT => -108
	},
	{#State 58
		DEFAULT => -112
	},
	{#State 59
		DEFAULT => -2,
		GOTOS => {
			'lineseq' => 123
		}
	},
	{#State 60
		DEFAULT => -114
	},
	{#State 61
		ACTIONS => {
			'POSTINC' => 105,
			'POWOP' => 98,
			'POSTDEC' => 107
		},
		DEFAULT => -57
	},
	{#State 62
		DEFAULT => -109
	},
	{#State 63
		DEFAULT => -98
	},
	{#State 64
		DEFAULT => -100
	},
	{#State 65
		DEFAULT => -99
	},
	{#State 66
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			")" => 125,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 124,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 67
		DEFAULT => -95
	},
	{#State 68
		ACTIONS => {
			'BITANDOP' => -82,
			'ANDOP' => -82,
			'ASSIGNOP' => -82,
			"]" => -82,
			'POWOP' => -82,
			'MATCHOP' => -82,
			'OROP' => -82,
			'SHIFTOP' => -82,
			'ANDAND' => -82,
			'RELOP' => -82,
			'EQOP' => -82,
			";" => -82,
			'FOR' => -82,
			'ADDOP' => -82,
			"," => -82,
			'POSTINC' => -82,
			'BITOROP' => -82,
			")" => -82,
			'WHILE' => -82,
			'POSTDEC' => -82,
			'DOTDOT' => -82,
			'MULOP' => -82,
			'BITXOROP' => -82,
			'OROR' => -82
		},
		DEFAULT => -111
	},
	{#State 69
		ACTIONS => {
			'BITANDOP' => -70,
			'ANDOP' => -70,
			'ASSIGNOP' => -70,
			"[" => 53,
			"]" => -70,
			'POWOP' => -70,
			'MATCHOP' => -70,
			'OROP' => -70,
			'SHIFTOP' => -70,
			'ANDAND' => -70,
			'RELOP' => -70,
			'EQOP' => -70,
			";" => -70,
			'FOR' => -70,
			'ADDOP' => -70,
			"," => -70,
			'POSTINC' => -70,
			'BITOROP' => -70,
			")" => -70,
			'WHILE' => -70,
			'POSTDEC' => -70,
			"{" => 54,
			'DOTDOT' => -70,
			'MULOP' => -70,
			'BITXOROP' => -70,
			'OROR' => -70
		},
		DEFAULT => -113
	},
	{#State 70
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'termbinop' => 20,
			'argexpr' => 126,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 71
		ACTIONS => {
			'BITANDOP' => -65,
			'ANDOP' => -65,
			'ASSIGNOP' => -65,
			"]" => -65,
			'POWOP' => -65,
			'MATCHOP' => -65,
			'OROP' => -65,
			'SHIFTOP' => -65,
			'ANDAND' => -65,
			'RELOP' => -65,
			'EQOP' => -65,
			";" => -65,
			'FOR' => -65,
			'ADDOP' => -65,
			"," => -65,
			'POSTINC' => -65,
			'BITOROP' => -65,
			")" => -65,
			'WHILE' => -65,
			'POSTDEC' => -65,
			'DOTDOT' => -65,
			'MULOP' => -65,
			'BITXOROP' => -65,
			'OROR' => -65
		},
		DEFAULT => -112
	},
	{#State 72
		DEFAULT => -93
	},
	{#State 73
		ACTIONS => {
			"," => 120
		},
		DEFAULT => -102
	},
	{#State 74
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 127,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 75
		ACTIONS => {
			'POSTINC' => 105,
			'POWOP' => 98,
			'POSTDEC' => 107
		},
		DEFAULT => -56
	},
	{#State 76
		DEFAULT => -107
	},
	{#State 77
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 128,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 78
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 129,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 79
		ACTIONS => {
			"," => 120
		},
		DEFAULT => -81
	},
	{#State 80
		DEFAULT => -27
	},
	{#State 81
		ACTIONS => {
			";" => 131,
			"{" => 59
		},
		GOTOS => {
			'block' => 132,
			'subbody' => 130
		}
	},
	{#State 82
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			")" => 134,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 133,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 83
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 135,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 84
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 136,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 85
		ACTIONS => {
			'OROP' => 113,
			")" => 137,
			'ANDOP' => 112
		}
	},
	{#State 86
		DEFAULT => -69
	},
	{#State 87
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			")" => 139,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 138,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 88
		DEFAULT => -7
	},
	{#State 89
		ACTIONS => {
			"(" => 140
		}
	},
	{#State 90
		ACTIONS => {
			"\$" => 18
		},
		GOTOS => {
			'scalar' => 141
		}
	},
	{#State 91
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		DEFAULT => -22,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'sideff' => 142,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 143,
			'nexpr' => 144,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 92
		ACTIONS => {
			'POSTINC' => 105,
			'POWOP' => 98,
			'POSTDEC' => 107
		},
		DEFAULT => -55
	},
	{#State 93
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'LSTOP' => 13,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			"(" => 33,
			'FUNC1' => 34,
			"+" => 39,
			'NOAMP' => 40,
			'DOLSHARP' => 41,
			'FUNC' => 42,
			'STRING' => 44,
			'LOOPEX' => 46,
			"&" => 49,
			'UNIOP' => 50
		},
		DEFAULT => -101,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'termbinop' => 20,
			'argexpr' => 73,
			'listexpr' => 145,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 94
		DEFAULT => -110
	},
	{#State 95
		ACTIONS => {
			"-" => 5,
			'WORD' => 68,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 71,
			"{" => 59,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		DEFAULT => -103,
		GOTOS => {
			'scalar' => 69,
			'indirob' => 146,
			'function' => 36,
			'term' => 43,
			'ary' => 14,
			'expr' => 148,
			'termbinop' => 20,
			'listexprcom' => 147,
			'hsh' => 22,
			'termunop' => 23,
			'arylen' => 48,
			'amper' => 30,
			'myattrterm' => 31,
			'subscripted' => 32,
			'block' => 60,
			'argexpr' => 51
		}
	},
	{#State 96
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 149,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 97
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 150,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 98
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 151,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 99
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 152,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 100
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 153,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 101
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 154,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 102
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 155,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 103
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 156,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 104
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 157,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 105
		DEFAULT => -58
	},
	{#State 106
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 158,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 107
		DEFAULT => -59
	},
	{#State 108
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 159,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 109
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 160,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 110
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 161,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 111
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 162,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 112
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 163,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 113
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 164,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 114
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 165,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 115
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 166,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 116
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		DEFAULT => -24,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 168,
			'texpr' => 167,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 117
		DEFAULT => -106
	},
	{#State 118
		ACTIONS => {
			'ADDOP' => 104,
			'POSTINC' => 105,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109,
			'SHIFTOP' => 100
		},
		DEFAULT => -86
	},
	{#State 119
		DEFAULT => -85
	},
	{#State 120
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'LSTOP' => 13,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			"(" => 33,
			'FUNC1' => 34,
			"+" => 39,
			'NOAMP' => 40,
			'DOLSHARP' => 41,
			'FUNC' => 42,
			'STRING' => 44,
			'LOOPEX' => 46,
			"&" => 49,
			'UNIOP' => 50
		},
		DEFAULT => -33,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 169,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 121
		ACTIONS => {
			'OROP' => 113,
			"]" => 170,
			'ANDOP' => 112
		}
	},
	{#State 122
		ACTIONS => {
			";" => 171,
			'OROP' => 113,
			'ANDOP' => 112
		}
	},
	{#State 123
		ACTIONS => {
			"}" => 172,
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			'FOR' => 38,
			"+" => 39,
			"~" => 9,
			'COMMENT' => 12,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			'IF' => 19,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'WHILE' => 47,
			'NOTOP' => 26,
			'PMFUNC' => 25,
			'SUB' => 29,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 35,
			'sideff' => 37,
			'function' => 36,
			'term' => 43,
			'loop' => 15,
			'ary' => 14,
			'expr' => 45,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23,
			'line' => 24,
			'cond' => 27,
			'arylen' => 48,
			'amper' => 30,
			'myattrterm' => 31,
			'subscripted' => 32,
			'argexpr' => 51
		}
	},
	{#State 124
		ACTIONS => {
			'OROP' => 113,
			")" => 173,
			'ANDOP' => 112
		}
	},
	{#State 125
		DEFAULT => -97
	},
	{#State 126
		ACTIONS => {
			"," => 120
		},
		DEFAULT => -91
	},
	{#State 127
		ACTIONS => {
			'OROP' => 113,
			"]" => 174,
			'ANDOP' => 112
		}
	},
	{#State 128
		ACTIONS => {
			'OROP' => 113,
			")" => 175,
			'ANDOP' => 112
		}
	},
	{#State 129
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			"," => 176,
			'ASSIGNOP' => 97,
			'POSTINC' => 105,
			")" => 177,
			'BITOROP' => 106,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'DOTDOT' => 108,
			'MULOP' => 109,
			'BITXOROP' => 110,
			'SHIFTOP' => 100,
			'OROR' => 111,
			'ANDAND' => 101,
			'RELOP' => 103,
			'EQOP' => 102
		}
	},
	{#State 130
		DEFAULT => -26
	},
	{#State 131
		DEFAULT => -29
	},
	{#State 132
		DEFAULT => -28
	},
	{#State 133
		ACTIONS => {
			'OROP' => 113,
			")" => 178,
			'ANDOP' => 112
		}
	},
	{#State 134
		DEFAULT => -77
	},
	{#State 135
		ACTIONS => {
			'OROP' => 113,
			"]" => 179,
			'ANDOP' => 112
		}
	},
	{#State 136
		ACTIONS => {
			";" => 180,
			'OROP' => 113,
			'ANDOP' => 112
		}
	},
	{#State 137
		DEFAULT => -68
	},
	{#State 138
		ACTIONS => {
			'OROP' => 113,
			")" => 181,
			'ANDOP' => 112
		}
	},
	{#State 139
		DEFAULT => -87
	},
	{#State 140
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 182,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 141
		ACTIONS => {
			"(" => 183
		}
	},
	{#State 142
		DEFAULT => -23
	},
	{#State 143
		ACTIONS => {
			'FOR' => 114,
			'OROP' => 113,
			")" => 184,
			'ANDOP' => 112,
			'WHILE' => 115
		},
		DEFAULT => -10
	},
	{#State 144
		ACTIONS => {
			";" => 185
		}
	},
	{#State 145
		DEFAULT => -79
	},
	{#State 146
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 186,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 147
		ACTIONS => {
			")" => 187
		}
	},
	{#State 148
		ACTIONS => {
			'OROP' => 113,
			"," => 188,
			'ANDOP' => 112
		},
		DEFAULT => -104
	},
	{#State 149
		ACTIONS => {
			'ADDOP' => 104,
			'POSTINC' => 105,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109,
			'SHIFTOP' => 100,
			'EQOP' => 102,
			'RELOP' => 103
		},
		DEFAULT => -47
	},
	{#State 150
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			'ASSIGNOP' => 97,
			'POSTINC' => 105,
			'BITOROP' => 106,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'DOTDOT' => 108,
			'MULOP' => 109,
			'BITXOROP' => 110,
			'SHIFTOP' => 100,
			'OROR' => 111,
			'ANDAND' => 101,
			'EQOP' => 102,
			'RELOP' => 103
		},
		DEFAULT => -40
	},
	{#State 151
		ACTIONS => {
			'POSTINC' => 105,
			'POWOP' => 98,
			'POSTDEC' => 107
		},
		DEFAULT => -41
	},
	{#State 152
		ACTIONS => {
			'POSTINC' => 105,
			'POWOP' => 98,
			'POSTDEC' => 107
		},
		DEFAULT => -53
	},
	{#State 153
		ACTIONS => {
			'ADDOP' => 104,
			'POSTINC' => 105,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109
		},
		DEFAULT => -44
	},
	{#State 154
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			'POSTINC' => 105,
			'BITOROP' => 106,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109,
			'BITXOROP' => 110,
			'SHIFTOP' => 100,
			'EQOP' => 102,
			'RELOP' => 103
		},
		DEFAULT => -51
	},
	{#State 155
		ACTIONS => {
			'ADDOP' => 104,
			'POSTINC' => 105,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109,
			'SHIFTOP' => 100,
			'EQOP' => undef,
			'RELOP' => 103
		},
		DEFAULT => -46
	},
	{#State 156
		ACTIONS => {
			'ADDOP' => 104,
			'POSTINC' => 105,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109,
			'SHIFTOP' => 100,
			'RELOP' => undef
		},
		DEFAULT => -45
	},
	{#State 157
		ACTIONS => {
			'POSTINC' => 105,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109
		},
		DEFAULT => -43
	},
	{#State 158
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			'POSTINC' => 105,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109,
			'SHIFTOP' => 100,
			'EQOP' => 102,
			'RELOP' => 103
		},
		DEFAULT => -48
	},
	{#State 159
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			'POSTINC' => 105,
			'BITOROP' => 106,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'DOTDOT' => undef,
			'MULOP' => 109,
			'BITXOROP' => 110,
			'SHIFTOP' => 100,
			'OROR' => 111,
			'ANDAND' => 101,
			'EQOP' => 102,
			'RELOP' => 103
		},
		DEFAULT => -50
	},
	{#State 160
		ACTIONS => {
			'POSTINC' => 105,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107
		},
		DEFAULT => -42
	},
	{#State 161
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			'POSTINC' => 105,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109,
			'SHIFTOP' => 100,
			'EQOP' => 102,
			'RELOP' => 103
		},
		DEFAULT => -49
	},
	{#State 162
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			'POSTINC' => 105,
			'BITOROP' => 106,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109,
			'BITXOROP' => 110,
			'SHIFTOP' => 100,
			'ANDAND' => 101,
			'EQOP' => 102,
			'RELOP' => 103
		},
		DEFAULT => -52
	},
	{#State 163
		DEFAULT => -30
	},
	{#State 164
		ACTIONS => {
			'ANDOP' => 112
		},
		DEFAULT => -31
	},
	{#State 165
		ACTIONS => {
			'OROP' => 113,
			'ANDOP' => 112
		},
		DEFAULT => -12
	},
	{#State 166
		ACTIONS => {
			'OROP' => 113,
			'ANDOP' => 112
		},
		DEFAULT => -11
	},
	{#State 167
		ACTIONS => {
			")" => 189
		}
	},
	{#State 168
		ACTIONS => {
			'OROP' => 113,
			'ANDOP' => 112
		},
		DEFAULT => -25
	},
	{#State 169
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			'ASSIGNOP' => 97,
			'POSTINC' => 105,
			'BITOROP' => 106,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'DOTDOT' => 108,
			'MULOP' => 109,
			'BITXOROP' => 110,
			'SHIFTOP' => 100,
			'OROR' => 111,
			'ANDAND' => 101,
			'EQOP' => 102,
			'RELOP' => 103
		},
		DEFAULT => -34
	},
	{#State 170
		DEFAULT => -36
	},
	{#State 171
		ACTIONS => {
			"}" => 190
		}
	},
	{#State 172
		DEFAULT => -9
	},
	{#State 173
		DEFAULT => -96
	},
	{#State 174
		DEFAULT => -75
	},
	{#State 175
		ACTIONS => {
			"{" => 59
		},
		GOTOS => {
			'block' => 191
		}
	},
	{#State 176
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 192,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 177
		DEFAULT => -89
	},
	{#State 178
		DEFAULT => -78
	},
	{#State 179
		DEFAULT => -37
	},
	{#State 180
		ACTIONS => {
			"}" => 193
		}
	},
	{#State 181
		DEFAULT => -88
	},
	{#State 182
		ACTIONS => {
			'OROP' => 113,
			")" => 194,
			'ANDOP' => 112
		}
	},
	{#State 183
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 195,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 184
		ACTIONS => {
			"{" => 59
		},
		GOTOS => {
			'block' => 196
		}
	},
	{#State 185
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		DEFAULT => -24,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 168,
			'texpr' => 197,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 186
		ACTIONS => {
			'OROP' => 113,
			")" => 198,
			'ANDOP' => 112
		}
	},
	{#State 187
		DEFAULT => -94
	},
	{#State 188
		DEFAULT => -105
	},
	{#State 189
		ACTIONS => {
			"{" => 59
		},
		GOTOS => {
			'block' => 199
		}
	},
	{#State 190
		DEFAULT => -38
	},
	{#State 191
		ACTIONS => {
			'ELSE' => 200,
			'ELSIF' => 202
		},
		DEFAULT => -13,
		GOTOS => {
			'else' => 201
		}
	},
	{#State 192
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			'ASSIGNOP' => 97,
			'POSTINC' => 105,
			")" => 203,
			'BITOROP' => 106,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'DOTDOT' => 108,
			'MULOP' => 109,
			'BITXOROP' => 110,
			'SHIFTOP' => 100,
			'OROR' => 111,
			'ANDAND' => 101,
			'RELOP' => 103,
			'EQOP' => 102
		}
	},
	{#State 193
		DEFAULT => -39
	},
	{#State 194
		ACTIONS => {
			"{" => 59
		},
		GOTOS => {
			'block' => 204
		}
	},
	{#State 195
		ACTIONS => {
			'OROP' => 113,
			")" => 205,
			'ANDOP' => 112
		}
	},
	{#State 196
		DEFAULT => -20
	},
	{#State 197
		ACTIONS => {
			";" => 206
		}
	},
	{#State 198
		DEFAULT => -92
	},
	{#State 199
		DEFAULT => -17
	},
	{#State 200
		ACTIONS => {
			"{" => 59
		},
		GOTOS => {
			'block' => 207
		}
	},
	{#State 201
		DEFAULT => -16
	},
	{#State 202
		ACTIONS => {
			"(" => 208
		}
	},
	{#State 203
		DEFAULT => -90
	},
	{#State 204
		DEFAULT => -19
	},
	{#State 205
		ACTIONS => {
			"{" => 59
		},
		GOTOS => {
			'block' => 209
		}
	},
	{#State 206
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		DEFAULT => -22,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'sideff' => 142,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 45,
			'nexpr' => 210,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 207
		DEFAULT => -14
	},
	{#State 208
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 18,
			'LOOPEX' => 46,
			'RESUB' => 21,
			'PMFUNC' => 25,
			'NOTOP' => 26,
			'ARGV' => 28,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 33,
			'FUNC1' => 34
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'function' => 36,
			'myattrterm' => 31,
			'amper' => 30,
			'subscripted' => 32,
			'term' => 43,
			'ary' => 14,
			'expr' => 211,
			'termbinop' => 20,
			'argexpr' => 51,
			'hsh' => 22,
			'termunop' => 23
		}
	},
	{#State 209
		DEFAULT => -18
	},
	{#State 210
		ACTIONS => {
			")" => 212
		}
	},
	{#State 211
		ACTIONS => {
			'OROP' => 113,
			")" => 213,
			'ANDOP' => 112
		}
	},
	{#State 212
		ACTIONS => {
			"{" => 59
		},
		GOTOS => {
			'block' => 214
		}
	},
	{#State 213
		ACTIONS => {
			"{" => 59
		},
		GOTOS => {
			'block' => 215
		}
	},
	{#State 214
		DEFAULT => -21
	},
	{#State 215
		ACTIONS => {
			'ELSE' => 200,
			'ELSIF' => 202
		},
		DEFAULT => -13,
		GOTOS => {
			'else' => 216
		}
	},
	{#State 216
		DEFAULT => -15
	}
],
                                  yyrules  =>
[
	[#Rule 0
		 '$start', 2, undef
	],
	[#Rule 1
		 'prog', 1, undef
	],
	[#Rule 2
		 'lineseq', 0, undef
	],
	[#Rule 3
		 'lineseq', 2,
sub
#line 325 "plpy.yp"
{
                    printer(\@_, qw(lineseq lineseq subrout)); 
                    return "$_[1]$_[2]\n";
                }
	],
	[#Rule 4
		 'lineseq', 2,
sub
#line 330 "plpy.yp"
{
                    printer(\@_, qw(lineseq lineseq line));
                    return "$_[1]$_[2]\n";
                }
	],
	[#Rule 5
		 'line', 1, undef
	],
	[#Rule 6
		 'line', 1, undef
	],
	[#Rule 7
		 'line', 2, undef
	],
	[#Rule 8
		 'line', 1, undef
	],
	[#Rule 9
		 'block', 3,
sub
#line 345 "plpy.yp"
{
                    printer(\@_, qw(block '{' lineseq '}')); 
                    # adds indentation
                    $_[2] =~ s/^/    /gm;   #"/
                    return "\n$_[2]\n";
                }
	],
	[#Rule 10
		 'sideff', 1, undef
	],
	[#Rule 11
		 'sideff', 3,
sub
#line 355 "plpy.yp"
{"while $_[3]: $_[1]"}
	],
	[#Rule 12
		 'sideff', 3,
sub
#line 356 "plpy.yp"
{"for $_[3]: $_[1]"}
	],
	[#Rule 13
		 'else', 0, undef
	],
	[#Rule 14
		 'else', 2,
sub
#line 361 "plpy.yp"
{"else:$_[2]"}
	],
	[#Rule 15
		 'else', 6,
sub
#line 362 "plpy.yp"
{"elif $_[3]:$_[5]$_[6]"}
	],
	[#Rule 16
		 'cond', 6,
sub
#line 366 "plpy.yp"
{"if $_[3]:$_[5]$_[6]"}
	],
	[#Rule 17
		 'loop', 5,
sub
#line 371 "plpy.yp"
{
                     printer (\@_, qw(WHILE '(' texpr ')' block)); 
                     if ($_[3] =~ /(\w+)\s*=\s*(.*)\s*/) {
                        return "for $1 in $2:$_[5]";
                     }
                     else {
                        return "while $_[3]:$_[5]";
                     }
                }
	],
	[#Rule 18
		 'loop', 7,
sub
#line 381 "plpy.yp"
{
                    printer (\@_, qw(loop FOR MY scalar '(' expr ')' block)); 
                    return "for $_[3] in $_[5]:$_[7]";
                }
	],
	[#Rule 19
		 'loop', 6,
sub
#line 386 "plpy.yp"
{
                    printer (\@_, qw(loop FOR scalar '(' expr ')' block)); 
                    return "for $_[2] in $_[4]:$_[6]";
                }
	],
	[#Rule 20
		 'loop', 5,
sub
#line 391 "plpy.yp"
{
                    printer (\@_, qw(loop FOR '(' expr ')' block)); 
                    return "for _ in $_[3]:$_[5]";
                }
	],
	[#Rule 21
		 'loop', 9,
sub
#line 396 "plpy.yp"
{
                    printer (\@_, qw(loop FOR '(' nexpr ';' texpr ';' nexpr ')' block)); 
                    return "$_[3]\nwhile $_[5]:$_[9]$_[7]\n";
                }
	],
	[#Rule 22
		 'nexpr', 0, undef
	],
	[#Rule 23
		 'nexpr', 1, undef
	],
	[#Rule 24
		 'texpr', 0,
sub
#line 408 "plpy.yp"
{"True"}
	],
	[#Rule 25
		 'texpr', 1, undef
	],
	[#Rule 26
		 'subrout', 3,
sub
#line 413 "plpy.yp"
{"def $_[2]():$_[3]"}
	],
	[#Rule 27
		 'subname', 1, undef
	],
	[#Rule 28
		 'subbody', 1, undef
	],
	[#Rule 29
		 'subbody', 1, undef
	],
	[#Rule 30
		 'expr', 3,
sub
#line 426 "plpy.yp"
{"$_[1] and $_[3]"}
	],
	[#Rule 31
		 'expr', 3,
sub
#line 427 "plpy.yp"
{"$_[1] or $_[3]"}
	],
	[#Rule 32
		 'expr', 1, undef
	],
	[#Rule 33
		 'argexpr', 2,
sub
#line 432 "plpy.yp"
{"$_[1], "}
	],
	[#Rule 34
		 'argexpr', 3,
sub
#line 433 "plpy.yp"
{"$_[1], $_[3]"}
	],
	[#Rule 35
		 'argexpr', 1, undef
	],
	[#Rule 36
		 'subscripted', 4,
sub
#line 438 "plpy.yp"
{"$_[1]\[$_[3]\]"}
	],
	[#Rule 37
		 'subscripted', 4,
sub
#line 439 "plpy.yp"
{"$_[1]\[$_[3]\]"}
	],
	[#Rule 38
		 'subscripted', 5,
sub
#line 441 "plpy.yp"
{
                    $_[0]->YYData->{"PRELUDE"}{"$_[1] = {}"} = 1; 
                    return "$_[1]\[$_[3]\]"; 
                }
	],
	[#Rule 39
		 'subscripted', 5,
sub
#line 445 "plpy.yp"
{"$_[1]\[$_[3]\]"}
	],
	[#Rule 40
		 'termbinop', 3,
sub
#line 450 "plpy.yp"
{
                    printer (\@_, "termbinop", "term", "ASSIGNOP", "term");
                    if ($_[2] eq '.=') {$_[2] = '+='}
                    return "$_[1] $_[2] $_[3]";
                }
	],
	[#Rule 41
		 'termbinop', 3,
sub
#line 456 "plpy.yp"
{
                    printer (\@_, "termbinop", "term", "POWOP", "term");
                    return "eval(str($_[1])) $_[2] eval(str($_[3]))";
                }
	],
	[#Rule 42
		 'termbinop', 3,
sub
#line 461 "plpy.yp"
{
                    printer (\@_, "termbinop", "term", "MULOP", "term");
                    return "eval(str($_[1])) $_[2] eval(str($_[3]))";
                }
	],
	[#Rule 43
		 'termbinop', 3,
sub
#line 466 "plpy.yp"
{
                    printer (\@_, "termbinop", "term", "ADDOP", "term");
                    if ($_[2] eq '.'){
                        return "str($_[1]) + str($_[3])";
                    }
                    else {
                        return "eval(str($_[1])) $_[2] eval(str($_[3]))";
                    }
                }
	],
	[#Rule 44
		 'termbinop', 3,
sub
#line 475 "plpy.yp"
{"$_[1] $_[2] $_[3]"}
	],
	[#Rule 45
		 'termbinop', 3,
sub
#line 477 "plpy.yp"
{
                    printer (\@_, qw(termbinop term EQOP term)); 
                    my %relop = (
                        "gt" => ">",
                        "ge" => ">=",
                        "le" => "<=",
                        "lt" => "<"
                    );
                    $_[2] = exists $relop{$_[2]} ? $relop{$_[2]} : $_[2];
                    return "$_[1] $_[2] $_[3]";
                }
	],
	[#Rule 46
		 'termbinop', 3,
sub
#line 489 "plpy.yp"
{
                    printer (\@_, qw(termbinop term EQOP term)); 
                    if ($_[2] eq 'eq') {$_[2] = '=='}
                    if ($_[2] eq '<=>') {
                        return "((a > b) - (a < b))";
                    }
                    return "$_[1] $_[2] $_[3]";
                }
	],
	[#Rule 47
		 'termbinop', 3,
sub
#line 497 "plpy.yp"
{"$_[1] & $_[2]"}
	],
	[#Rule 48
		 'termbinop', 3,
sub
#line 498 "plpy.yp"
{"$_[1] | $_[2]"}
	],
	[#Rule 49
		 'termbinop', 3,
sub
#line 499 "plpy.yp"
{"$_[1] ^ $_[2]"}
	],
	[#Rule 50
		 'termbinop', 3,
sub
#line 501 "plpy.yp"
{
                    return "list(range($_[1], $_[3] + 1))";
                }
	],
	[#Rule 51
		 'termbinop', 3,
sub
#line 504 "plpy.yp"
{"$_[1] and $_[3]"}
	],
	[#Rule 52
		 'termbinop', 3,
sub
#line 505 "plpy.yp"
{"$_[1] or $_[3]"}
	],
	[#Rule 53
		 'termbinop', 3,
sub
#line 507 "plpy.yp"
{
                    printer (\@_, qw(termbinop term MATCHOP term)); 
                    $_[0]->yydata->{"IMPORTS"}{"import re"} = 1; 

                    # TODO g flag
                    if ($_[3] =~ /^s/) {
                        $_[3] =~ /s\/((?<!\\)(?:\\\\)*.*)\/((?<!\\)(?:\\\\)*.*?)\/([msixpodualngcer]*)/;
                        my $re = $1;
                        my $repl = $2;
                        my $flags = compile_flags ($3);

                        $repl =~ s/(?<!\\)(?:\\\\)*\K\\(\d)/\\$1/;
                        my $sub_string;
                        if ($flags) {
                            $sub_string = "r'$re', '$repl', $_[1], $flags";
                        }
                        else {
                            $sub_string = "r'$re', '$repl', $_[1]";
                        }
                        return "$_[1] = re.sub($sub_string)";

                    }
                    else {
                        $_[3] =~ /\/((?<!\\)(?:\\\\)*.*)\/([imnsxadlup]*)/;
                        my $re = $1;
                        my $flags = compile_flags ($2);

                        my $search_string;
                        if ($flags) {
                            $search_string = "r'$re', $_[1], $flags";
                        }
                        else {
                            $search_string = "r'$re', $_[1]";
                        }
                        return "__MATCH__ = re.search($search_string)";
                        
                    }
                }
	],
	[#Rule 54
		 'termunop', 2,
sub
#line 548 "plpy.yp"
{"-$_[2]"}
	],
	[#Rule 55
		 'termunop', 2,
sub
#line 549 "plpy.yp"
{$_[2]}
	],
	[#Rule 56
		 'termunop', 2,
sub
#line 550 "plpy.yp"
{"not $_[2]"}
	],
	[#Rule 57
		 'termunop', 2,
sub
#line 551 "plpy.yp"
{"~$_[2]"}
	],
	[#Rule 58
		 'termunop', 2,
sub
#line 552 "plpy.yp"
{"$_[1] += 1"}
	],
	[#Rule 59
		 'termunop', 2,
sub
#line 553 "plpy.yp"
{"$_[1] -= 1"}
	],
	[#Rule 60
		 'term', 1, undef
	],
	[#Rule 61
		 'term', 1, undef
	],
	[#Rule 62
		 'term', 1,
sub
#line 559 "plpy.yp"
{
                    given ($_[1]) {
                        when ("<STDIN>") {
                                $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                                return "sys.stdin.readline()";
                        }
                        when ("<\@STDIN>") {
                                $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                                return "sys.stdin.readlines()";
                        }
                        when ("<>") {
                                $_[0]->YYData->{"IMPORTS"}{"import fileinput"} = 1; 
                                return "fileinput.input()";
                        }
                        default {
                                $_[1] =~ s/<(.*?)>/$1/;
                                return $_[1];
                        }
                    }
                    
                }
	],
	[#Rule 63
		 'term', 1, undef
	],
	[#Rule 64
		 'term', 1, undef
	],
	[#Rule 65
		 'term', 1,
sub
#line 583 "plpy.yp"
{
                    $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                    $_[0]->YYData->{"PRELUDE"}{"sys.argv = sys.argv[1:]"} = 1; 
                    return "sys.argv";
                }
	],
	[#Rule 66
		 'term', 1,
sub
#line 589 "plpy.yp"
{
                    printer (\@_, "term", "STRING");
                    $_[1] =~ s/^"\$(\w+)"/$1/;
                    return $_[1];
                }
	],
	[#Rule 67
		 'term', 1, undef
	],
	[#Rule 68
		 'term', 3,
sub
#line 595 "plpy.yp"
{$_[2]}
	],
	[#Rule 69
		 'term', 2,
sub
#line 596 "plpy.yp"
{"$_[1]$_[2]"}
	],
	[#Rule 70
		 'term', 1, undef
	],
	[#Rule 71
		 'term', 1, undef
	],
	[#Rule 72
		 'term', 1, undef
	],
	[#Rule 73
		 'term', 1, undef
	],
	[#Rule 74
		 'term', 1, undef
	],
	[#Rule 75
		 'term', 4,
sub
#line 603 "plpy.yp"
{
                    return "$_[1]$_[2]$_[3]$_[4]"; 
                }
	],
	[#Rule 76
		 'term', 1, undef
	],
	[#Rule 77
		 'term', 3, undef
	],
	[#Rule 78
		 'term', 4, undef
	],
	[#Rule 79
		 'term', 3,
sub
#line 610 "plpy.yp"
{
                    printer (\@_, qw(term NOAMP WORD listexpr)); 
                }
	],
	[#Rule 80
		 'term', 1,
sub
#line 614 "plpy.yp"
{
                    given ($_[1]) {
                        when ("last")   {"break"}
                        when ("next")   {"continue"}
                    }
                }
	],
	[#Rule 81
		 'term', 2,
sub
#line 620 "plpy.yp"
{"not $_[2]"}
	],
	[#Rule 82
		 'term', 1, undef
	],
	[#Rule 83
		 'term', 1, undef
	],
	[#Rule 84
		 'function', 1,
sub
#line 626 "plpy.yp"
{
                    printer (\@_, qw(term UNIOP)); 
                    if ($_[1] eq "exit"){
                       return "exit()";
                    }
                }
	],
	[#Rule 85
		 'function', 2, undef
	],
	[#Rule 86
		 'function', 2,
sub
#line 634 "plpy.yp"
{
                    printer (\@_, qw(term UNIOP term)); 
                    given ($_[1]) {
                        when ("chomp")  { "$_[2] = $_[2].strip()" }
                        when ("pop")    { "$_[2].pop()" }
                        when ("shift")  { "$_[2].pop(0)" }
                        when ("close")  { "$_[2].close()" }
                        when ("keys")   { "$_[2].keys()" }
                    }
                }
	],
	[#Rule 87
		 'function', 3,
sub
#line 645 "plpy.yp"
{
                    if ($_[1] eq "exit"){
                       return "exit()";
                    }
                }
	],
	[#Rule 88
		 'function', 4,
sub
#line 651 "plpy.yp"
{
                    given ($_[1]) {
                        when ("exit")   { "exit($_[3])" }
                        when ("chomp")  { "$_[3] = $_[3].strip()" }
                        when ("pop")    { "$_[3].pop()" }
                        when ("shift")  { "$_[3].pop(0)" }
                        when ("close")  { "$_[3].close()" }
                        when ("keys")   { "$_[3].keys()" }
                    }
                }
	],
	[#Rule 89
		 'function', 4, undef
	],
	[#Rule 90
		 'function', 6,
sub
#line 663 "plpy.yp"
{
                    $_[3] =~ s/\/(.*)\//$1/;
                    $_[3] =~ s/([\Q{}[]()^$.|*+?\\E\w\s]*)/$1/g;
                    return "split($_[3], $_[5])";
                }
	],
	[#Rule 91
		 'function', 3, undef
	],
	[#Rule 92
		 'function', 5, undef
	],
	[#Rule 93
		 'function', 2,
sub
#line 671 "plpy.yp"
{
                    printer (\@_, "term", "LSTOP", "listexpr");

                    given ($_[1]) {
                        when ("print")  { &func_print }
                        when ("printf") { &func_printf }
                        when ("split")  { "split($_[2])" }
                        when ("join")   { &func_join }
                        when ("push")   { &func_push }
                        when ("unshift"){ &func_unshift }
                        when ("reverse"){ "reversed($_[2])" }
                        when ("open")   { &func_open }
                        when ("sort")   { "sorted($_[2])" }
                    }
                }
	],
	[#Rule 94
		 'function', 4,
sub
#line 687 "plpy.yp"
{
                    $_[2] = $_[3];
                    given ($_[1]) {
                        when ("print")  { &func_print }
                        when ("printf") { &func_printf }
                        when ("split")  { "split($_[2])" }
                        when ("join")   { &func_join }
                        when ("push")   { &func_push }
                        when ("unshift"){ &func_unshift }
                        when ("reverse"){ "reversed($_[2])" }
                        when ("open")   { &func_open }
                        when ("sort")   { "sorted($_[2])" }
                    }
                }
	],
	[#Rule 95
		 'myattrterm', 2,
sub
#line 704 "plpy.yp"
{$_[2]}
	],
	[#Rule 96
		 'myterm', 3,
sub
#line 708 "plpy.yp"
{$_[2]}
	],
	[#Rule 97
		 'myterm', 2, undef
	],
	[#Rule 98
		 'myterm', 1, undef
	],
	[#Rule 99
		 'myterm', 1, undef
	],
	[#Rule 100
		 'myterm', 1, undef
	],
	[#Rule 101
		 'listexpr', 0, undef
	],
	[#Rule 102
		 'listexpr', 1, undef
	],
	[#Rule 103
		 'listexprcom', 0, undef
	],
	[#Rule 104
		 'listexprcom', 1, undef
	],
	[#Rule 105
		 'listexprcom', 2,
sub
#line 724 "plpy.yp"
{"$_[1], "}
	],
	[#Rule 106
		 'amper', 2,
sub
#line 729 "plpy.yp"
{$_[2]}
	],
	[#Rule 107
		 'scalar', 2,
sub
#line 732 "plpy.yp"
{$_[2]}
	],
	[#Rule 108
		 'ary', 2,
sub
#line 735 "plpy.yp"
{$_[2]}
	],
	[#Rule 109
		 'hsh', 2,
sub
#line 738 "plpy.yp"
{$_[2]}
	],
	[#Rule 110
		 'arylen', 2,
sub
#line 741 "plpy.yp"
{"len($_[2]) - 1"}
	],
	[#Rule 111
		 'indirob', 1, undef
	],
	[#Rule 112
		 'indirob', 1,
sub
#line 747 "plpy.yp"
{
                    $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                    $_[0]->YYData->{"PRELUDE"}{"sys.argv = sys.argv[1:]"} = 1; 
                    return "sys.argv";
                }
	],
	[#Rule 113
		 'indirob', 1, undef
	],
	[#Rule 114
		 'indirob', 1, undef
	]
],
                                  @_);
    bless($self,$class);
}

#line 756 "plpy.yp"


1;
