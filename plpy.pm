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

#line 7 "plpy.yp"

use Term::ANSIColor;

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
    my $lop = "print|printf|split|join|push|unshift|reverse|open|sort";
    my @tokens = (
        # matches a string with double or escaped quotes 
        ["STRING", qr/"(?:\\"|""|\\\\|[^"])*"/],
        # matches until first ', avoiding \'
        ["STRING", qr/'.*?(?<!\\)'/],
        # matches matching functions split (/foo/, $bar)
        ["PMFUNC", qr/split(?=\s*\(\s*\/)/],
        #matches all functions with brackets
        ["FUNC1", qr/(?:${uni})(?=\s*\()/],
        ["UNIOP", qr/(?:${uni})(?!\s*\()/],
        ["FUNC", qr/(?:${lop})(?=\s*\()/],
        ["LSTOP", qr/(?:${lop})/],
        ["STDIN", qr/<STDIN>/],
        ["STDINARR", qr/<\@STDIN>/],
        ["ARGV", qr/ARGV/],
        ["COMMENT", qr/\#.*/],
        ["FOR", qr/foreach/],
        ["FOR", qr/for/],
        ["WHILE", qr/while/],
        ["ELSIF", qr/elsif/],
        ["ELSE", qr/else/],
        ["LOOPEX", qr/last|next/],
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

    if ($found){
        my $maxpos = 0; 
        my $maxval = 0;
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
    elsif (!$found && !length($_[0]->YYData->{"DATA"})) {
        return ('', undef);
    }
    else {
        print STDERR "No Match Found\n";
        print STDERR $_[0]->YYData->{"DATA"}, "\n";
        return ('', undef);
    }
}

sub printer{
    my @tokens = @{shift(@_)};
    my @words = @_;
    my $parser = shift(@tokens);
    my $word_string = shift(@words)." => ";
    $word_string .= join(" -> ", @words);
    my $token_string = "$words[0]"." => ";
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


sub new {
        my($class)=shift;
        ref($class)
    and $class=ref($class);

    my($self)=$class->SUPER::new( yyversion => '1.05',
                                  yystates =>
[
	{#State 0
		DEFAULT => -6,
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
			"\@" => 7,
			"+" => 36,
			'FOR' => 35,
			"~" => 8,
			'COMMENT' => 11,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			'IF' => 18,
			"\$" => 17,
			'LOOPEX' => 44,
			'WHILE' => 45,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'SUB' => 27,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		DEFAULT => -1,
		GOTOS => {
			'scalar' => 6,
			'subrout' => 33,
			'sideff' => 34,
			'term' => 40,
			'loop' => 14,
			'ary' => 13,
			'expr' => 42,
			'decl' => 16,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21,
			'line' => 22,
			'cond' => 25,
			'arylen' => 46,
			'amper' => 28,
			'myattrterm' => 29,
			'subscripted' => 30,
			'argexpr' => 50
		}
	},
	{#State 3
		DEFAULT => 0
	},
	{#State 4
		DEFAULT => -97
	},
	{#State 5
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 51,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 6
		ACTIONS => {
			"[" => 52
		},
		DEFAULT => -75
	},
	{#State 7
		ACTIONS => {
			'WORD' => 54,
			"\$" => 17,
			"{" => 56
		},
		GOTOS => {
			'scalar' => 53,
			'indirob' => 55,
			'block' => 57
		}
	},
	{#State 8
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 58,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 9
		ACTIONS => {
			'WORD' => 54,
			"\$" => 17,
			"{" => 56
		},
		GOTOS => {
			'scalar' => 53,
			'indirob' => 59,
			'block' => 57
		}
	},
	{#State 10
		ACTIONS => {
			"(" => 63,
			"\@" => 7,
			"\$" => 17,
			"%" => 9
		},
		GOTOS => {
			'scalar' => 60,
			'myterm' => 64,
			'hsh' => 62,
			'ary' => 61
		}
	},
	{#State 11
		DEFAULT => -12
	},
	{#State 12
		ACTIONS => {
			"-" => 5,
			'WORD' => 65,
			"\@" => 7,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'LSTOP' => 12,
			"!" => 15,
			"\$" => 17,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			"(" => 31,
			'FUNC1' => 32,
			"+" => 36,
			'NOAMP' => 37,
			'DOLSHARP' => 38,
			'FUNC' => 39,
			'STRING' => 41,
			'STDINARR' => 43,
			'LOOPEX' => 44,
			"&" => 47,
			'UNIOP' => 48,
			"{" => 56,
			'STDIN' => 49
		},
		DEFAULT => -109,
		GOTOS => {
			'scalar' => 66,
			'arylen' => 46,
			'indirob' => 67,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'termbinop' => 19,
			'block' => 57,
			'argexpr' => 69,
			'listexpr' => 68,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 13
		ACTIONS => {
			"[" => 70,
			"{" => 71
		},
		DEFAULT => -77
	},
	{#State 14
		DEFAULT => -10
	},
	{#State 15
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 72,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 16
		DEFAULT => -7
	},
	{#State 17
		ACTIONS => {
			'WORD' => 54,
			"\$" => 17,
			"{" => 56
		},
		GOTOS => {
			'scalar' => 53,
			'indirob' => 73,
			'block' => 57
		}
	},
	{#State 18
		ACTIONS => {
			"(" => 74
		}
	},
	{#State 19
		DEFAULT => -66
	},
	{#State 20
		DEFAULT => -76
	},
	{#State 21
		DEFAULT => -67
	},
	{#State 22
		DEFAULT => -8
	},
	{#State 23
		ACTIONS => {
			"(" => 75
		}
	},
	{#State 24
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'termbinop' => 19,
			'argexpr' => 76,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 25
		DEFAULT => -9
	},
	{#State 26
		DEFAULT => -70
	},
	{#State 27
		DEFAULT => -35,
		GOTOS => {
			'startsub' => 77
		}
	},
	{#State 28
		ACTIONS => {
			"(" => 78
		},
		DEFAULT => -84
	},
	{#State 29
		DEFAULT => -72
	},
	{#State 30
		DEFAULT => -79
	},
	{#State 31
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			")" => 80,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 79,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 32
		ACTIONS => {
			"(" => 81
		}
	},
	{#State 33
		DEFAULT => -33
	},
	{#State 34
		ACTIONS => {
			";" => 82
		}
	},
	{#State 35
		ACTIONS => {
			"(" => 85,
			"\$" => 17,
			'MY' => 84
		},
		GOTOS => {
			'scalar' => 83
		}
	},
	{#State 36
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 86,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 37
		ACTIONS => {
			'WORD' => 87
		}
	},
	{#State 38
		ACTIONS => {
			'WORD' => 54,
			"\$" => 17,
			"{" => 56
		},
		GOTOS => {
			'scalar' => 53,
			'indirob' => 88,
			'block' => 57
		}
	},
	{#State 39
		ACTIONS => {
			"(" => 89
		}
	},
	{#State 40
		ACTIONS => {
			'BITANDOP' => 90,
			'ADDOP' => 98,
			'ASSIGNOP' => 91,
			'POSTINC' => 99,
			'BITOROP' => 100,
			'POWOP' => 92,
			'MATCHOP' => 93,
			'POSTDEC' => 101,
			'DOTDOT' => 102,
			'MULOP' => 103,
			'BITXOROP' => 104,
			'SHIFTOP' => 94,
			'OROR' => 105,
			'ANDAND' => 95,
			'EQOP' => 96,
			'RELOP' => 97
		},
		DEFAULT => -44
	},
	{#State 41
		DEFAULT => -71
	},
	{#State 42
		ACTIONS => {
			'FOR' => 109,
			'OROP' => 108,
			'ANDOP' => 106,
			'IF' => 107,
			'WHILE' => 110
		},
		DEFAULT => -13
	},
	{#State 43
		DEFAULT => -69
	},
	{#State 44
		DEFAULT => -88
	},
	{#State 45
		ACTIONS => {
			"(" => 111
		}
	},
	{#State 46
		DEFAULT => -78
	},
	{#State 47
		ACTIONS => {
			'WORD' => 54,
			"\$" => 17,
			"{" => 56
		},
		GOTOS => {
			'scalar' => 53,
			'indirob' => 112,
			'block' => 57
		}
	},
	{#State 48
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'LSTOP' => 12,
			"!" => 15,
			"\$" => 17,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			"(" => 31,
			'FUNC1' => 32,
			"+" => 36,
			'NOAMP' => 37,
			'DOLSHARP' => 38,
			'FUNC' => 39,
			'STRING' => 41,
			'STDINARR' => 43,
			'LOOPEX' => 44,
			"&" => 47,
			'UNIOP' => 48,
			"{" => 56,
			'STDIN' => 49
		},
		DEFAULT => -90,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 113,
			'ary' => 13,
			'termbinop' => 19,
			'block' => 114,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 49
		DEFAULT => -68
	},
	{#State 50
		ACTIONS => {
			"," => 115
		},
		DEFAULT => -41
	},
	{#State 51
		ACTIONS => {
			'POSTINC' => 99,
			'POWOP' => 92,
			'POSTDEC' => 101
		},
		DEFAULT => -60
	},
	{#State 52
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 116,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 53
		DEFAULT => -121
	},
	{#State 54
		DEFAULT => -120
	},
	{#State 55
		DEFAULT => -117
	},
	{#State 56
		DEFAULT => -3,
		GOTOS => {
			'remember' => 117
		}
	},
	{#State 57
		DEFAULT => -122
	},
	{#State 58
		ACTIONS => {
			'POSTINC' => 99,
			'POWOP' => 92,
			'POSTDEC' => 101
		},
		DEFAULT => -63
	},
	{#State 59
		DEFAULT => -118
	},
	{#State 60
		DEFAULT => -106
	},
	{#State 61
		DEFAULT => -108
	},
	{#State 62
		DEFAULT => -107
	},
	{#State 63
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			")" => 119,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 118,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 64
		ACTIONS => {
			'myattrlist' => 120
		},
		DEFAULT => -103
	},
	{#State 65
		ACTIONS => {
			"-" => -120,
			'WORD' => -120,
			"\@" => -120,
			"~" => -120,
			"%" => -120,
			'MY' => -120,
			'LSTOP' => -120,
			"!" => -120,
			"\$" => -120,
			'PMFUNC' => -120,
			'NOTOP' => -120,
			'ARGV' => -120,
			"(" => -120,
			'FUNC1' => -120,
			"+" => -120,
			'NOAMP' => -120,
			'DOLSHARP' => -120,
			'STRING' => -120,
			'FUNC' => -120,
			'STDINARR' => -120,
			'LOOPEX' => -120,
			'UNIOP' => -120,
			"&" => -120,
			'STDIN' => -120
		},
		DEFAULT => -97
	},
	{#State 66
		ACTIONS => {
			"-" => -121,
			'WORD' => -121,
			"\@" => -121,
			"~" => -121,
			"%" => -121,
			'MY' => -121,
			'LSTOP' => -121,
			"!" => -121,
			"\$" => -121,
			"[" => 52,
			'PMFUNC' => -121,
			'NOTOP' => -121,
			'ARGV' => -121,
			"(" => -121,
			'FUNC1' => -121,
			"+" => -121,
			'NOAMP' => -121,
			'DOLSHARP' => -121,
			'STRING' => -121,
			'FUNC' => -121,
			'STDINARR' => -121,
			'LOOPEX' => -121,
			'UNIOP' => -121,
			"&" => -121,
			'STDIN' => -121
		},
		DEFAULT => -75
	},
	{#State 67
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'termbinop' => 19,
			'argexpr' => 121,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 68
		DEFAULT => -100
	},
	{#State 69
		ACTIONS => {
			"," => 115
		},
		DEFAULT => -110
	},
	{#State 70
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 122,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 71
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 123,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 72
		ACTIONS => {
			'POSTINC' => 99,
			'POWOP' => 92,
			'POSTDEC' => 101
		},
		DEFAULT => -62
	},
	{#State 73
		DEFAULT => -116
	},
	{#State 74
		DEFAULT => -3,
		GOTOS => {
			'remember' => 124
		}
	},
	{#State 75
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 125,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 76
		ACTIONS => {
			"," => 115
		},
		DEFAULT => -89
	},
	{#State 77
		ACTIONS => {
			'WORD' => 126
		},
		GOTOS => {
			'subname' => 127
		}
	},
	{#State 78
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			")" => 129,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 128,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 79
		ACTIONS => {
			'OROP' => 108,
			")" => 130,
			'ANDOP' => 106
		}
	},
	{#State 80
		ACTIONS => {
			"[" => 131
		},
		DEFAULT => -74
	},
	{#State 81
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			")" => 133,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 132,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 82
		DEFAULT => -11
	},
	{#State 83
		ACTIONS => {
			"(" => 134
		}
	},
	{#State 84
		DEFAULT => -3,
		GOTOS => {
			'remember' => 135
		}
	},
	{#State 85
		DEFAULT => -3,
		GOTOS => {
			'remember' => 136
		}
	},
	{#State 86
		ACTIONS => {
			'POSTINC' => 99,
			'POWOP' => 92,
			'POSTDEC' => 101
		},
		DEFAULT => -61
	},
	{#State 87
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'LSTOP' => 12,
			"!" => 15,
			"\$" => 17,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			"(" => 31,
			'FUNC1' => 32,
			"+" => 36,
			'NOAMP' => 37,
			'DOLSHARP' => 38,
			'FUNC' => 39,
			'STRING' => 41,
			'STDINARR' => 43,
			'LOOPEX' => 44,
			"&" => 47,
			'UNIOP' => 48,
			'STDIN' => 49
		},
		DEFAULT => -109,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'termbinop' => 19,
			'argexpr' => 69,
			'listexpr' => 137,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 88
		DEFAULT => -119
	},
	{#State 89
		ACTIONS => {
			"-" => 5,
			'WORD' => 65,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			"{" => 56,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		DEFAULT => -111,
		GOTOS => {
			'scalar' => 66,
			'arylen' => 46,
			'indirob' => 138,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 140,
			'termbinop' => 19,
			'listexprcom' => 139,
			'block' => 57,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 90
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 141,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 91
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 142,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 92
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 143,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 93
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 144,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 94
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 145,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 95
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 146,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 96
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 147,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 97
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 148,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 98
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 149,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 99
		DEFAULT => -64
	},
	{#State 100
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 150,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 101
		DEFAULT => -65
	},
	{#State 102
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 151,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 103
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 152,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 104
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 153,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 105
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 154,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 106
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 155,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 107
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 156,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 108
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 157,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 109
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 158,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 110
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 159,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 111
		DEFAULT => -3,
		GOTOS => {
			'remember' => 160
		}
	},
	{#State 112
		DEFAULT => -115
	},
	{#State 113
		ACTIONS => {
			'ADDOP' => 98,
			'POSTINC' => 99,
			'POWOP' => 92,
			'MATCHOP' => 93,
			'POSTDEC' => 101,
			'MULOP' => 103,
			'SHIFTOP' => 94
		},
		DEFAULT => -92
	},
	{#State 114
		DEFAULT => -91
	},
	{#State 115
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'LSTOP' => 12,
			"!" => 15,
			"\$" => 17,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			"(" => 31,
			'FUNC1' => 32,
			"+" => 36,
			'NOAMP' => 37,
			'DOLSHARP' => 38,
			'FUNC' => 39,
			'STRING' => 41,
			'STDINARR' => 43,
			'LOOPEX' => 44,
			"&" => 47,
			'UNIOP' => 48,
			'STDIN' => 49
		},
		DEFAULT => -42,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 161,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 116
		ACTIONS => {
			'OROP' => 108,
			"]" => 162,
			'ANDOP' => 106
		}
	},
	{#State 117
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 163
		}
	},
	{#State 118
		ACTIONS => {
			'OROP' => 108,
			")" => 164,
			'ANDOP' => 106
		}
	},
	{#State 119
		DEFAULT => -105
	},
	{#State 120
		DEFAULT => -102
	},
	{#State 121
		ACTIONS => {
			"," => 115
		},
		DEFAULT => -98
	},
	{#State 122
		ACTIONS => {
			'OROP' => 108,
			"]" => 165,
			'ANDOP' => 106
		}
	},
	{#State 123
		ACTIONS => {
			";" => 166,
			'OROP' => 108,
			'ANDOP' => 106
		}
	},
	{#State 124
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'mexpr' => 167,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 168,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 125
		ACTIONS => {
			'BITANDOP' => 90,
			'ADDOP' => 98,
			"," => 169,
			'ASSIGNOP' => 91,
			'POSTINC' => 99,
			")" => 170,
			'BITOROP' => 100,
			'POWOP' => 92,
			'MATCHOP' => 93,
			'POSTDEC' => 101,
			'DOTDOT' => 102,
			'MULOP' => 103,
			'BITXOROP' => 104,
			'SHIFTOP' => 94,
			'OROR' => 105,
			'ANDAND' => 95,
			'RELOP' => 97,
			'EQOP' => 96
		}
	},
	{#State 126
		DEFAULT => -36
	},
	{#State 127
		ACTIONS => {
			";" => 172,
			"{" => 56
		},
		GOTOS => {
			'block' => 173,
			'subbody' => 171
		}
	},
	{#State 128
		ACTIONS => {
			'OROP' => 108,
			")" => 174,
			'ANDOP' => 106
		}
	},
	{#State 129
		DEFAULT => -85
	},
	{#State 130
		ACTIONS => {
			"[" => 175
		},
		DEFAULT => -73
	},
	{#State 131
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 176,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 132
		ACTIONS => {
			'OROP' => 108,
			")" => 177,
			'ANDOP' => 106
		}
	},
	{#State 133
		DEFAULT => -93
	},
	{#State 134
		DEFAULT => -3,
		GOTOS => {
			'remember' => 178
		}
	},
	{#State 135
		ACTIONS => {
			"\$" => 17
		},
		GOTOS => {
			'scalar' => 179,
			'my_scalar' => 180
		}
	},
	{#State 136
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		DEFAULT => -26,
		GOTOS => {
			'mexpr' => 181,
			'scalar' => 6,
			'sideff' => 183,
			'term' => 40,
			'ary' => 13,
			'expr' => 184,
			'nexpr' => 185,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21,
			'arylen' => 46,
			'mnexpr' => 182,
			'amper' => 28,
			'myattrterm' => 29,
			'subscripted' => 30,
			'argexpr' => 50
		}
	},
	{#State 137
		DEFAULT => -87
	},
	{#State 138
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 186,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 139
		ACTIONS => {
			")" => 187
		}
	},
	{#State 140
		ACTIONS => {
			'OROP' => 108,
			"," => 188,
			'ANDOP' => 106
		},
		DEFAULT => -112
	},
	{#State 141
		ACTIONS => {
			'ADDOP' => 98,
			'POSTINC' => 99,
			'POWOP' => 92,
			'MATCHOP' => 93,
			'POSTDEC' => 101,
			'MULOP' => 103,
			'SHIFTOP' => 94,
			'EQOP' => 96,
			'RELOP' => 97
		},
		DEFAULT => -53
	},
	{#State 142
		ACTIONS => {
			'BITANDOP' => 90,
			'ADDOP' => 98,
			'ASSIGNOP' => 91,
			'POSTINC' => 99,
			'BITOROP' => 100,
			'POWOP' => 92,
			'MATCHOP' => 93,
			'POSTDEC' => 101,
			'DOTDOT' => 102,
			'MULOP' => 103,
			'BITXOROP' => 104,
			'SHIFTOP' => 94,
			'OROR' => 105,
			'ANDAND' => 95,
			'EQOP' => 96,
			'RELOP' => 97
		},
		DEFAULT => -46
	},
	{#State 143
		ACTIONS => {
			'POSTINC' => 99,
			'POWOP' => 92,
			'POSTDEC' => 101
		},
		DEFAULT => -47
	},
	{#State 144
		ACTIONS => {
			'POSTINC' => 99,
			'POWOP' => 92,
			'POSTDEC' => 101
		},
		DEFAULT => -59
	},
	{#State 145
		ACTIONS => {
			'ADDOP' => 98,
			'POSTINC' => 99,
			'POWOP' => 92,
			'MATCHOP' => 93,
			'POSTDEC' => 101,
			'MULOP' => 103
		},
		DEFAULT => -50
	},
	{#State 146
		ACTIONS => {
			'BITANDOP' => 90,
			'ADDOP' => 98,
			'POSTINC' => 99,
			'BITOROP' => 100,
			'POWOP' => 92,
			'MATCHOP' => 93,
			'POSTDEC' => 101,
			'MULOP' => 103,
			'BITXOROP' => 104,
			'SHIFTOP' => 94,
			'EQOP' => 96,
			'RELOP' => 97
		},
		DEFAULT => -57
	},
	{#State 147
		ACTIONS => {
			'ADDOP' => 98,
			'POSTINC' => 99,
			'POWOP' => 92,
			'MATCHOP' => 93,
			'POSTDEC' => 101,
			'MULOP' => 103,
			'SHIFTOP' => 94,
			'EQOP' => undef,
			'RELOP' => 97
		},
		DEFAULT => -52
	},
	{#State 148
		ACTIONS => {
			'ADDOP' => 98,
			'POSTINC' => 99,
			'POWOP' => 92,
			'MATCHOP' => 93,
			'POSTDEC' => 101,
			'MULOP' => 103,
			'SHIFTOP' => 94,
			'RELOP' => undef
		},
		DEFAULT => -51
	},
	{#State 149
		ACTIONS => {
			'POSTINC' => 99,
			'POWOP' => 92,
			'MATCHOP' => 93,
			'POSTDEC' => 101,
			'MULOP' => 103
		},
		DEFAULT => -49
	},
	{#State 150
		ACTIONS => {
			'BITANDOP' => 90,
			'ADDOP' => 98,
			'POSTINC' => 99,
			'POWOP' => 92,
			'MATCHOP' => 93,
			'POSTDEC' => 101,
			'MULOP' => 103,
			'SHIFTOP' => 94,
			'EQOP' => 96,
			'RELOP' => 97
		},
		DEFAULT => -54
	},
	{#State 151
		ACTIONS => {
			'BITANDOP' => 90,
			'ADDOP' => 98,
			'POSTINC' => 99,
			'BITOROP' => 100,
			'POWOP' => 92,
			'MATCHOP' => 93,
			'POSTDEC' => 101,
			'DOTDOT' => undef,
			'MULOP' => 103,
			'BITXOROP' => 104,
			'SHIFTOP' => 94,
			'OROR' => 105,
			'ANDAND' => 95,
			'EQOP' => 96,
			'RELOP' => 97
		},
		DEFAULT => -56
	},
	{#State 152
		ACTIONS => {
			'POSTINC' => 99,
			'POWOP' => 92,
			'MATCHOP' => 93,
			'POSTDEC' => 101
		},
		DEFAULT => -48
	},
	{#State 153
		ACTIONS => {
			'BITANDOP' => 90,
			'ADDOP' => 98,
			'POSTINC' => 99,
			'POWOP' => 92,
			'MATCHOP' => 93,
			'POSTDEC' => 101,
			'MULOP' => 103,
			'SHIFTOP' => 94,
			'EQOP' => 96,
			'RELOP' => 97
		},
		DEFAULT => -55
	},
	{#State 154
		ACTIONS => {
			'BITANDOP' => 90,
			'ADDOP' => 98,
			'POSTINC' => 99,
			'BITOROP' => 100,
			'POWOP' => 92,
			'MATCHOP' => 93,
			'POSTDEC' => 101,
			'MULOP' => 103,
			'BITXOROP' => 104,
			'SHIFTOP' => 94,
			'ANDAND' => 95,
			'EQOP' => 96,
			'RELOP' => 97
		},
		DEFAULT => -58
	},
	{#State 155
		DEFAULT => -39
	},
	{#State 156
		ACTIONS => {
			'OROP' => 108,
			'ANDOP' => 106
		},
		DEFAULT => -14
	},
	{#State 157
		ACTIONS => {
			'ANDOP' => 106
		},
		DEFAULT => -40
	},
	{#State 158
		ACTIONS => {
			'OROP' => 108,
			'ANDOP' => 106
		},
		DEFAULT => -16
	},
	{#State 159
		ACTIONS => {
			'OROP' => 108,
			'ANDOP' => 106
		},
		DEFAULT => -15
	},
	{#State 160
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		DEFAULT => -28,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 191,
			'texpr' => 189,
			'termbinop' => 19,
			'mtexpr' => 190,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 161
		ACTIONS => {
			'BITANDOP' => 90,
			'ADDOP' => 98,
			'ASSIGNOP' => 91,
			'POSTINC' => 99,
			'BITOROP' => 100,
			'POWOP' => 92,
			'MATCHOP' => 93,
			'POSTDEC' => 101,
			'DOTDOT' => 102,
			'MULOP' => 103,
			'BITXOROP' => 104,
			'SHIFTOP' => 94,
			'OROR' => 105,
			'ANDAND' => 95,
			'EQOP' => 96,
			'RELOP' => 97
		},
		DEFAULT => -43
	},
	{#State 162
		DEFAULT => -45
	},
	{#State 163
		ACTIONS => {
			"}" => 192,
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			'FOR' => 35,
			"+" => 36,
			"~" => 8,
			'COMMENT' => 11,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			'IF' => 18,
			"\$" => 17,
			'LOOPEX' => 44,
			'WHILE' => 45,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'SUB' => 27,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 33,
			'sideff' => 34,
			'term' => 40,
			'loop' => 14,
			'ary' => 13,
			'expr' => 42,
			'decl' => 16,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21,
			'line' => 22,
			'cond' => 25,
			'arylen' => 46,
			'amper' => 28,
			'myattrterm' => 29,
			'subscripted' => 30,
			'argexpr' => 50
		}
	},
	{#State 164
		DEFAULT => -104
	},
	{#State 165
		DEFAULT => -82
	},
	{#State 166
		ACTIONS => {
			"}" => 193
		}
	},
	{#State 167
		ACTIONS => {
			")" => 194
		}
	},
	{#State 168
		ACTIONS => {
			'OROP' => 108,
			'ANDOP' => 106
		},
		DEFAULT => -30
	},
	{#State 169
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 195,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 170
		DEFAULT => -95
	},
	{#State 171
		DEFAULT => -34
	},
	{#State 172
		DEFAULT => -38
	},
	{#State 173
		DEFAULT => -37
	},
	{#State 174
		DEFAULT => -86
	},
	{#State 175
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 196,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 176
		ACTIONS => {
			'OROP' => 108,
			"]" => 197,
			'ANDOP' => 106
		}
	},
	{#State 177
		DEFAULT => -94
	},
	{#State 178
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'mexpr' => 198,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 168,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 179
		DEFAULT => -114
	},
	{#State 180
		ACTIONS => {
			"(" => 199
		}
	},
	{#State 181
		ACTIONS => {
			")" => 200
		}
	},
	{#State 182
		ACTIONS => {
			";" => 201
		}
	},
	{#State 183
		DEFAULT => -27
	},
	{#State 184
		ACTIONS => {
			'FOR' => 109,
			'OROP' => 108,
			'ANDOP' => 106,
			'IF' => 107,
			")" => -30,
			'WHILE' => 110
		},
		DEFAULT => -13
	},
	{#State 185
		DEFAULT => -31
	},
	{#State 186
		ACTIONS => {
			'OROP' => 108,
			")" => 202,
			'ANDOP' => 106
		}
	},
	{#State 187
		DEFAULT => -101
	},
	{#State 188
		DEFAULT => -113
	},
	{#State 189
		DEFAULT => -32
	},
	{#State 190
		ACTIONS => {
			")" => 203
		}
	},
	{#State 191
		ACTIONS => {
			'OROP' => 108,
			'ANDOP' => 106
		},
		DEFAULT => -29
	},
	{#State 192
		DEFAULT => -2
	},
	{#State 193
		DEFAULT => -83
	},
	{#State 194
		ACTIONS => {
			"{" => 204
		},
		GOTOS => {
			'mblock' => 205
		}
	},
	{#State 195
		ACTIONS => {
			'BITANDOP' => 90,
			'ADDOP' => 98,
			'ASSIGNOP' => 91,
			'POSTINC' => 99,
			")" => 206,
			'BITOROP' => 100,
			'POWOP' => 92,
			'MATCHOP' => 93,
			'POSTDEC' => 101,
			'DOTDOT' => 102,
			'MULOP' => 103,
			'BITXOROP' => 104,
			'SHIFTOP' => 94,
			'OROR' => 105,
			'ANDAND' => 95,
			'RELOP' => 97,
			'EQOP' => 96
		}
	},
	{#State 196
		ACTIONS => {
			'OROP' => 108,
			"]" => 207,
			'ANDOP' => 106
		}
	},
	{#State 197
		DEFAULT => -81
	},
	{#State 198
		ACTIONS => {
			")" => 208
		}
	},
	{#State 199
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'mexpr' => 209,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 168,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 200
		ACTIONS => {
			"{" => 204
		},
		GOTOS => {
			'mblock' => 210
		}
	},
	{#State 201
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		DEFAULT => -28,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 191,
			'texpr' => 189,
			'termbinop' => 19,
			'mtexpr' => 211,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 202
		DEFAULT => -99
	},
	{#State 203
		ACTIONS => {
			"{" => 204
		},
		GOTOS => {
			'mblock' => 212
		}
	},
	{#State 204
		DEFAULT => -5,
		GOTOS => {
			'mremember' => 213
		}
	},
	{#State 205
		ACTIONS => {
			'ELSE' => 214,
			'ELSIF' => 216
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 215
		}
	},
	{#State 206
		DEFAULT => -96
	},
	{#State 207
		DEFAULT => -80
	},
	{#State 208
		ACTIONS => {
			"{" => 204
		},
		GOTOS => {
			'mblock' => 217
		}
	},
	{#State 209
		ACTIONS => {
			")" => 218
		}
	},
	{#State 210
		DEFAULT => -24
	},
	{#State 211
		ACTIONS => {
			";" => 219
		}
	},
	{#State 212
		DEFAULT => -21
	},
	{#State 213
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 220
		}
	},
	{#State 214
		ACTIONS => {
			"{" => 204
		},
		GOTOS => {
			'mblock' => 221
		}
	},
	{#State 215
		DEFAULT => -20
	},
	{#State 216
		ACTIONS => {
			"(" => 222
		}
	},
	{#State 217
		DEFAULT => -23
	},
	{#State 218
		ACTIONS => {
			"{" => 204
		},
		GOTOS => {
			'mblock' => 223
		}
	},
	{#State 219
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		DEFAULT => -26,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'sideff' => 183,
			'mnexpr' => 224,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 42,
			'nexpr' => 185,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 220
		ACTIONS => {
			"}" => 225,
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			'FOR' => 35,
			"+" => 36,
			"~" => 8,
			'COMMENT' => 11,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			'IF' => 18,
			"\$" => 17,
			'LOOPEX' => 44,
			'WHILE' => 45,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'SUB' => 27,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 33,
			'sideff' => 34,
			'term' => 40,
			'loop' => 14,
			'ary' => 13,
			'expr' => 42,
			'decl' => 16,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21,
			'line' => 22,
			'cond' => 25,
			'arylen' => 46,
			'amper' => 28,
			'myattrterm' => 29,
			'subscripted' => 30,
			'argexpr' => 50
		}
	},
	{#State 221
		DEFAULT => -18
	},
	{#State 222
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 37,
			'LSTOP' => 12,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 15,
			'STDINARR' => 43,
			"\$" => 17,
			'LOOPEX' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'ARGV' => 26,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'STDIN' => 49,
			'FUNC1' => 32
		},
		GOTOS => {
			'mexpr' => 226,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 13,
			'expr' => 168,
			'termbinop' => 19,
			'argexpr' => 50,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 223
		DEFAULT => -22
	},
	{#State 224
		ACTIONS => {
			")" => 227
		}
	},
	{#State 225
		DEFAULT => -4
	},
	{#State 226
		ACTIONS => {
			")" => 228
		}
	},
	{#State 227
		ACTIONS => {
			"{" => 204
		},
		GOTOS => {
			'mblock' => 229
		}
	},
	{#State 228
		ACTIONS => {
			"{" => 204
		},
		GOTOS => {
			'mblock' => 230
		}
	},
	{#State 229
		DEFAULT => -25
	},
	{#State 230
		ACTIONS => {
			'ELSE' => 214,
			'ELSIF' => 216
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 231
		}
	},
	{#State 231
		DEFAULT => -19
	}
],
                                  yyrules  =>
[
	[#Rule 0
		 '$start', 2, undef
	],
	[#Rule 1
		 'prog', 1,
sub
#line 208 "plpy.yp"
{
                printer(\@_, "prog", "lineseq");
                return "$_[1]";
            }
	],
	[#Rule 2
		 'block', 4,
sub
#line 216 "plpy.yp"
{
                printer(\@_, qw( block { lineseq } )); 
                #adds indentation
                $_[3] =~ s/^/    /gm;   #"/
                return "\n$_[3]\n";
            }
	],
	[#Rule 3
		 'remember', 0, undef
	],
	[#Rule 4
		 'mblock', 4,
sub
#line 228 "plpy.yp"
{
                printer(\@_, qw( mblock { lineseq } )); 
                #adds indentation
                $_[3] =~ s/^/    /gm;    #"/
                return "\n$_[3]\n";
            }
	],
	[#Rule 5
		 'mremember', 0, undef
	],
	[#Rule 6
		 'lineseq', 0, undef
	],
	[#Rule 7
		 'lineseq', 2,
sub
#line 242 "plpy.yp"
{
                printer(\@_, qw( lineseq lineseq decl )); 
                return "$_[1]$_[2]";
            }
	],
	[#Rule 8
		 'lineseq', 2,
sub
#line 247 "plpy.yp"
{
                printer(\@_, "lineseq", "lineseq", "line");
                return "$_[1]$_[2]";
            }
	],
	[#Rule 9
		 'line', 1,
sub
#line 255 "plpy.yp"
{
                printer(\@_, qw( line cond )); 
                return $_[1];
            }
	],
	[#Rule 10
		 'line', 1,
sub
#line 261 "plpy.yp"
{
                printer(\@_, qw( line loop )); 
                return $_[1];
            }
	],
	[#Rule 11
		 'line', 2,
sub
#line 267 "plpy.yp"
{
                printer(\@_, "line", "sideff", "';'");
                return "$_[1]\n";
            }
	],
	[#Rule 12
		 'line', 1,
sub
#line 272 "plpy.yp"
{
                printer(\@_, "line", "COMMENT");
                return "$_[1]\n";
            }
	],
	[#Rule 13
		 'sideff', 1,
sub
#line 281 "plpy.yp"
{
                printer(\@_, "sideff", "expr");
                return $_[1];
            }
	],
	[#Rule 14
		 'sideff', 3,
sub
#line 287 "plpy.yp"
{
                printer(\@_, qw( sideff expr IF expr ));
                return "if $_[3]: $_[1]";
            }
	],
	[#Rule 15
		 'sideff', 3,
sub
#line 292 "plpy.yp"
{
                printer(\@_, qw( sideff expr WHILE expr ));
                return "$_[1] while $_[3]";
            }
	],
	[#Rule 16
		 'sideff', 3,
sub
#line 297 "plpy.yp"
{
                printer (\@_, qw(sideff expr FOR expr));
                return "$_[1] for $_[3]";
            }
	],
	[#Rule 17
		 'else', 0, undef
	],
	[#Rule 18
		 'else', 2,
sub
#line 306 "plpy.yp"
{
                printer (\@_, qw( else ELSE mblock ));
                return "else:$_[2]";
            }
	],
	[#Rule 19
		 'else', 6,
sub
#line 311 "plpy.yp"
{
                printer (\@_, qw( else ELSIF '(' mexpr ')' mblock else)); 
                return "elif $_[3]:$_[5]$_[6]";
            }
	],
	[#Rule 20
		 'cond', 7,
sub
#line 319 "plpy.yp"
{
                printer (\@_, qw( IF '(' remember mexpr ')' mblock else));
                return "if $_[4]:$_[6]$_[7]";
                
            }
	],
	[#Rule 21
		 'loop', 6,
sub
#line 328 "plpy.yp"
{
                 printer (\@_, qw(WHILE '(' remember mtexpr ')' mblock cont)); 
                 return "while $_[4]:$_[6]$_[7]";
            }
	],
	[#Rule 22
		 'loop', 8,
sub
#line 333 "plpy.yp"
{
                printer (\@_, qw(loop FOR MY remember my_scalar '(' mexpr ')' mblock cont)); 
                return "for $_[4] in $_[6]:$_[8]";
            }
	],
	[#Rule 23
		 'loop', 7,
sub
#line 338 "plpy.yp"
{
                printer (\@_, qw(loop FOR scalar '(' mexpr ')' mblock cont)); 
                return "for $_[2] in $_[5]:$_[7]";
            }
	],
	[#Rule 24
		 'loop', 6,
sub
#line 343 "plpy.yp"
{}
	],
	[#Rule 25
		 'loop', 10,
sub
#line 345 "plpy.yp"
{
                printer (\@_, qw(loop FOR '(' remember mnexpr ';' mtexpr ';' mnexpr ')' mblock)); 
                return "$_[4]\nwhile $_[6]:$_[10] hi   $_[8]\n";
            }
	],
	[#Rule 26
		 'nexpr', 0,
sub
#line 353 "plpy.yp"
{}
	],
	[#Rule 27
		 'nexpr', 1, undef
	],
	[#Rule 28
		 'texpr', 0,
sub
#line 359 "plpy.yp"
{}
	],
	[#Rule 29
		 'texpr', 1, undef
	],
	[#Rule 30
		 'mexpr', 1,
sub
#line 365 "plpy.yp"
{
                printer (\@_, qw(mexpr expr) ); 
                return $_[1];
            }
	],
	[#Rule 31
		 'mnexpr', 1, undef
	],
	[#Rule 32
		 'mtexpr', 1, undef
	],
	[#Rule 33
		 'decl', 1,
sub
#line 379 "plpy.yp"
{}
	],
	[#Rule 34
		 'subrout', 4,
sub
#line 384 "plpy.yp"
{}
	],
	[#Rule 35
		 'startsub', 0,
sub
#line 388 "plpy.yp"
{}
	],
	[#Rule 36
		 'subname', 1,
sub
#line 392 "plpy.yp"
{}
	],
	[#Rule 37
		 'subbody', 1,
sub
#line 396 "plpy.yp"
{}
	],
	[#Rule 38
		 'subbody', 1,
sub
#line 397 "plpy.yp"
{}
	],
	[#Rule 39
		 'expr', 3,
sub
#line 403 "plpy.yp"
{
                printer (\@_, qw(expr expr ANDOP expr)); 
                return "$_[1] and $_[3]";
            }
	],
	[#Rule 40
		 'expr', 3,
sub
#line 408 "plpy.yp"
{
                printer (\@_, qw(expr expr OROP expr)); 
                return "$_[1] or $_[3]";
            }
	],
	[#Rule 41
		 'expr', 1,
sub
#line 413 "plpy.yp"
{
                printer(\@_, qw(expr argexpr));
                return $_[1];
            }
	],
	[#Rule 42
		 'argexpr', 2,
sub
#line 421 "plpy.yp"
{
                printer (\@_, "argexpr", "','");
                return "$_[1], ";
            }
	],
	[#Rule 43
		 'argexpr', 3,
sub
#line 426 "plpy.yp"
{
                printer (\@_, "argexpr", "','", "term");
                return "$_[1], $_[3]";
            }
	],
	[#Rule 44
		 'argexpr', 1,
sub
#line 431 "plpy.yp"
{
                printer (\@_, "argexpr", "term");
                return $_[1];
            }
	],
	[#Rule 45
		 'subscripted', 4,
sub
#line 441 "plpy.yp"
{}
	],
	[#Rule 46
		 'termbinop', 3,
sub
#line 446 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "ASSIGNOP", "term");
                if ($_[2] eq '.=') {$_[2] = '+='}
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 47
		 'termbinop', 3,
sub
#line 452 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "POWOP", "term");
                return "int($_[1]) $_[2] int($_[3])";
            }
	],
	[#Rule 48
		 'termbinop', 3,
sub
#line 457 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "MULOP", "term");
                return "int($_[1]) $_[2] int($_[3])";
            }
	],
	[#Rule 49
		 'termbinop', 3,
sub
#line 462 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "ADDOP", "term");
                return "int($_[1]) $_[2] int($_[3])";
            }
	],
	[#Rule 50
		 'termbinop', 3,
sub
#line 467 "plpy.yp"
{
                printer (\@_, qw(term SHIFTOP term)); 
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 51
		 'termbinop', 3,
sub
#line 472 "plpy.yp"
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
	[#Rule 52
		 'termbinop', 3,
sub
#line 484 "plpy.yp"
{
                printer (\@_, qw(termbinop term EQOP term)); 
                if ($_[2] eq 'eq') {$_[2] = '=='}
                if ($_[2] eq '<=>') {
                    return "((a > b) - (a < b))";
                }
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 53
		 'termbinop', 3,
sub
#line 493 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITANDOP term)); 
                return "$_[1] & $_[2]";
            }
	],
	[#Rule 54
		 'termbinop', 3,
sub
#line 498 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITOROP term)); 
                return "$_[1] | $_[2]";
            }
	],
	[#Rule 55
		 'termbinop', 3,
sub
#line 503 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITXOROP term)); 
                return "$_[1] ^ $_[2]";
            }
	],
	[#Rule 56
		 'termbinop', 3,
sub
#line 508 "plpy.yp"
{
                return "list(range($_[1], $_[3]))";
            }
	],
	[#Rule 57
		 'termbinop', 3,
sub
#line 512 "plpy.yp"
{
                printer (\@_, qw(termbinop term ANDAND term)); 
                return "$_[1] and $_[3]";
            }
	],
	[#Rule 58
		 'termbinop', 3,
sub
#line 517 "plpy.yp"
{
                printer (\@_, qw(termbinop term OROR term)); 
                return "$_[1] or $_[3]";
            }
	],
	[#Rule 59
		 'termbinop', 3,
sub
#line 522 "plpy.yp"
{}
	],
	[#Rule 60
		 'termunop', 2,
sub
#line 527 "plpy.yp"
{}
	],
	[#Rule 61
		 'termunop', 2,
sub
#line 529 "plpy.yp"
{}
	],
	[#Rule 62
		 'termunop', 2,
sub
#line 531 "plpy.yp"
{
                printer (\@_, qw(termunop '!' term)); 
                return "not $_[2]";
            }
	],
	[#Rule 63
		 'termunop', 2,
sub
#line 536 "plpy.yp"
{
                printer (\@_, qw(termunop '~' term)); 
                return "~$_[2]";
            }
	],
	[#Rule 64
		 'termunop', 2,
sub
#line 541 "plpy.yp"
{
                printer (\@_, qw(termunop term POSTINC)); 
                return "$_[1] += 1";
            }
	],
	[#Rule 65
		 'termunop', 2,
sub
#line 546 "plpy.yp"
{
                printer (\@_, qw(termunop term POSTDEC)); 
                return "$_[1] -= 1";
            }
	],
	[#Rule 66
		 'term', 1, undef
	],
	[#Rule 67
		 'term', 1, undef
	],
	[#Rule 68
		 'term', 1,
sub
#line 555 "plpy.yp"
{
                $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                return "sys.stdin.readline()";
            }
	],
	[#Rule 69
		 'term', 1,
sub
#line 560 "plpy.yp"
{
                $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                return "sys.stdin.readlines()";
            }
	],
	[#Rule 70
		 'term', 1,
sub
#line 565 "plpy.yp"
{
                $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                return "sys.argv";
            }
	],
	[#Rule 71
		 'term', 1,
sub
#line 570 "plpy.yp"
{
                printer (\@_, "term", "STRING");
                $_[1] =~ s/^"\$(\w+)"/$1/;
                return $_[1];
            }
	],
	[#Rule 72
		 'term', 1,
sub
#line 577 "plpy.yp"
{}
	],
	[#Rule 73
		 'term', 3,
sub
#line 579 "plpy.yp"
{
                return $_[2];    
            }
	],
	[#Rule 74
		 'term', 2,
sub
#line 583 "plpy.yp"
{}
	],
	[#Rule 75
		 'term', 1,
sub
#line 585 "plpy.yp"
{
                printer (\@_, "term", "scalar");
                return $_[1];
            }
	],
	[#Rule 76
		 'term', 1,
sub
#line 590 "plpy.yp"
{}
	],
	[#Rule 77
		 'term', 1,
sub
#line 592 "plpy.yp"
{
                printer (\@_, qw(term ary)); 
                return $_[1];
            }
	],
	[#Rule 78
		 'term', 1,
sub
#line 597 "plpy.yp"
{}
	],
	[#Rule 79
		 'term', 1,
sub
#line 599 "plpy.yp"
{}
	],
	[#Rule 80
		 'term', 6,
sub
#line 601 "plpy.yp"
{}
	],
	[#Rule 81
		 'term', 5,
sub
#line 603 "plpy.yp"
{}
	],
	[#Rule 82
		 'term', 4,
sub
#line 605 "plpy.yp"
{}
	],
	[#Rule 83
		 'term', 5,
sub
#line 607 "plpy.yp"
{}
	],
	[#Rule 84
		 'term', 1,
sub
#line 609 "plpy.yp"
{}
	],
	[#Rule 85
		 'term', 3,
sub
#line 611 "plpy.yp"
{}
	],
	[#Rule 86
		 'term', 4,
sub
#line 613 "plpy.yp"
{}
	],
	[#Rule 87
		 'term', 3,
sub
#line 615 "plpy.yp"
{
                printer (\@_, qw(term NOAMP WORD listexpr)); 
            }
	],
	[#Rule 88
		 'term', 1,
sub
#line 619 "plpy.yp"
{
                if ($_[1] eq "last"){
                    return "break";
                }
                elsif ($_[1] eq "next"){
                    return "continue";
                }

            }
	],
	[#Rule 89
		 'term', 2,
sub
#line 629 "plpy.yp"
{
                printer (\@_, qw(term NOTOP argexpr)); 
                return "not $_[2]";
            }
	],
	[#Rule 90
		 'term', 1,
sub
#line 634 "plpy.yp"
{
                print STDERR "($_[1])";
                printer (\@_, qw(term UNIOP)); 
            }
	],
	[#Rule 91
		 'term', 2,
sub
#line 639 "plpy.yp"
{
                print STDERR "($_[1], $_[2])";
                printer (\@_, qw(term UNIOP block)); 
            }
	],
	[#Rule 92
		 'term', 2,
sub
#line 644 "plpy.yp"
{
                printer (\@_, qw(term UNIOP term)); 
                print STDERR "($_[1], $_[2])";
                if ($_[1] eq "chomp"){
                   return "$_[2].strip()";
                }
            }
	],
	[#Rule 93
		 'term', 3,
sub
#line 652 "plpy.yp"
{}
	],
	[#Rule 94
		 'term', 4,
sub
#line 654 "plpy.yp"
{
                if ($_[0] eq "chomp"){
                   return "$_[2].strip()" 
                }
            }
	],
	[#Rule 95
		 'term', 4,
sub
#line 660 "plpy.yp"
{}
	],
	[#Rule 96
		 'term', 6,
sub
#line 662 "plpy.yp"
{
                $_[3] =~ s/\/(.*)\//$1/;
                $_[3] =~ s/\\([\{\}\[\]\(\)\^\$\.\|\*\+\?\\])/$1/g;
                return "split($_[3], $_[5])";
            }
	],
	[#Rule 97
		 'term', 1, undef
	],
	[#Rule 98
		 'term', 3,
sub
#line 671 "plpy.yp"
{
                printer (\@_, "term", "LSTOP", "indirob", "argexpr");
            }
	],
	[#Rule 99
		 'term', 5,
sub
#line 675 "plpy.yp"
{}
	],
	[#Rule 100
		 'term', 2,
sub
#line 677 "plpy.yp"
{
                printer (\@_, "term", "LSTOP", "listexpr");

                if ($_[1] eq "print"){
                    #if ending newline was removed
                    # "hi\n" or "hi", "\n"
                    if ($_[2] =~ s/^.*\K(?:,\s*"\\n"$)|(?:(?<!\\)\\n(?=\s*"$))//){ #"
                    # finds all strings and then replaces
                    # "$var" to var
                    # yes, that's a regex in a regex.
                        $_[2] =~ s["(?:\\"|""|\\\\|[^"])*"]{ 
                                     $& =~ /"\$(.*)"/ ? $1 : $& 
                                 }eg;
                        return "print($_[2])";
                    }
                    else{
                        $_[2] =~ s["(?:\\"|""|\\\\|[^"])*"]{ 
                                     $& =~ /"\$(.*)"/ ? $1 : $& 
                                 }eg;
                        return "print($_[2], end='')";
                    }
                }
                elsif ($_[1] eq "split") {
                    return "split($_[2])";
                }
                elsif ($_[1] eq "join") {
                    printer (\@_, "term", "LSTOP", "listexpr");
                    my @list = split(', ', $_[2]);
                    my $delim = shift @list;
                    return "'$delim'.join(@list)";
                }
            }
	],
	[#Rule 101
		 'term', 4,
sub
#line 710 "plpy.yp"
{
                if ($_[1] eq "join") {
                    print STDERR "($_[3])";
                    printer (\@_, "term", "LSTOP", "listexpr");
                    my @list = split(', ', $_[3]);
                    my $delim = shift @list;
                    return "$delim.join(@list)";
                }
            }
	],
	[#Rule 102
		 'myattrterm', 3,
sub
#line 723 "plpy.yp"
{}
	],
	[#Rule 103
		 'myattrterm', 2,
sub
#line 725 "plpy.yp"
{}
	],
	[#Rule 104
		 'myterm', 3,
sub
#line 730 "plpy.yp"
{}
	],
	[#Rule 105
		 'myterm', 2,
sub
#line 732 "plpy.yp"
{}
	],
	[#Rule 106
		 'myterm', 1,
sub
#line 734 "plpy.yp"
{}
	],
	[#Rule 107
		 'myterm', 1,
sub
#line 736 "plpy.yp"
{}
	],
	[#Rule 108
		 'myterm', 1,
sub
#line 738 "plpy.yp"
{}
	],
	[#Rule 109
		 'listexpr', 0,
sub
#line 744 "plpy.yp"
{print "empty listexpr\n";}
	],
	[#Rule 110
		 'listexpr', 1,
sub
#line 746 "plpy.yp"
{
                printer (\@_, "listexpr", "argexpr");
                return $_[1];
            }
	],
	[#Rule 111
		 'listexprcom', 0, undef
	],
	[#Rule 112
		 'listexprcom', 1,
sub
#line 755 "plpy.yp"
{
                printer (\@_, "listexprcom", "expr");
                return "$_[1]";
            }
	],
	[#Rule 113
		 'listexprcom', 2,
sub
#line 760 "plpy.yp"
{
                printer (\@_, "listexprcom", "expr", "','");
                return "$_[1], ";
            }
	],
	[#Rule 114
		 'my_scalar', 1,
sub
#line 769 "plpy.yp"
{}
	],
	[#Rule 115
		 'amper', 2,
sub
#line 773 "plpy.yp"
{}
	],
	[#Rule 116
		 'scalar', 2,
sub
#line 777 "plpy.yp"
{
                printer (\@_, "scalar", "'\$'", "indirob"); 
                return "$_[2]";
            }
	],
	[#Rule 117
		 'ary', 2,
sub
#line 784 "plpy.yp"
{
                printer (\@_, "scalar", "'\@'", "indirob"); 
                return $_[2];
            }
	],
	[#Rule 118
		 'hsh', 2,
sub
#line 791 "plpy.yp"
{}
	],
	[#Rule 119
		 'arylen', 2,
sub
#line 795 "plpy.yp"
{}
	],
	[#Rule 120
		 'indirob', 1,
sub
#line 800 "plpy.yp"
{
                printer (\@_, "indirob", "WORD");
                return $_[1];
            }
	],
	[#Rule 121
		 'indirob', 1,
sub
#line 805 "plpy.yp"
{}
	],
	[#Rule 122
		 'indirob', 1,
sub
#line 807 "plpy.yp"
{}
	]
],
                                  @_);
    bless($self,$class);
}

#line 810 "plpy.yp"


1;
