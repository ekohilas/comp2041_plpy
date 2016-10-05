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
			"+" => 35,
			'FOR' => 34,
			"~" => 8,
			'COMMENT' => 11,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			'IF' => 18,
			"\$" => 17,
			'LOOPEX' => 43,
			'WHILE' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'SUB' => 26,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		DEFAULT => -1,
		GOTOS => {
			'scalar' => 6,
			'subrout' => 32,
			'sideff' => 33,
			'term' => 39,
			'loop' => 14,
			'ary' => 13,
			'expr' => 41,
			'decl' => 16,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21,
			'line' => 22,
			'cond' => 25,
			'arylen' => 45,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'argexpr' => 49
		}
	},
	{#State 3
		DEFAULT => 0
	},
	{#State 4
		DEFAULT => -96
	},
	{#State 5
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 50,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 6
		ACTIONS => {
			"[" => 51
		},
		DEFAULT => -74
	},
	{#State 7
		ACTIONS => {
			'WORD' => 53,
			"\$" => 17,
			"{" => 55
		},
		GOTOS => {
			'scalar' => 52,
			'indirob' => 54,
			'block' => 56
		}
	},
	{#State 8
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 57,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 9
		ACTIONS => {
			'WORD' => 53,
			"\$" => 17,
			"{" => 55
		},
		GOTOS => {
			'scalar' => 52,
			'indirob' => 58,
			'block' => 56
		}
	},
	{#State 10
		ACTIONS => {
			"(" => 62,
			"\@" => 7,
			"\$" => 17,
			"%" => 9
		},
		GOTOS => {
			'scalar' => 59,
			'myterm' => 63,
			'hsh' => 61,
			'ary' => 60
		}
	},
	{#State 11
		DEFAULT => -12
	},
	{#State 12
		ACTIONS => {
			"-" => 5,
			'WORD' => 64,
			"\@" => 7,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'LSTOP' => 12,
			"!" => 15,
			"\$" => 17,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			"(" => 30,
			'FUNC1' => 31,
			"+" => 35,
			'NOAMP' => 36,
			'DOLSHARP' => 37,
			'FUNC' => 38,
			'STRING' => 40,
			'STDINARR' => 42,
			'LOOPEX' => 43,
			"&" => 46,
			'UNIOP' => 47,
			"{" => 55,
			'STDIN' => 48
		},
		DEFAULT => -108,
		GOTOS => {
			'scalar' => 65,
			'arylen' => 45,
			'indirob' => 66,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'termbinop' => 19,
			'block' => 56,
			'argexpr' => 68,
			'listexpr' => 67,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 13
		ACTIONS => {
			"[" => 69,
			"{" => 70
		},
		DEFAULT => -76
	},
	{#State 14
		DEFAULT => -10
	},
	{#State 15
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 71,
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
			'WORD' => 53,
			"\$" => 17,
			"{" => 55
		},
		GOTOS => {
			'scalar' => 52,
			'indirob' => 72,
			'block' => 56
		}
	},
	{#State 18
		ACTIONS => {
			"(" => 73
		}
	},
	{#State 19
		DEFAULT => -66
	},
	{#State 20
		DEFAULT => -75
	},
	{#State 21
		DEFAULT => -67
	},
	{#State 22
		DEFAULT => -8
	},
	{#State 23
		ACTIONS => {
			"(" => 74
		}
	},
	{#State 24
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'termbinop' => 19,
			'argexpr' => 75,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 25
		DEFAULT => -9
	},
	{#State 26
		DEFAULT => -35,
		GOTOS => {
			'startsub' => 76
		}
	},
	{#State 27
		ACTIONS => {
			"(" => 77
		},
		DEFAULT => -83
	},
	{#State 28
		DEFAULT => -71
	},
	{#State 29
		DEFAULT => -78
	},
	{#State 30
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			")" => 79,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 78,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 31
		ACTIONS => {
			"(" => 80
		}
	},
	{#State 32
		DEFAULT => -33
	},
	{#State 33
		ACTIONS => {
			";" => 81
		}
	},
	{#State 34
		ACTIONS => {
			"(" => 84,
			"\$" => 17,
			'MY' => 83
		},
		GOTOS => {
			'scalar' => 82
		}
	},
	{#State 35
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 85,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 36
		ACTIONS => {
			'WORD' => 86
		}
	},
	{#State 37
		ACTIONS => {
			'WORD' => 53,
			"\$" => 17,
			"{" => 55
		},
		GOTOS => {
			'scalar' => 52,
			'indirob' => 87,
			'block' => 56
		}
	},
	{#State 38
		ACTIONS => {
			"(" => 88
		}
	},
	{#State 39
		ACTIONS => {
			'BITANDOP' => 89,
			'ADDOP' => 97,
			'ASSIGNOP' => 90,
			'POSTINC' => 98,
			'BITOROP' => 99,
			'POWOP' => 91,
			'MATCHOP' => 92,
			'POSTDEC' => 100,
			'DOTDOT' => 101,
			'MULOP' => 102,
			'BITXOROP' => 103,
			'SHIFTOP' => 93,
			'OROR' => 104,
			'ANDAND' => 94,
			'EQOP' => 95,
			'RELOP' => 96
		},
		DEFAULT => -44
	},
	{#State 40
		DEFAULT => -70
	},
	{#State 41
		ACTIONS => {
			'FOR' => 108,
			'OROP' => 107,
			'ANDOP' => 105,
			'IF' => 106,
			'WHILE' => 109
		},
		DEFAULT => -13
	},
	{#State 42
		DEFAULT => -69
	},
	{#State 43
		DEFAULT => -87
	},
	{#State 44
		ACTIONS => {
			"(" => 110
		}
	},
	{#State 45
		DEFAULT => -77
	},
	{#State 46
		ACTIONS => {
			'WORD' => 53,
			"\$" => 17,
			"{" => 55
		},
		GOTOS => {
			'scalar' => 52,
			'indirob' => 111,
			'block' => 56
		}
	},
	{#State 47
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
			"(" => 30,
			'FUNC1' => 31,
			"+" => 35,
			'NOAMP' => 36,
			'DOLSHARP' => 37,
			'FUNC' => 38,
			'STRING' => 40,
			'STDINARR' => 42,
			'LOOPEX' => 43,
			"&" => 46,
			'UNIOP' => 47,
			"{" => 55,
			'STDIN' => 48
		},
		DEFAULT => -89,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 112,
			'ary' => 13,
			'termbinop' => 19,
			'block' => 113,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 48
		DEFAULT => -68
	},
	{#State 49
		ACTIONS => {
			"," => 114
		},
		DEFAULT => -41
	},
	{#State 50
		ACTIONS => {
			'POSTINC' => 98,
			'POWOP' => 91,
			'POSTDEC' => 100
		},
		DEFAULT => -60
	},
	{#State 51
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 115,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 52
		DEFAULT => -120
	},
	{#State 53
		DEFAULT => -119
	},
	{#State 54
		DEFAULT => -116
	},
	{#State 55
		DEFAULT => -3,
		GOTOS => {
			'remember' => 116
		}
	},
	{#State 56
		DEFAULT => -121
	},
	{#State 57
		ACTIONS => {
			'POSTINC' => 98,
			'POWOP' => 91,
			'POSTDEC' => 100
		},
		DEFAULT => -63
	},
	{#State 58
		DEFAULT => -117
	},
	{#State 59
		DEFAULT => -105
	},
	{#State 60
		DEFAULT => -107
	},
	{#State 61
		DEFAULT => -106
	},
	{#State 62
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			")" => 118,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 117,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 63
		ACTIONS => {
			'myattrlist' => 119
		},
		DEFAULT => -102
	},
	{#State 64
		ACTIONS => {
			"-" => -119,
			'WORD' => -119,
			"\@" => -119,
			"~" => -119,
			"%" => -119,
			'MY' => -119,
			'LSTOP' => -119,
			"!" => -119,
			"\$" => -119,
			'PMFUNC' => -119,
			'NOTOP' => -119,
			"(" => -119,
			'FUNC1' => -119,
			"+" => -119,
			'NOAMP' => -119,
			'DOLSHARP' => -119,
			'STRING' => -119,
			'FUNC' => -119,
			'STDINARR' => -119,
			'LOOPEX' => -119,
			'UNIOP' => -119,
			"&" => -119,
			'STDIN' => -119
		},
		DEFAULT => -96
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
			"[" => 51,
			'PMFUNC' => -120,
			'NOTOP' => -120,
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
		DEFAULT => -74
	},
	{#State 66
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'termbinop' => 19,
			'argexpr' => 120,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 67
		DEFAULT => -99
	},
	{#State 68
		ACTIONS => {
			"," => 114
		},
		DEFAULT => -109
	},
	{#State 69
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 121,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 70
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 122,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 71
		ACTIONS => {
			'POSTINC' => 98,
			'POWOP' => 91,
			'POSTDEC' => 100
		},
		DEFAULT => -62
	},
	{#State 72
		DEFAULT => -115
	},
	{#State 73
		DEFAULT => -3,
		GOTOS => {
			'remember' => 123
		}
	},
	{#State 74
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 124,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 75
		ACTIONS => {
			"," => 114
		},
		DEFAULT => -88
	},
	{#State 76
		ACTIONS => {
			'WORD' => 125
		},
		GOTOS => {
			'subname' => 126
		}
	},
	{#State 77
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			")" => 128,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 127,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 78
		ACTIONS => {
			'OROP' => 107,
			")" => 129,
			'ANDOP' => 105
		}
	},
	{#State 79
		ACTIONS => {
			"[" => 130
		},
		DEFAULT => -73
	},
	{#State 80
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			")" => 132,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 131,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 81
		DEFAULT => -11
	},
	{#State 82
		ACTIONS => {
			"(" => 133
		}
	},
	{#State 83
		DEFAULT => -3,
		GOTOS => {
			'remember' => 134
		}
	},
	{#State 84
		DEFAULT => -3,
		GOTOS => {
			'remember' => 135
		}
	},
	{#State 85
		ACTIONS => {
			'POSTINC' => 98,
			'POWOP' => 91,
			'POSTDEC' => 100
		},
		DEFAULT => -61
	},
	{#State 86
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
			"(" => 30,
			'FUNC1' => 31,
			"+" => 35,
			'NOAMP' => 36,
			'DOLSHARP' => 37,
			'FUNC' => 38,
			'STRING' => 40,
			'STDINARR' => 42,
			'LOOPEX' => 43,
			"&" => 46,
			'UNIOP' => 47,
			'STDIN' => 48
		},
		DEFAULT => -108,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'termbinop' => 19,
			'argexpr' => 68,
			'listexpr' => 136,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 87
		DEFAULT => -118
	},
	{#State 88
		ACTIONS => {
			"-" => 5,
			'WORD' => 64,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			"{" => 55,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		DEFAULT => -110,
		GOTOS => {
			'scalar' => 65,
			'arylen' => 45,
			'indirob' => 137,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 139,
			'termbinop' => 19,
			'listexprcom' => 138,
			'block' => 56,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 89
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 140,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 90
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
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
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
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
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
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
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
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
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
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
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
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
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
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
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 148,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 98
		DEFAULT => -64
	},
	{#State 99
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 149,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 100
		DEFAULT => -65
	},
	{#State 101
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 150,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 102
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
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
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
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
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
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
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 154,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 106
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 155,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 107
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 156,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 108
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 157,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 109
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 158,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 110
		DEFAULT => -3,
		GOTOS => {
			'remember' => 159
		}
	},
	{#State 111
		DEFAULT => -114
	},
	{#State 112
		ACTIONS => {
			'ADDOP' => 97,
			'POSTINC' => 98,
			'POWOP' => 91,
			'MATCHOP' => 92,
			'POSTDEC' => 100,
			'MULOP' => 102,
			'SHIFTOP' => 93
		},
		DEFAULT => -91
	},
	{#State 113
		DEFAULT => -90
	},
	{#State 114
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
			"(" => 30,
			'FUNC1' => 31,
			"+" => 35,
			'NOAMP' => 36,
			'DOLSHARP' => 37,
			'FUNC' => 38,
			'STRING' => 40,
			'STDINARR' => 42,
			'LOOPEX' => 43,
			"&" => 46,
			'UNIOP' => 47,
			'STDIN' => 48
		},
		DEFAULT => -42,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 160,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 115
		ACTIONS => {
			'OROP' => 107,
			"]" => 161,
			'ANDOP' => 105
		}
	},
	{#State 116
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 162
		}
	},
	{#State 117
		ACTIONS => {
			'OROP' => 107,
			")" => 163,
			'ANDOP' => 105
		}
	},
	{#State 118
		DEFAULT => -104
	},
	{#State 119
		DEFAULT => -101
	},
	{#State 120
		ACTIONS => {
			"," => 114
		},
		DEFAULT => -97
	},
	{#State 121
		ACTIONS => {
			'OROP' => 107,
			"]" => 164,
			'ANDOP' => 105
		}
	},
	{#State 122
		ACTIONS => {
			";" => 165,
			'OROP' => 107,
			'ANDOP' => 105
		}
	},
	{#State 123
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 166,
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 167,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 124
		ACTIONS => {
			'BITANDOP' => 89,
			'ADDOP' => 97,
			"," => 168,
			'ASSIGNOP' => 90,
			'POSTINC' => 98,
			")" => 169,
			'BITOROP' => 99,
			'POWOP' => 91,
			'MATCHOP' => 92,
			'POSTDEC' => 100,
			'DOTDOT' => 101,
			'MULOP' => 102,
			'BITXOROP' => 103,
			'SHIFTOP' => 93,
			'OROR' => 104,
			'ANDAND' => 94,
			'RELOP' => 96,
			'EQOP' => 95
		}
	},
	{#State 125
		DEFAULT => -36
	},
	{#State 126
		ACTIONS => {
			";" => 171,
			"{" => 55
		},
		GOTOS => {
			'block' => 172,
			'subbody' => 170
		}
	},
	{#State 127
		ACTIONS => {
			'OROP' => 107,
			")" => 173,
			'ANDOP' => 105
		}
	},
	{#State 128
		DEFAULT => -84
	},
	{#State 129
		ACTIONS => {
			"[" => 174
		},
		DEFAULT => -72
	},
	{#State 130
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 175,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 131
		ACTIONS => {
			'OROP' => 107,
			")" => 176,
			'ANDOP' => 105
		}
	},
	{#State 132
		DEFAULT => -92
	},
	{#State 133
		DEFAULT => -3,
		GOTOS => {
			'remember' => 177
		}
	},
	{#State 134
		ACTIONS => {
			"\$" => 17
		},
		GOTOS => {
			'scalar' => 178,
			'my_scalar' => 179
		}
	},
	{#State 135
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		DEFAULT => -26,
		GOTOS => {
			'mexpr' => 180,
			'scalar' => 6,
			'sideff' => 182,
			'term' => 39,
			'ary' => 13,
			'expr' => 183,
			'nexpr' => 184,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21,
			'arylen' => 45,
			'mnexpr' => 181,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'argexpr' => 49
		}
	},
	{#State 136
		DEFAULT => -86
	},
	{#State 137
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 185,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 138
		ACTIONS => {
			")" => 186
		}
	},
	{#State 139
		ACTIONS => {
			'OROP' => 107,
			"," => 187,
			'ANDOP' => 105
		},
		DEFAULT => -111
	},
	{#State 140
		ACTIONS => {
			'ADDOP' => 97,
			'POSTINC' => 98,
			'POWOP' => 91,
			'MATCHOP' => 92,
			'POSTDEC' => 100,
			'MULOP' => 102,
			'SHIFTOP' => 93,
			'EQOP' => 95,
			'RELOP' => 96
		},
		DEFAULT => -53
	},
	{#State 141
		ACTIONS => {
			'BITANDOP' => 89,
			'ADDOP' => 97,
			'ASSIGNOP' => 90,
			'POSTINC' => 98,
			'BITOROP' => 99,
			'POWOP' => 91,
			'MATCHOP' => 92,
			'POSTDEC' => 100,
			'DOTDOT' => 101,
			'MULOP' => 102,
			'BITXOROP' => 103,
			'SHIFTOP' => 93,
			'OROR' => 104,
			'ANDAND' => 94,
			'EQOP' => 95,
			'RELOP' => 96
		},
		DEFAULT => -46
	},
	{#State 142
		ACTIONS => {
			'POSTINC' => 98,
			'POWOP' => 91,
			'POSTDEC' => 100
		},
		DEFAULT => -47
	},
	{#State 143
		ACTIONS => {
			'POSTINC' => 98,
			'POWOP' => 91,
			'POSTDEC' => 100
		},
		DEFAULT => -59
	},
	{#State 144
		ACTIONS => {
			'ADDOP' => 97,
			'POSTINC' => 98,
			'POWOP' => 91,
			'MATCHOP' => 92,
			'POSTDEC' => 100,
			'MULOP' => 102
		},
		DEFAULT => -50
	},
	{#State 145
		ACTIONS => {
			'BITANDOP' => 89,
			'ADDOP' => 97,
			'POSTINC' => 98,
			'BITOROP' => 99,
			'POWOP' => 91,
			'MATCHOP' => 92,
			'POSTDEC' => 100,
			'MULOP' => 102,
			'BITXOROP' => 103,
			'SHIFTOP' => 93,
			'EQOP' => 95,
			'RELOP' => 96
		},
		DEFAULT => -57
	},
	{#State 146
		ACTIONS => {
			'ADDOP' => 97,
			'POSTINC' => 98,
			'POWOP' => 91,
			'MATCHOP' => 92,
			'POSTDEC' => 100,
			'MULOP' => 102,
			'SHIFTOP' => 93,
			'EQOP' => undef,
			'RELOP' => 96
		},
		DEFAULT => -52
	},
	{#State 147
		ACTIONS => {
			'ADDOP' => 97,
			'POSTINC' => 98,
			'POWOP' => 91,
			'MATCHOP' => 92,
			'POSTDEC' => 100,
			'MULOP' => 102,
			'SHIFTOP' => 93,
			'RELOP' => undef
		},
		DEFAULT => -51
	},
	{#State 148
		ACTIONS => {
			'POSTINC' => 98,
			'POWOP' => 91,
			'MATCHOP' => 92,
			'POSTDEC' => 100,
			'MULOP' => 102
		},
		DEFAULT => -49
	},
	{#State 149
		ACTIONS => {
			'BITANDOP' => 89,
			'ADDOP' => 97,
			'POSTINC' => 98,
			'POWOP' => 91,
			'MATCHOP' => 92,
			'POSTDEC' => 100,
			'MULOP' => 102,
			'SHIFTOP' => 93,
			'EQOP' => 95,
			'RELOP' => 96
		},
		DEFAULT => -54
	},
	{#State 150
		ACTIONS => {
			'BITANDOP' => 89,
			'ADDOP' => 97,
			'POSTINC' => 98,
			'BITOROP' => 99,
			'POWOP' => 91,
			'MATCHOP' => 92,
			'POSTDEC' => 100,
			'DOTDOT' => undef,
			'MULOP' => 102,
			'BITXOROP' => 103,
			'SHIFTOP' => 93,
			'OROR' => 104,
			'ANDAND' => 94,
			'EQOP' => 95,
			'RELOP' => 96
		},
		DEFAULT => -56
	},
	{#State 151
		ACTIONS => {
			'POSTINC' => 98,
			'POWOP' => 91,
			'MATCHOP' => 92,
			'POSTDEC' => 100
		},
		DEFAULT => -48
	},
	{#State 152
		ACTIONS => {
			'BITANDOP' => 89,
			'ADDOP' => 97,
			'POSTINC' => 98,
			'POWOP' => 91,
			'MATCHOP' => 92,
			'POSTDEC' => 100,
			'MULOP' => 102,
			'SHIFTOP' => 93,
			'EQOP' => 95,
			'RELOP' => 96
		},
		DEFAULT => -55
	},
	{#State 153
		ACTIONS => {
			'BITANDOP' => 89,
			'ADDOP' => 97,
			'POSTINC' => 98,
			'BITOROP' => 99,
			'POWOP' => 91,
			'MATCHOP' => 92,
			'POSTDEC' => 100,
			'MULOP' => 102,
			'BITXOROP' => 103,
			'SHIFTOP' => 93,
			'ANDAND' => 94,
			'EQOP' => 95,
			'RELOP' => 96
		},
		DEFAULT => -58
	},
	{#State 154
		DEFAULT => -39
	},
	{#State 155
		ACTIONS => {
			'OROP' => 107,
			'ANDOP' => 105
		},
		DEFAULT => -14
	},
	{#State 156
		ACTIONS => {
			'ANDOP' => 105
		},
		DEFAULT => -40
	},
	{#State 157
		ACTIONS => {
			'OROP' => 107,
			'ANDOP' => 105
		},
		DEFAULT => -16
	},
	{#State 158
		ACTIONS => {
			'OROP' => 107,
			'ANDOP' => 105
		},
		DEFAULT => -15
	},
	{#State 159
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		DEFAULT => -28,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 190,
			'texpr' => 188,
			'termbinop' => 19,
			'mtexpr' => 189,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 160
		ACTIONS => {
			'BITANDOP' => 89,
			'ADDOP' => 97,
			'ASSIGNOP' => 90,
			'POSTINC' => 98,
			'BITOROP' => 99,
			'POWOP' => 91,
			'MATCHOP' => 92,
			'POSTDEC' => 100,
			'DOTDOT' => 101,
			'MULOP' => 102,
			'BITXOROP' => 103,
			'SHIFTOP' => 93,
			'OROR' => 104,
			'ANDAND' => 94,
			'EQOP' => 95,
			'RELOP' => 96
		},
		DEFAULT => -43
	},
	{#State 161
		DEFAULT => -45
	},
	{#State 162
		ACTIONS => {
			"}" => 191,
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			'FOR' => 34,
			"+" => 35,
			"~" => 8,
			'COMMENT' => 11,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			'IF' => 18,
			"\$" => 17,
			'LOOPEX' => 43,
			'WHILE' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'SUB' => 26,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 32,
			'sideff' => 33,
			'term' => 39,
			'loop' => 14,
			'ary' => 13,
			'expr' => 41,
			'decl' => 16,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21,
			'line' => 22,
			'cond' => 25,
			'arylen' => 45,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'argexpr' => 49
		}
	},
	{#State 163
		DEFAULT => -103
	},
	{#State 164
		DEFAULT => -81
	},
	{#State 165
		ACTIONS => {
			"}" => 192
		}
	},
	{#State 166
		ACTIONS => {
			")" => 193
		}
	},
	{#State 167
		ACTIONS => {
			'OROP' => 107,
			'ANDOP' => 105
		},
		DEFAULT => -30
	},
	{#State 168
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 194,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 169
		DEFAULT => -94
	},
	{#State 170
		DEFAULT => -34
	},
	{#State 171
		DEFAULT => -38
	},
	{#State 172
		DEFAULT => -37
	},
	{#State 173
		DEFAULT => -85
	},
	{#State 174
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 195,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 175
		ACTIONS => {
			'OROP' => 107,
			"]" => 196,
			'ANDOP' => 105
		}
	},
	{#State 176
		DEFAULT => -93
	},
	{#State 177
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 197,
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 167,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 178
		DEFAULT => -113
	},
	{#State 179
		ACTIONS => {
			"(" => 198
		}
	},
	{#State 180
		ACTIONS => {
			")" => 199
		}
	},
	{#State 181
		ACTIONS => {
			";" => 200
		}
	},
	{#State 182
		DEFAULT => -27
	},
	{#State 183
		ACTIONS => {
			'FOR' => 108,
			'OROP' => 107,
			'ANDOP' => 105,
			'IF' => 106,
			")" => -30,
			'WHILE' => 109
		},
		DEFAULT => -13
	},
	{#State 184
		DEFAULT => -31
	},
	{#State 185
		ACTIONS => {
			'OROP' => 107,
			")" => 201,
			'ANDOP' => 105
		}
	},
	{#State 186
		DEFAULT => -100
	},
	{#State 187
		DEFAULT => -112
	},
	{#State 188
		DEFAULT => -32
	},
	{#State 189
		ACTIONS => {
			")" => 202
		}
	},
	{#State 190
		ACTIONS => {
			'OROP' => 107,
			'ANDOP' => 105
		},
		DEFAULT => -29
	},
	{#State 191
		DEFAULT => -2
	},
	{#State 192
		DEFAULT => -82
	},
	{#State 193
		ACTIONS => {
			"{" => 203
		},
		GOTOS => {
			'mblock' => 204
		}
	},
	{#State 194
		ACTIONS => {
			'BITANDOP' => 89,
			'ADDOP' => 97,
			'ASSIGNOP' => 90,
			'POSTINC' => 98,
			")" => 205,
			'BITOROP' => 99,
			'POWOP' => 91,
			'MATCHOP' => 92,
			'POSTDEC' => 100,
			'DOTDOT' => 101,
			'MULOP' => 102,
			'BITXOROP' => 103,
			'SHIFTOP' => 93,
			'OROR' => 104,
			'ANDAND' => 94,
			'RELOP' => 96,
			'EQOP' => 95
		}
	},
	{#State 195
		ACTIONS => {
			'OROP' => 107,
			"]" => 206,
			'ANDOP' => 105
		}
	},
	{#State 196
		DEFAULT => -80
	},
	{#State 197
		ACTIONS => {
			")" => 207
		}
	},
	{#State 198
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 208,
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 167,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 199
		ACTIONS => {
			"{" => 203
		},
		GOTOS => {
			'mblock' => 209
		}
	},
	{#State 200
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		DEFAULT => -28,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 190,
			'texpr' => 188,
			'termbinop' => 19,
			'mtexpr' => 210,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 201
		DEFAULT => -98
	},
	{#State 202
		ACTIONS => {
			"{" => 203
		},
		GOTOS => {
			'mblock' => 211
		}
	},
	{#State 203
		DEFAULT => -5,
		GOTOS => {
			'mremember' => 212
		}
	},
	{#State 204
		ACTIONS => {
			'ELSE' => 213,
			'ELSIF' => 215
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 214
		}
	},
	{#State 205
		DEFAULT => -95
	},
	{#State 206
		DEFAULT => -79
	},
	{#State 207
		ACTIONS => {
			"{" => 203
		},
		GOTOS => {
			'mblock' => 216
		}
	},
	{#State 208
		ACTIONS => {
			")" => 217
		}
	},
	{#State 209
		DEFAULT => -24
	},
	{#State 210
		ACTIONS => {
			";" => 218
		}
	},
	{#State 211
		DEFAULT => -21
	},
	{#State 212
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 219
		}
	},
	{#State 213
		ACTIONS => {
			"{" => 203
		},
		GOTOS => {
			'mblock' => 220
		}
	},
	{#State 214
		DEFAULT => -20
	},
	{#State 215
		ACTIONS => {
			"(" => 221
		}
	},
	{#State 216
		DEFAULT => -23
	},
	{#State 217
		ACTIONS => {
			"{" => 203
		},
		GOTOS => {
			'mblock' => 222
		}
	},
	{#State 218
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		DEFAULT => -26,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'sideff' => 182,
			'mnexpr' => 223,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 41,
			'nexpr' => 184,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 219
		ACTIONS => {
			"}" => 224,
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			'FOR' => 34,
			"+" => 35,
			"~" => 8,
			'COMMENT' => 11,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			'IF' => 18,
			"\$" => 17,
			'LOOPEX' => 43,
			'WHILE' => 44,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'SUB' => 26,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 32,
			'sideff' => 33,
			'term' => 39,
			'loop' => 14,
			'ary' => 13,
			'expr' => 41,
			'decl' => 16,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21,
			'line' => 22,
			'cond' => 25,
			'arylen' => 45,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'argexpr' => 49
		}
	},
	{#State 220
		DEFAULT => -18
	},
	{#State 221
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			"~" => 8,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'STDINARR' => 42,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 30,
			'STDIN' => 48,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 225,
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 167,
			'termbinop' => 19,
			'argexpr' => 49,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 222
		DEFAULT => -22
	},
	{#State 223
		ACTIONS => {
			")" => 226
		}
	},
	{#State 224
		DEFAULT => -4
	},
	{#State 225
		ACTIONS => {
			")" => 227
		}
	},
	{#State 226
		ACTIONS => {
			"{" => 203
		},
		GOTOS => {
			'mblock' => 228
		}
	},
	{#State 227
		ACTIONS => {
			"{" => 203
		},
		GOTOS => {
			'mblock' => 229
		}
	},
	{#State 228
		DEFAULT => -25
	},
	{#State 229
		ACTIONS => {
			'ELSE' => 213,
			'ELSIF' => 215
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 230
		}
	},
	{#State 230
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
#line 207 "plpy.yp"
{
                printer(\@_, "prog", "lineseq");
                return "$_[1]";
            }
	],
	[#Rule 2
		 'block', 4,
sub
#line 215 "plpy.yp"
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
#line 227 "plpy.yp"
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
#line 241 "plpy.yp"
{
                printer(\@_, qw( lineseq lineseq decl )); 
                return "$_[1]$_[2]";
            }
	],
	[#Rule 8
		 'lineseq', 2,
sub
#line 246 "plpy.yp"
{
                printer(\@_, "lineseq", "lineseq", "line");
                return "$_[1]$_[2]";
            }
	],
	[#Rule 9
		 'line', 1,
sub
#line 254 "plpy.yp"
{
                printer(\@_, qw( line cond )); 
                return $_[1];
            }
	],
	[#Rule 10
		 'line', 1,
sub
#line 260 "plpy.yp"
{
                printer(\@_, qw( line loop )); 
                return $_[1];
            }
	],
	[#Rule 11
		 'line', 2,
sub
#line 266 "plpy.yp"
{
                printer(\@_, "line", "sideff", "';'");
                return "$_[1]\n";
            }
	],
	[#Rule 12
		 'line', 1,
sub
#line 271 "plpy.yp"
{
                printer(\@_, "line", "COMMENT");
                return "$_[1]\n";
            }
	],
	[#Rule 13
		 'sideff', 1,
sub
#line 280 "plpy.yp"
{
                printer(\@_, "sideff", "expr");
                return $_[1];
            }
	],
	[#Rule 14
		 'sideff', 3,
sub
#line 286 "plpy.yp"
{
                printer(\@_, qw( sideff expr IF expr ));
                return "if $_[3]: $_[1]";
            }
	],
	[#Rule 15
		 'sideff', 3,
sub
#line 291 "plpy.yp"
{
                printer(\@_, qw( sideff expr WHILE expr ));
                return "$_[1] while $_[3]";
            }
	],
	[#Rule 16
		 'sideff', 3,
sub
#line 296 "plpy.yp"
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
#line 305 "plpy.yp"
{
                printer (\@_, qw( else ELSE mblock ));
                return "else:$_[2]";
            }
	],
	[#Rule 19
		 'else', 6,
sub
#line 310 "plpy.yp"
{
                printer (\@_, qw( else ELSIF '(' mexpr ')' mblock else)); 
                return "elif $_[3]:$_[5]$_[6]";
            }
	],
	[#Rule 20
		 'cond', 7,
sub
#line 318 "plpy.yp"
{
                printer (\@_, qw( IF '(' remember mexpr ')' mblock else));
                return "if $_[4]:$_[6]$_[7]";
                
            }
	],
	[#Rule 21
		 'loop', 6,
sub
#line 327 "plpy.yp"
{
                 printer (\@_, qw(WHILE '(' remember mtexpr ')' mblock cont)); 
                 return "while $_[4]:$_[6]$_[7]";
            }
	],
	[#Rule 22
		 'loop', 8,
sub
#line 332 "plpy.yp"
{
                printer (\@_, qw(loop FOR MY remember my_scalar '(' mexpr ')' mblock cont)); 
                return "for $_[4] in $_[6]:$_[8]";
            }
	],
	[#Rule 23
		 'loop', 7,
sub
#line 337 "plpy.yp"
{
                printer (\@_, qw(loop FOR scalar '(' mexpr ')' mblock cont)); 
                return "for $_[2] in $_[5]:$_[7]";
            }
	],
	[#Rule 24
		 'loop', 6,
sub
#line 342 "plpy.yp"
{}
	],
	[#Rule 25
		 'loop', 10,
sub
#line 344 "plpy.yp"
{
                printer (\@_, qw(loop FOR '(' remember mnexpr ';' mtexpr ';' mnexpr ')' mblock)); 
                return "$_[4]\nwhile $_[6]:$_[10] hi   $_[8]\n";
            }
	],
	[#Rule 26
		 'nexpr', 0,
sub
#line 352 "plpy.yp"
{}
	],
	[#Rule 27
		 'nexpr', 1, undef
	],
	[#Rule 28
		 'texpr', 0,
sub
#line 358 "plpy.yp"
{}
	],
	[#Rule 29
		 'texpr', 1, undef
	],
	[#Rule 30
		 'mexpr', 1,
sub
#line 364 "plpy.yp"
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
#line 378 "plpy.yp"
{}
	],
	[#Rule 34
		 'subrout', 4,
sub
#line 383 "plpy.yp"
{}
	],
	[#Rule 35
		 'startsub', 0,
sub
#line 387 "plpy.yp"
{}
	],
	[#Rule 36
		 'subname', 1,
sub
#line 391 "plpy.yp"
{}
	],
	[#Rule 37
		 'subbody', 1,
sub
#line 395 "plpy.yp"
{}
	],
	[#Rule 38
		 'subbody', 1,
sub
#line 396 "plpy.yp"
{}
	],
	[#Rule 39
		 'expr', 3,
sub
#line 402 "plpy.yp"
{
                printer (\@_, qw(expr expr ANDOP expr)); 
                return "$_[1] and $_[3]";
            }
	],
	[#Rule 40
		 'expr', 3,
sub
#line 407 "plpy.yp"
{
                printer (\@_, qw(expr expr OROP expr)); 
                return "$_[1] or $_[3]";
            }
	],
	[#Rule 41
		 'expr', 1, undef
	],
	[#Rule 42
		 'argexpr', 2,
sub
#line 416 "plpy.yp"
{
                printer (\@_, "argexpr", "','");
                return "$_[1], ";
            }
	],
	[#Rule 43
		 'argexpr', 3,
sub
#line 421 "plpy.yp"
{
                printer (\@_, "argexpr", "','", "term");
                return "$_[1], $_[3]";
            }
	],
	[#Rule 44
		 'argexpr', 1,
sub
#line 426 "plpy.yp"
{
                printer (\@_, "argexpr", "term");
                return $_[1];
            }
	],
	[#Rule 45
		 'subscripted', 4,
sub
#line 436 "plpy.yp"
{}
	],
	[#Rule 46
		 'termbinop', 3,
sub
#line 441 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "ASSIGNOP", "term");
                if ($_[2] eq '.=') {$_[2] = '+='}
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 47
		 'termbinop', 3,
sub
#line 447 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "POWOP", "term");
                return "int($_[1]) $_[2] int($_[3])";
            }
	],
	[#Rule 48
		 'termbinop', 3,
sub
#line 452 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "MULOP", "term");
                return "int($_[1]) $_[2] int($_[3])";
            }
	],
	[#Rule 49
		 'termbinop', 3,
sub
#line 457 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "ADDOP", "term");
                return "int($_[1]) $_[2] int($_[3])";
            }
	],
	[#Rule 50
		 'termbinop', 3,
sub
#line 462 "plpy.yp"
{
                printer (\@_, qw(term SHIFTOP term)); 
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 51
		 'termbinop', 3,
sub
#line 467 "plpy.yp"
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
#line 479 "plpy.yp"
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
#line 488 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITANDOP term)); 
                return "$_[1] & $_[2]";
            }
	],
	[#Rule 54
		 'termbinop', 3,
sub
#line 493 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITOROP term)); 
                return "$_[1] | $_[2]";
            }
	],
	[#Rule 55
		 'termbinop', 3,
sub
#line 498 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITXOROP term)); 
                return "$_[1] ^ $_[2]";
            }
	],
	[#Rule 56
		 'termbinop', 3,
sub
#line 503 "plpy.yp"
{
                return "list(range($_[1], $_[3]))";
            }
	],
	[#Rule 57
		 'termbinop', 3,
sub
#line 507 "plpy.yp"
{
                printer (\@_, qw(termbinop term ANDAND term)); 
                return "$_[1] and $_[3]";
            }
	],
	[#Rule 58
		 'termbinop', 3,
sub
#line 512 "plpy.yp"
{
                printer (\@_, qw(termbinop term OROR term)); 
                return "$_[1] or $_[3]";
            }
	],
	[#Rule 59
		 'termbinop', 3,
sub
#line 517 "plpy.yp"
{}
	],
	[#Rule 60
		 'termunop', 2,
sub
#line 522 "plpy.yp"
{}
	],
	[#Rule 61
		 'termunop', 2,
sub
#line 524 "plpy.yp"
{}
	],
	[#Rule 62
		 'termunop', 2,
sub
#line 526 "plpy.yp"
{
                printer (\@_, qw(termunop '!' term)); 
                return "not $_[2]";
            }
	],
	[#Rule 63
		 'termunop', 2,
sub
#line 531 "plpy.yp"
{
                printer (\@_, qw(termunop '~' term)); 
                return "~$_[2]";
            }
	],
	[#Rule 64
		 'termunop', 2,
sub
#line 536 "plpy.yp"
{
                printer (\@_, qw(termunop term POSTINC)); 
                return "$_[1] += 1";
            }
	],
	[#Rule 65
		 'termunop', 2,
sub
#line 541 "plpy.yp"
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
#line 550 "plpy.yp"
{
                $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                return "sys.stdin.readline()";
            }
	],
	[#Rule 69
		 'term', 1,
sub
#line 555 "plpy.yp"
{
                $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                return "sys.stdin.readlines()";
            }
	],
	[#Rule 70
		 'term', 1,
sub
#line 560 "plpy.yp"
{
                printer (\@_, "term", "STRING");
                $_[1] =~ s/^"\$(\w+)"/$1/;
                return $_[1];
            }
	],
	[#Rule 71
		 'term', 1,
sub
#line 567 "plpy.yp"
{}
	],
	[#Rule 72
		 'term', 3,
sub
#line 569 "plpy.yp"
{
                return $_[2];    
            }
	],
	[#Rule 73
		 'term', 2,
sub
#line 573 "plpy.yp"
{}
	],
	[#Rule 74
		 'term', 1,
sub
#line 575 "plpy.yp"
{
                printer (\@_, "term", "scalar");
                return $_[1];
            }
	],
	[#Rule 75
		 'term', 1,
sub
#line 580 "plpy.yp"
{}
	],
	[#Rule 76
		 'term', 1,
sub
#line 582 "plpy.yp"
{
                printer (\@_, qw(term ary)); 
                return $_[1];
            }
	],
	[#Rule 77
		 'term', 1,
sub
#line 587 "plpy.yp"
{}
	],
	[#Rule 78
		 'term', 1,
sub
#line 589 "plpy.yp"
{}
	],
	[#Rule 79
		 'term', 6,
sub
#line 591 "plpy.yp"
{}
	],
	[#Rule 80
		 'term', 5,
sub
#line 593 "plpy.yp"
{}
	],
	[#Rule 81
		 'term', 4,
sub
#line 595 "plpy.yp"
{}
	],
	[#Rule 82
		 'term', 5,
sub
#line 597 "plpy.yp"
{}
	],
	[#Rule 83
		 'term', 1,
sub
#line 599 "plpy.yp"
{}
	],
	[#Rule 84
		 'term', 3,
sub
#line 601 "plpy.yp"
{}
	],
	[#Rule 85
		 'term', 4,
sub
#line 603 "plpy.yp"
{}
	],
	[#Rule 86
		 'term', 3,
sub
#line 605 "plpy.yp"
{
                printer (\@_, qw(term NOAMP WORD listexpr)); 
            }
	],
	[#Rule 87
		 'term', 1,
sub
#line 609 "plpy.yp"
{
                if ($_[1] eq "last"){
                    return "break";
                }
                elsif ($_[1] eq "next"){
                    return "continue";
                }

            }
	],
	[#Rule 88
		 'term', 2,
sub
#line 619 "plpy.yp"
{
                printer (\@_, qw(term NOTOP argexpr)); 
                return "not $_[2]";
            }
	],
	[#Rule 89
		 'term', 1,
sub
#line 624 "plpy.yp"
{}
	],
	[#Rule 90
		 'term', 2,
sub
#line 626 "plpy.yp"
{}
	],
	[#Rule 91
		 'term', 2,
sub
#line 628 "plpy.yp"
{
                if ($_[0] eq "chomp"){
                   return "$_[2].strip()" 
                }
            }
	],
	[#Rule 92
		 'term', 3,
sub
#line 634 "plpy.yp"
{}
	],
	[#Rule 93
		 'term', 4,
sub
#line 636 "plpy.yp"
{
                if ($_[0] eq "chomp"){
                   return "$_[2].strip()" 
                }
            }
	],
	[#Rule 94
		 'term', 4,
sub
#line 642 "plpy.yp"
{}
	],
	[#Rule 95
		 'term', 6,
sub
#line 644 "plpy.yp"
{
                $_[3] =~ s/\/(.*)\//$1/;
                $_[3] =~ s/\\([\{\}\[\]\(\)\^\$\.\|\*\+\?\\])/$1/g;
                return "split($_[3], $_[5])";
            }
	],
	[#Rule 96
		 'term', 1, undef
	],
	[#Rule 97
		 'term', 3,
sub
#line 653 "plpy.yp"
{
                printer (\@_, "term", "LSTOP", "indirob", "argexpr");
            }
	],
	[#Rule 98
		 'term', 5,
sub
#line 657 "plpy.yp"
{}
	],
	[#Rule 99
		 'term', 2,
sub
#line 659 "plpy.yp"
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
	[#Rule 100
		 'term', 4,
sub
#line 692 "plpy.yp"
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
	[#Rule 101
		 'myattrterm', 3,
sub
#line 705 "plpy.yp"
{}
	],
	[#Rule 102
		 'myattrterm', 2,
sub
#line 707 "plpy.yp"
{}
	],
	[#Rule 103
		 'myterm', 3,
sub
#line 712 "plpy.yp"
{}
	],
	[#Rule 104
		 'myterm', 2,
sub
#line 714 "plpy.yp"
{}
	],
	[#Rule 105
		 'myterm', 1,
sub
#line 716 "plpy.yp"
{}
	],
	[#Rule 106
		 'myterm', 1,
sub
#line 718 "plpy.yp"
{}
	],
	[#Rule 107
		 'myterm', 1,
sub
#line 720 "plpy.yp"
{}
	],
	[#Rule 108
		 'listexpr', 0,
sub
#line 726 "plpy.yp"
{print "empty listexpr\n";}
	],
	[#Rule 109
		 'listexpr', 1,
sub
#line 728 "plpy.yp"
{
                printer (\@_, "listexpr", "argexpr");
                return $_[1];
            }
	],
	[#Rule 110
		 'listexprcom', 0, undef
	],
	[#Rule 111
		 'listexprcom', 1,
sub
#line 737 "plpy.yp"
{
                printer (\@_, "listexprcom", "expr");
                return "$_[1]";
            }
	],
	[#Rule 112
		 'listexprcom', 2,
sub
#line 742 "plpy.yp"
{
                printer (\@_, "listexprcom", "expr", "','");
                return "$_[1], ";
            }
	],
	[#Rule 113
		 'my_scalar', 1,
sub
#line 751 "plpy.yp"
{}
	],
	[#Rule 114
		 'amper', 2,
sub
#line 755 "plpy.yp"
{}
	],
	[#Rule 115
		 'scalar', 2,
sub
#line 759 "plpy.yp"
{
                printer (\@_, "scalar", "'\$'", "indirob"); 
                return "$_[2]";
            }
	],
	[#Rule 116
		 'ary', 2,
sub
#line 766 "plpy.yp"
{
                printer (\@_, "scalar", "'\@'", "indirob"); 
                return $_[2];
            }
	],
	[#Rule 117
		 'hsh', 2,
sub
#line 773 "plpy.yp"
{}
	],
	[#Rule 118
		 'arylen', 2,
sub
#line 777 "plpy.yp"
{}
	],
	[#Rule 119
		 'indirob', 1,
sub
#line 782 "plpy.yp"
{
                printer (\@_, "indirob", "WORD");
                return $_[1];
            }
	],
	[#Rule 120
		 'indirob', 1,
sub
#line 787 "plpy.yp"
{}
	],
	[#Rule 121
		 'indirob', 1,
sub
#line 789 "plpy.yp"
{}
	]
],
                                  @_);
    bless($self,$class);
}

#line 792 "plpy.yp"


1;
