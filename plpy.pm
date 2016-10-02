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

sub getToken {
    my @tokens = (
        ["STRING", qr/"(?!\\"|").*"/],
        ["PMFUNC", qr/split/],
        ["FUNC", qr/print|printf|chomp|split|join|push|unshift|open/],
        ["FUNC0", qr/print|printf|chomp|split|exit|pop|shift/],
        ["FUNC1", qr/print|printf|chomp|split|exit|pop|shift|reverse|open|sort|keys/],
        ["UNIOP", qr/exit|return|scalar|chomp|close|keys|pop|shift|values/],
        ["LSTOP", qr/print|chomp|join|push|pop|shift|scalar|unshift|reverse|open|sort|keys/],
        ["FOR", qr/for|foreach/],
        ["WHILE", qr/while/],
        ["ELSIF", qr/elsif/],
        ["ELSE", qr/else/],
        ["CONTINUE", qr/next/],
        ["LOOPEX", qr/last/],
        ["ANDOP", qr/and/],
        ["NOTOP", qr/not/],
        ["SUB", qr/sub/],
        ["IF", qr/if/],
        ["MY", qr/my/],
        ["OROP", qr/or/],
        ["DOTDOT", qr/\.\.\.?/],
        ["EQOP", qr/==|!=|eq/],
        ["ANDAND", qr/&&/],
        ["MATCHOP", qr/=~/],
        ["POWOP", qr/\*\*/],
        ["POSTINC", qr/\+\+/],
        ["POSTDEC", qr/--/],
        ["DOLSHARP", qr/\$#/],
        ["ASSIGNOP", qr/=|\.=/],
        ["ADDOP", qr/[+-.]/],
        ["RELOP", qr/>|<|<=|>=|lt|gt|le|ge/],
        ["MULOP", qr/[\/%*]/],
        ["OROR", qr/\|\|/],
        [",", qr/,/],
        ["!", qr/!/],
        [")", qr/\)/],
        ["(", qr/\(/],
        ["{", qr/\{/],
        ["}", qr/\}/],
        [";", qr/;/],
        ["[", qr/\[/],
        ["]", qr/\]/],
        ["&", qr/&/],
        ["@", qr/@/],
        ["%", qr/%/],
        ["\$", qr/\$/],
        ["WORD", qr/\w+/a]
    );

    $_[0]->YYData->{"DATA"} =~ s/^\s+//;
    print $_[0]->YYData->{"DATA"}, "\n" ;
    my @length;
    #foreach my $item (@tokens){
    #   my ($a, $b) = @$item;
    #   print "$a, $b\n";
#}
    my $found = 0;
    for (my $i; $i < scalar @tokens; $i++){
        my $token = $tokens[$i][0];
        my $re = $tokens[$i][1];
        $length[$i] = 0;
        if ($_[0]->YYData->{"DATA"} =~ /^${re}/){
            $found = 1;
            @length[$i] = length($&);
            print "Found match $token: ($&), $length[$i]\n";
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
#for (my $i=scalar @length -1; $i >= 0; $i--){
#   if ($length[$i] => $maxval){
#        $maxpos = $i;
#        $maxval = $length[$i];
#    }
#}
        #print "$tokens[$maxpos][0]\n";
        my $token = $tokens[$maxpos][0];
        my $re = $tokens[$maxpos][1];
        $_[0]->YYData->{"DATA"} =~ s/^${re}//;
        print "$token : $&\n";
        return ($token, $&);
    }
    elsif (!$found && !length($_[0]->YYData->{"DATA"})) {
        return ('', undef);
    }
    else {
        print "unable to parse\n";
        print $_[0]->YYData->{"DATA"}, "\n";
        return ('', undef);
    }
}
sub Lexer {
    my ($type, $value) = getToken($_[0]);
    print "removed token ($type, $value)\n";
    return ($type, $value);
    #return ('', undef);
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
			'' => -1,
			"-" => 5,
			'WORD' => 4,
			'PACKAGE' => 8,
			"\@" => 7,
			'MY' => 10,
			"%" => 9,
			'LSTOP' => 11,
			"!" => 14,
			'IF' => 17,
			"\$" => 16,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'SUB' => 25,
			"(" => 29,
			'FUNC1' => 30,
			'FOR' => 33,
			"+" => 34,
			'NOAMP' => 35,
			'DOLSHARP' => 36,
			'FUNC' => 38,
			'STRING' => 39,
			'LOOPEX' => 42,
			'error' => 43,
			'WHILE' => 45,
			'FUNC0' => 46,
			"&" => 48,
			'UNIOP' => 49,
			"{" => 50,
			'USE' => 52,
			'format' => 53
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 31,
			'sideff' => 32,
			'term' => 37,
			'loop' => 13,
			'ary' => 12,
			'use' => 41,
			'expr' => 40,
			'decl' => 15,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20,
			'line' => 21,
			'cond' => 24,
			'arylen' => 47,
			'amper' => 26,
			'myattrterm' => 27,
			'subscripted' => 28,
			'package' => 51,
			'block' => 54,
			'argexpr' => 55
		}
	},
	{#State 3
		DEFAULT => 0
	},
	{#State 4
		DEFAULT => -105
	},
	{#State 5
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 56,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 6
		ACTIONS => {
			"[" => 57
		},
		DEFAULT => -81
	},
	{#State 7
		ACTIONS => {
			'WORD' => 59,
			"\$" => 16,
			"{" => 50
		},
		GOTOS => {
			'scalar' => 58,
			'indirob' => 60,
			'block' => 61
		}
	},
	{#State 8
		ACTIONS => {
			'WORD' => 62,
			";" => 63
		}
	},
	{#State 9
		ACTIONS => {
			'WORD' => 59,
			"\$" => 16,
			"{" => 50
		},
		GOTOS => {
			'scalar' => 58,
			'indirob' => 64,
			'block' => 61
		}
	},
	{#State 10
		ACTIONS => {
			"(" => 68,
			"\@" => 7,
			"\$" => 16,
			"%" => 9
		},
		GOTOS => {
			'scalar' => 65,
			'myterm' => 69,
			'hsh' => 67,
			'ary' => 66
		}
	},
	{#State 11
		ACTIONS => {
			"-" => 5,
			'WORD' => 70,
			"\@" => 7,
			'MY' => 10,
			"%" => 9,
			'LSTOP' => 11,
			"!" => 14,
			"\$" => 16,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			"(" => 29,
			'FUNC1' => 30,
			"+" => 34,
			'NOAMP' => 35,
			'DOLSHARP' => 36,
			'STRING' => 39,
			'FUNC' => 38,
			'LOOPEX' => 42,
			'FUNC0' => 46,
			"&" => 48,
			'UNIOP' => 49,
			"{" => 50
		},
		DEFAULT => -114,
		GOTOS => {
			'scalar' => 71,
			'arylen' => 47,
			'indirob' => 72,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'termbinop' => 18,
			'block' => 61,
			'argexpr' => 74,
			'listop' => 44,
			'listexpr' => 73,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 12
		ACTIONS => {
			"[" => 75,
			"{" => 76
		},
		DEFAULT => -83
	},
	{#State 13
		DEFAULT => -10
	},
	{#State 14
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 77,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 15
		DEFAULT => -7
	},
	{#State 16
		ACTIONS => {
			'WORD' => 59,
			"\$" => 16,
			"{" => 50
		},
		GOTOS => {
			'scalar' => 58,
			'indirob' => 78,
			'block' => 61
		}
	},
	{#State 17
		ACTIONS => {
			"(" => 79
		}
	},
	{#State 18
		DEFAULT => -75
	},
	{#State 19
		DEFAULT => -82
	},
	{#State 20
		DEFAULT => -76
	},
	{#State 21
		DEFAULT => -8
	},
	{#State 22
		ACTIONS => {
			"(" => 80
		}
	},
	{#State 23
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 81,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 24
		DEFAULT => -9
	},
	{#State 25
		DEFAULT => -41,
		GOTOS => {
			'startsub' => 82
		}
	},
	{#State 26
		ACTIONS => {
			"(" => 83
		},
		DEFAULT => -90
	},
	{#State 27
		DEFAULT => -78
	},
	{#State 28
		DEFAULT => -85
	},
	{#State 29
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			")" => 85,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 84,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 30
		ACTIONS => {
			"(" => 86
		}
	},
	{#State 31
		DEFAULT => -37
	},
	{#State 32
		ACTIONS => {
			";" => 87
		}
	},
	{#State 33
		ACTIONS => {
			"(" => 90,
			"\$" => 16,
			'MY' => 89
		},
		GOTOS => {
			'scalar' => 88
		}
	},
	{#State 34
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 91,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 35
		ACTIONS => {
			'WORD' => 92
		}
	},
	{#State 36
		ACTIONS => {
			'WORD' => 59,
			"\$" => 16,
			"{" => 50
		},
		GOTOS => {
			'scalar' => 58,
			'indirob' => 93,
			'block' => 61
		}
	},
	{#State 37
		ACTIONS => {
			'ADDOP' => 100,
			'ASSIGNOP' => 94,
			'POSTINC' => 101,
			'POWOP' => 95,
			'MATCHOP' => 96,
			'POSTDEC' => 102,
			'DOTDOT' => 103,
			'MULOP' => 104,
			'ANDAND' => 97,
			'OROR' => 105,
			'RELOP' => 99,
			'EQOP' => 98
		},
		DEFAULT => -54
	},
	{#State 38
		ACTIONS => {
			"(" => 106
		}
	},
	{#State 39
		DEFAULT => -77
	},
	{#State 40
		ACTIONS => {
			'FOR' => 110,
			'OROP' => 109,
			'ANDOP' => 107,
			'IF' => 108,
			'WHILE' => 111
		},
		DEFAULT => -13
	},
	{#State 41
		DEFAULT => -39
	},
	{#State 42
		DEFAULT => -94
	},
	{#State 43
		DEFAULT => -12
	},
	{#State 44
		DEFAULT => -106
	},
	{#State 45
		ACTIONS => {
			"(" => 112
		}
	},
	{#State 46
		ACTIONS => {
			"(" => 113
		},
		DEFAULT => -99
	},
	{#State 47
		DEFAULT => -84
	},
	{#State 48
		ACTIONS => {
			'WORD' => 59,
			"\$" => 16,
			"{" => 50
		},
		GOTOS => {
			'scalar' => 58,
			'indirob' => 114,
			'block' => 61
		}
	},
	{#State 49
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			'MY' => 10,
			"%" => 9,
			'LSTOP' => 11,
			"!" => 14,
			"\$" => 16,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			"(" => 29,
			'FUNC1' => 30,
			"+" => 34,
			'NOAMP' => 35,
			'DOLSHARP' => 36,
			'STRING' => 39,
			'FUNC' => 38,
			'LOOPEX' => 42,
			'FUNC0' => 46,
			"&" => 48,
			'UNIOP' => 49,
			"{" => 50
		},
		DEFAULT => -96,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 115,
			'ary' => 12,
			'termbinop' => 18,
			'block' => 116,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 50
		DEFAULT => -3,
		GOTOS => {
			'remember' => 117
		}
	},
	{#State 51
		DEFAULT => -38
	},
	{#State 52
		DEFAULT => -41,
		GOTOS => {
			'startsub' => 118
		}
	},
	{#State 53
		DEFAULT => -36
	},
	{#State 54
		ACTIONS => {
			'CONTINUE' => 119
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 120
		}
	},
	{#State 55
		ACTIONS => {
			"," => 121
		},
		DEFAULT => -51
	},
	{#State 56
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 95,
			'POSTDEC' => 102
		},
		DEFAULT => -70
	},
	{#State 57
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 122,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 58
		DEFAULT => -126
	},
	{#State 59
		DEFAULT => -125
	},
	{#State 60
		DEFAULT => -122
	},
	{#State 61
		DEFAULT => -127
	},
	{#State 62
		ACTIONS => {
			";" => 123
		}
	},
	{#State 63
		DEFAULT => -46
	},
	{#State 64
		DEFAULT => -123
	},
	{#State 65
		DEFAULT => -111
	},
	{#State 66
		DEFAULT => -113
	},
	{#State 67
		DEFAULT => -112
	},
	{#State 68
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			")" => 125,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 124,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 69
		ACTIONS => {
			'myattrlist' => 126
		},
		DEFAULT => -108
	},
	{#State 70
		ACTIONS => {
			"-" => -125,
			'WORD' => -125,
			"\@" => -125,
			"%" => -125,
			'MY' => -125,
			'LSTOP' => -125,
			"!" => -125,
			"\$" => -125,
			'NOTOP' => -125,
			'PMFUNC' => -125,
			"(" => -125,
			'FUNC1' => -125,
			"+" => -125,
			'NOAMP' => -125,
			'STRING' => -125,
			'FUNC' => -125,
			'DOLSHARP' => -125,
			'LOOPEX' => -125,
			'FUNC0' => -125,
			"&" => -125,
			'UNIOP' => -125
		},
		DEFAULT => -105
	},
	{#State 71
		ACTIONS => {
			"-" => -126,
			'WORD' => -126,
			"\@" => -126,
			"%" => -126,
			'MY' => -126,
			'LSTOP' => -126,
			"!" => -126,
			"\$" => -126,
			"[" => 57,
			'NOTOP' => -126,
			'PMFUNC' => -126,
			"(" => -126,
			'FUNC1' => -126,
			"+" => -126,
			'NOAMP' => -126,
			'STRING' => -126,
			'FUNC' => -126,
			'DOLSHARP' => -126,
			'LOOPEX' => -126,
			'FUNC0' => -126,
			"&" => -126,
			'UNIOP' => -126
		},
		DEFAULT => -81
	},
	{#State 72
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 127,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 73
		DEFAULT => -57
	},
	{#State 74
		ACTIONS => {
			"," => 121
		},
		DEFAULT => -115
	},
	{#State 75
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 128,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 76
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 129,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 77
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 95,
			'POSTDEC' => 102
		},
		DEFAULT => -72
	},
	{#State 78
		DEFAULT => -121
	},
	{#State 79
		DEFAULT => -3,
		GOTOS => {
			'remember' => 130
		}
	},
	{#State 80
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 131,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 81
		ACTIONS => {
			"," => 121
		},
		DEFAULT => -95
	},
	{#State 82
		ACTIONS => {
			'WORD' => 132
		},
		GOTOS => {
			'subname' => 133
		}
	},
	{#State 83
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			")" => 135,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 134,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 84
		ACTIONS => {
			'OROP' => 109,
			")" => 136,
			'ANDOP' => 107
		}
	},
	{#State 85
		ACTIONS => {
			"[" => 137
		},
		DEFAULT => -80
	},
	{#State 86
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			")" => 139,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 138,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 87
		DEFAULT => -11
	},
	{#State 88
		ACTIONS => {
			"(" => 140
		}
	},
	{#State 89
		DEFAULT => -3,
		GOTOS => {
			'remember' => 141
		}
	},
	{#State 90
		DEFAULT => -3,
		GOTOS => {
			'remember' => 142
		}
	},
	{#State 91
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 95,
			'POSTDEC' => 102
		},
		DEFAULT => -71
	},
	{#State 92
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			'MY' => 10,
			"%" => 9,
			'LSTOP' => 11,
			"!" => 14,
			"\$" => 16,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			"(" => 29,
			'FUNC1' => 30,
			"+" => 34,
			'NOAMP' => 35,
			'DOLSHARP' => 36,
			'STRING' => 39,
			'FUNC' => 38,
			'LOOPEX' => 42,
			'FUNC0' => 46,
			"&" => 48,
			'UNIOP' => 49
		},
		DEFAULT => -114,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 74,
			'listop' => 44,
			'listexpr' => 143,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 93
		DEFAULT => -124
	},
	{#State 94
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 144,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 95
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 145,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 96
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 146,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 97
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 147,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 98
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 148,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 99
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 149,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 100
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 150,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 101
		DEFAULT => -73
	},
	{#State 102
		DEFAULT => -74
	},
	{#State 103
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 151,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 104
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 152,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 105
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 153,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 106
		ACTIONS => {
			"-" => 5,
			'WORD' => 70,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			"{" => 50,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		DEFAULT => -116,
		GOTOS => {
			'scalar' => 71,
			'indirob' => 154,
			'term' => 37,
			'ary' => 12,
			'expr' => 156,
			'termbinop' => 18,
			'listexprcom' => 155,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20,
			'arylen' => 47,
			'amper' => 26,
			'myattrterm' => 27,
			'subscripted' => 28,
			'block' => 61,
			'argexpr' => 55
		}
	},
	{#State 107
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 157,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 108
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 158,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 109
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 159,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 110
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 160,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 111
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 161,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 112
		DEFAULT => -3,
		GOTOS => {
			'remember' => 162
		}
	},
	{#State 113
		ACTIONS => {
			")" => 163
		}
	},
	{#State 114
		DEFAULT => -120
	},
	{#State 115
		ACTIONS => {
			'ADDOP' => 100,
			'POSTINC' => 101,
			'POWOP' => 95,
			'MATCHOP' => 96,
			'POSTDEC' => 102,
			'MULOP' => 104
		},
		DEFAULT => -98
	},
	{#State 116
		DEFAULT => -97
	},
	{#State 117
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 164
		}
	},
	{#State 118
		DEFAULT => -47,
		GOTOS => {
			'@1-2' => 165
		}
	},
	{#State 119
		ACTIONS => {
			"{" => 50
		},
		GOTOS => {
			'block' => 166
		}
	},
	{#State 120
		DEFAULT => -28
	},
	{#State 121
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			'MY' => 10,
			"%" => 9,
			'LSTOP' => 11,
			"!" => 14,
			"\$" => 16,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			"(" => 29,
			'FUNC1' => 30,
			"+" => 34,
			'NOAMP' => 35,
			'DOLSHARP' => 36,
			'STRING' => 39,
			'FUNC' => 38,
			'LOOPEX' => 42,
			'FUNC0' => 46,
			"&" => 48,
			'UNIOP' => 49
		},
		DEFAULT => -52,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 167,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 122
		ACTIONS => {
			'OROP' => 109,
			"]" => 168,
			'ANDOP' => 107
		}
	},
	{#State 123
		DEFAULT => -45
	},
	{#State 124
		ACTIONS => {
			'OROP' => 109,
			")" => 169,
			'ANDOP' => 107
		}
	},
	{#State 125
		DEFAULT => -110
	},
	{#State 126
		DEFAULT => -107
	},
	{#State 127
		ACTIONS => {
			"," => 121
		},
		DEFAULT => -55
	},
	{#State 128
		ACTIONS => {
			'OROP' => 109,
			"]" => 170,
			'ANDOP' => 107
		}
	},
	{#State 129
		ACTIONS => {
			";" => 171,
			'OROP' => 109,
			'ANDOP' => 107
		}
	},
	{#State 130
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'mexpr' => 172,
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 173,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 131
		ACTIONS => {
			'MATCHOP' => 96,
			'POSTDEC' => 102,
			'MULOP' => 104,
			'DOTDOT' => 103,
			'ADDOP' => 100,
			"," => 174,
			'ASSIGNOP' => 94,
			'OROR' => 105,
			'POSTINC' => 101,
			'ANDAND' => 97,
			")" => 175,
			'POWOP' => 95,
			'EQOP' => 98,
			'RELOP' => 99
		}
	},
	{#State 132
		DEFAULT => -42
	},
	{#State 133
		ACTIONS => {
			";" => 177,
			"{" => 50
		},
		GOTOS => {
			'block' => 178,
			'subbody' => 176
		}
	},
	{#State 134
		ACTIONS => {
			'OROP' => 109,
			")" => 179,
			'ANDOP' => 107
		}
	},
	{#State 135
		DEFAULT => -91
	},
	{#State 136
		ACTIONS => {
			"[" => 180
		},
		DEFAULT => -79
	},
	{#State 137
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 181,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 138
		ACTIONS => {
			'OROP' => 109,
			")" => 182,
			'ANDOP' => 107
		}
	},
	{#State 139
		DEFAULT => -101
	},
	{#State 140
		DEFAULT => -3,
		GOTOS => {
			'remember' => 183
		}
	},
	{#State 141
		ACTIONS => {
			"\$" => 16
		},
		GOTOS => {
			'scalar' => 184,
			'my_scalar' => 185
		}
	},
	{#State 142
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			";" => -29,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'error' => 43,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'mexpr' => 186,
			'scalar' => 6,
			'sideff' => 188,
			'term' => 37,
			'ary' => 12,
			'expr' => 189,
			'nexpr' => 190,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20,
			'arylen' => 47,
			'mnexpr' => 187,
			'amper' => 26,
			'myattrterm' => 27,
			'subscripted' => 28,
			'argexpr' => 55
		}
	},
	{#State 143
		DEFAULT => -93
	},
	{#State 144
		ACTIONS => {
			'ADDOP' => 100,
			'ASSIGNOP' => 94,
			'POSTINC' => 101,
			'POWOP' => 95,
			'MATCHOP' => 96,
			'POSTDEC' => 102,
			'DOTDOT' => 103,
			'MULOP' => 104,
			'ANDAND' => 97,
			'OROR' => 105,
			'RELOP' => 99,
			'EQOP' => 98
		},
		DEFAULT => -60
	},
	{#State 145
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 95,
			'POSTDEC' => 102
		},
		DEFAULT => -61
	},
	{#State 146
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 95,
			'POSTDEC' => 102
		},
		DEFAULT => -69
	},
	{#State 147
		ACTIONS => {
			'ADDOP' => 100,
			'POSTINC' => 101,
			'POWOP' => 95,
			'MATCHOP' => 96,
			'POSTDEC' => 102,
			'MULOP' => 104,
			'RELOP' => 99,
			'EQOP' => 98
		},
		DEFAULT => -67
	},
	{#State 148
		ACTIONS => {
			'ADDOP' => 100,
			'POSTINC' => 101,
			'POWOP' => 95,
			'MATCHOP' => 96,
			'POSTDEC' => 102,
			'MULOP' => 104,
			'RELOP' => 99,
			'EQOP' => undef
		},
		DEFAULT => -65
	},
	{#State 149
		ACTIONS => {
			'ADDOP' => 100,
			'POSTINC' => 101,
			'POWOP' => 95,
			'MATCHOP' => 96,
			'POSTDEC' => 102,
			'MULOP' => 104,
			'RELOP' => undef
		},
		DEFAULT => -64
	},
	{#State 150
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 95,
			'MATCHOP' => 96,
			'POSTDEC' => 102,
			'MULOP' => 104
		},
		DEFAULT => -63
	},
	{#State 151
		ACTIONS => {
			'ADDOP' => 100,
			'POSTINC' => 101,
			'POWOP' => 95,
			'MATCHOP' => 96,
			'POSTDEC' => 102,
			'DOTDOT' => undef,
			'MULOP' => 104,
			'ANDAND' => 97,
			'OROR' => 105,
			'RELOP' => 99,
			'EQOP' => 98
		},
		DEFAULT => -66
	},
	{#State 152
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 95,
			'MATCHOP' => 96,
			'POSTDEC' => 102
		},
		DEFAULT => -62
	},
	{#State 153
		ACTIONS => {
			'ADDOP' => 100,
			'POSTINC' => 101,
			'POWOP' => 95,
			'MATCHOP' => 96,
			'POSTDEC' => 102,
			'MULOP' => 104,
			'ANDAND' => 97,
			'RELOP' => 99,
			'EQOP' => 98
		},
		DEFAULT => -68
	},
	{#State 154
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 191,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 155
		ACTIONS => {
			")" => 192
		}
	},
	{#State 156
		ACTIONS => {
			'OROP' => 109,
			"," => 193,
			'ANDOP' => 107
		},
		DEFAULT => -117
	},
	{#State 157
		DEFAULT => -49
	},
	{#State 158
		ACTIONS => {
			'OROP' => 109,
			'ANDOP' => 107
		},
		DEFAULT => -14
	},
	{#State 159
		ACTIONS => {
			'ANDOP' => 107
		},
		DEFAULT => -50
	},
	{#State 160
		ACTIONS => {
			'OROP' => 109,
			'ANDOP' => 107
		},
		DEFAULT => -16
	},
	{#State 161
		ACTIONS => {
			'OROP' => 109,
			'ANDOP' => 107
		},
		DEFAULT => -15
	},
	{#State 162
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		DEFAULT => -31,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 196,
			'texpr' => 194,
			'termbinop' => 18,
			'mtexpr' => 195,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 163
		DEFAULT => -100
	},
	{#State 164
		ACTIONS => {
			"}" => 197,
			"-" => 5,
			'WORD' => 4,
			'PACKAGE' => 8,
			"\@" => 7,
			'FOR' => 33,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			'IF' => 17,
			"\$" => 16,
			'error' => 43,
			'LOOPEX' => 42,
			'WHILE' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'SUB' => 25,
			"{" => 50,
			'UNIOP' => 49,
			"&" => 48,
			'USE' => 52,
			"(" => 29,
			'format' => 53,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 31,
			'sideff' => 32,
			'term' => 37,
			'loop' => 13,
			'ary' => 12,
			'expr' => 40,
			'use' => 41,
			'decl' => 15,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20,
			'line' => 21,
			'cond' => 24,
			'arylen' => 47,
			'amper' => 26,
			'myattrterm' => 27,
			'subscripted' => 28,
			'package' => 51,
			'block' => 54,
			'argexpr' => 55
		}
	},
	{#State 165
		ACTIONS => {
			'WORD' => 198
		}
	},
	{#State 166
		DEFAULT => -22
	},
	{#State 167
		ACTIONS => {
			'ADDOP' => 100,
			'ASSIGNOP' => 94,
			'POSTINC' => 101,
			'POWOP' => 95,
			'MATCHOP' => 96,
			'POSTDEC' => 102,
			'DOTDOT' => 103,
			'MULOP' => 104,
			'ANDAND' => 97,
			'OROR' => 105,
			'RELOP' => 99,
			'EQOP' => 98
		},
		DEFAULT => -53
	},
	{#State 168
		DEFAULT => -59
	},
	{#State 169
		DEFAULT => -109
	},
	{#State 170
		DEFAULT => -88
	},
	{#State 171
		ACTIONS => {
			"}" => 199
		}
	},
	{#State 172
		ACTIONS => {
			")" => 200
		}
	},
	{#State 173
		ACTIONS => {
			'OROP' => 109,
			'ANDOP' => 107
		},
		DEFAULT => -33
	},
	{#State 174
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 201,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 175
		DEFAULT => -103
	},
	{#State 176
		DEFAULT => -40
	},
	{#State 177
		DEFAULT => -44
	},
	{#State 178
		DEFAULT => -43
	},
	{#State 179
		DEFAULT => -92
	},
	{#State 180
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 202,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 181
		ACTIONS => {
			'OROP' => 109,
			"]" => 203,
			'ANDOP' => 107
		}
	},
	{#State 182
		DEFAULT => -102
	},
	{#State 183
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'mexpr' => 204,
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 173,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 184
		DEFAULT => -119
	},
	{#State 185
		ACTIONS => {
			"(" => 205
		}
	},
	{#State 186
		ACTIONS => {
			")" => 206
		}
	},
	{#State 187
		ACTIONS => {
			";" => 207
		}
	},
	{#State 188
		DEFAULT => -30
	},
	{#State 189
		ACTIONS => {
			'FOR' => 110,
			'OROP' => 109,
			'ANDOP' => 107,
			'IF' => 108,
			")" => -33,
			'WHILE' => 111
		},
		DEFAULT => -13
	},
	{#State 190
		DEFAULT => -34
	},
	{#State 191
		ACTIONS => {
			'OROP' => 109,
			")" => 208,
			'ANDOP' => 107
		}
	},
	{#State 192
		DEFAULT => -58
	},
	{#State 193
		DEFAULT => -118
	},
	{#State 194
		DEFAULT => -35
	},
	{#State 195
		ACTIONS => {
			")" => 209
		}
	},
	{#State 196
		ACTIONS => {
			'OROP' => 109,
			'ANDOP' => 107
		},
		DEFAULT => -32
	},
	{#State 197
		DEFAULT => -2
	},
	{#State 198
		ACTIONS => {
			'WORD' => 210
		}
	},
	{#State 199
		DEFAULT => -89
	},
	{#State 200
		ACTIONS => {
			"{" => 211
		},
		GOTOS => {
			'mblock' => 212
		}
	},
	{#State 201
		ACTIONS => {
			'MATCHOP' => 96,
			'POSTDEC' => 102,
			'MULOP' => 104,
			'DOTDOT' => 103,
			'ADDOP' => 100,
			'ASSIGNOP' => 94,
			'OROR' => 105,
			'ANDAND' => 97,
			'POSTINC' => 101,
			")" => 213,
			'POWOP' => 95,
			'EQOP' => 98,
			'RELOP' => 99
		}
	},
	{#State 202
		ACTIONS => {
			'OROP' => 109,
			"]" => 214,
			'ANDOP' => 107
		}
	},
	{#State 203
		DEFAULT => -87
	},
	{#State 204
		ACTIONS => {
			")" => 215
		}
	},
	{#State 205
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'mexpr' => 216,
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 173,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 206
		ACTIONS => {
			"{" => 211
		},
		GOTOS => {
			'mblock' => 217
		}
	},
	{#State 207
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		DEFAULT => -31,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 196,
			'texpr' => 194,
			'termbinop' => 18,
			'mtexpr' => 218,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 208
		DEFAULT => -56
	},
	{#State 209
		ACTIONS => {
			"{" => 211
		},
		GOTOS => {
			'mblock' => 219
		}
	},
	{#State 210
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		DEFAULT => -114,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 74,
			'listop' => 44,
			'listexpr' => 220,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 211
		DEFAULT => -5,
		GOTOS => {
			'mremember' => 221
		}
	},
	{#State 212
		ACTIONS => {
			'ELSE' => 222,
			'ELSIF' => 224
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 223
		}
	},
	{#State 213
		DEFAULT => -104
	},
	{#State 214
		DEFAULT => -86
	},
	{#State 215
		ACTIONS => {
			"{" => 211
		},
		GOTOS => {
			'mblock' => 225
		}
	},
	{#State 216
		ACTIONS => {
			")" => 226
		}
	},
	{#State 217
		ACTIONS => {
			'CONTINUE' => 119
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 227
		}
	},
	{#State 218
		ACTIONS => {
			";" => 228
		}
	},
	{#State 219
		ACTIONS => {
			'CONTINUE' => 119
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 229
		}
	},
	{#State 220
		ACTIONS => {
			";" => 230
		}
	},
	{#State 221
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 231
		}
	},
	{#State 222
		ACTIONS => {
			"{" => 211
		},
		GOTOS => {
			'mblock' => 232
		}
	},
	{#State 223
		DEFAULT => -20
	},
	{#State 224
		ACTIONS => {
			"(" => 233
		}
	},
	{#State 225
		ACTIONS => {
			'CONTINUE' => 119
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 234
		}
	},
	{#State 226
		ACTIONS => {
			"{" => 211
		},
		GOTOS => {
			'mblock' => 235
		}
	},
	{#State 227
		DEFAULT => -26
	},
	{#State 228
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'error' => 43,
			'LOOPEX' => 42,
			")" => -29,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'sideff' => 188,
			'term' => 37,
			'ary' => 12,
			'expr' => 40,
			'nexpr' => 190,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20,
			'arylen' => 47,
			'mnexpr' => 236,
			'amper' => 26,
			'myattrterm' => 27,
			'subscripted' => 28,
			'argexpr' => 55
		}
	},
	{#State 229
		DEFAULT => -23
	},
	{#State 230
		DEFAULT => -48
	},
	{#State 231
		ACTIONS => {
			"}" => 237,
			"-" => 5,
			'WORD' => 4,
			'PACKAGE' => 8,
			"\@" => 7,
			'FOR' => 33,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			'IF' => 17,
			"\$" => 16,
			'error' => 43,
			'LOOPEX' => 42,
			'WHILE' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'SUB' => 25,
			"{" => 50,
			'UNIOP' => 49,
			"&" => 48,
			'USE' => 52,
			"(" => 29,
			'format' => 53,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 31,
			'sideff' => 32,
			'term' => 37,
			'loop' => 13,
			'ary' => 12,
			'expr' => 40,
			'use' => 41,
			'decl' => 15,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20,
			'line' => 21,
			'cond' => 24,
			'arylen' => 47,
			'amper' => 26,
			'myattrterm' => 27,
			'subscripted' => 28,
			'package' => 51,
			'block' => 54,
			'argexpr' => 55
		}
	},
	{#State 232
		DEFAULT => -18
	},
	{#State 233
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'STRING' => 39,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'mexpr' => 238,
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 173,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 234
		DEFAULT => -25
	},
	{#State 235
		ACTIONS => {
			'CONTINUE' => 119
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 239
		}
	},
	{#State 236
		ACTIONS => {
			")" => 240
		}
	},
	{#State 237
		DEFAULT => -4
	},
	{#State 238
		ACTIONS => {
			")" => 241
		}
	},
	{#State 239
		DEFAULT => -24
	},
	{#State 240
		ACTIONS => {
			"{" => 211
		},
		GOTOS => {
			'mblock' => 242
		}
	},
	{#State 241
		ACTIONS => {
			"{" => 211
		},
		GOTOS => {
			'mblock' => 243
		}
	},
	{#State 242
		DEFAULT => -27
	},
	{#State 243
		ACTIONS => {
			'ELSE' => 222,
			'ELSIF' => 224
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 244
		}
	},
	{#State 244
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
#line 164 "plpy.yp"
{# $$ = $1; newPROG(block_end($1,$2));
            }
	],
	[#Rule 2
		 'block', 4,
sub
#line 170 "plpy.yp"
{# /* if (PL_copline > (line_t)$1)
             #     PL_copline = (line_t)$1;
             # $$ = block_end($2, $3); */
             }
	],
	[#Rule 3
		 'remember', 0,
sub
#line 177 "plpy.yp"
{# $$ = block_start(TRUE);
            }
	],
	[#Rule 4
		 'mblock', 4,
sub
#line 182 "plpy.yp"
{#/* if (PL_copline > (line_t)$1)
             #     PL_copline = (line_t)$1;
             # $$ = block_end($2, $3); */
             }
	],
	[#Rule 5
		 'mremember', 0,
sub
#line 189 "plpy.yp"
{# $$ = block_start(FALSE);
            }
	],
	[#Rule 6
		 'lineseq', 0,
sub
#line 195 "plpy.yp"
{# $$ = Nullop;
             }
	],
	[#Rule 7
		 'lineseq', 2,
sub
#line 198 "plpy.yp"
{# $$ = $1;
             }
	],
	[#Rule 8
		 'lineseq', 2,
sub
#line 201 "plpy.yp"
{#/*   $$ = append_list(OP_LINESEQ,
            #    (LISTOP*)$1, (LISTOP*)$2);
                #PL_pad_reset_pending = TRUE;
                #if ($1 && $2) PL_hints |= HINT_BLOCK_SCOPE;*/
                }
	],
	[#Rule 9
		 'line', 1,
sub
#line 210 "plpy.yp"
{# $$ = newSTATEOP(0, $1, $2);
            }
	],
	[#Rule 10
		 'line', 1, undef
	],
	[#Rule 11
		 'line', 2,
sub
#line 225 "plpy.yp"
{#$$ = newSTATEOP(0, $1, $2);
            #PL_expect = XSTATE;
            }
	],
	[#Rule 12
		 'sideff', 1,
sub
#line 232 "plpy.yp"
{# $$ = Nullop;
            }
	],
	[#Rule 13
		 'sideff', 1,
sub
#line 235 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 14
		 'sideff', 3,
sub
#line 238 "plpy.yp"
{#$$ = newLOGOP(OP_AND, 0, $3, $1);
            }
	],
	[#Rule 15
		 'sideff', 3,
sub
#line 245 "plpy.yp"
{# $$ = newLOOPOP(OPf_PARENS, 1, scalar($3), $1);
            }
	],
	[#Rule 16
		 'sideff', 3,
sub
#line 250 "plpy.yp"
{#/* $$ = newFOROP(0, Nullch, (line_t)$2,
                #Nullop, $3, $1, Nullop); */
                }
	],
	[#Rule 17
		 'else', 0,
sub
#line 257 "plpy.yp"
{# $$ = Nullop;
            }
	],
	[#Rule 18
		 'else', 2,
sub
#line 260 "plpy.yp"
{# ($2)->op_flags |= OPf_PARENS; $$ = scope($2);
            }
	],
	[#Rule 19
		 'else', 6,
sub
#line 263 "plpy.yp"
{#/* PL_copline = (line_t)$1;
                #$$ = newCONDOP(0, $3, scope($5), $6);
                #PL_hints |= HINT_BLOCK_SCOPE; */
                }
	],
	[#Rule 20
		 'cond', 7,
sub
#line 271 "plpy.yp"
{ #/*PL_copline = (line_t)$1;
              #  $$ = block_end($3,
            #       newCONDOP(0, $4, scope($6), $7)); */
            }
	],
	[#Rule 21
		 'cont', 0,
sub
#line 285 "plpy.yp"
{# $$ = Nullop;
            }
	],
	[#Rule 22
		 'cont', 2,
sub
#line 288 "plpy.yp"
{# $$ = scope($2);
            }
	],
	[#Rule 23
		 'loop', 7,
sub
#line 294 "plpy.yp"
{#/* PL_copline = (line_t)$2;
            #  $$ = block_end($4,
            #   newSTATEOP(0, $1,
            #j     newWHILEOP(0, 1, (LOOP*)Nullop,
            #            $2, $5, $7, $8))); */
            }
	],
	[#Rule 24
		 'loop', 9,
sub
#line 309 "plpy.yp"
{#/* $$ = block_end($4,
                #newFOROP(0, $1, (line_t)$2, $5, $7, $9, $10)); */
            }
	],
	[#Rule 25
		 'loop', 8,
sub
#line 313 "plpy.yp"
{#/* $$ = block_end($5,
                #newFOROP(0, $1, (line_t)$2, mod($3, OP_ENTERLOOP),
                      #$6, $8, $9)); */
                      }
	],
	[#Rule 26
		 'loop', 7,
sub
#line 318 "plpy.yp"
{#/* $$ = block_end($4,
                 #newFOROP(0, $1, (line_t)$2, Nullop, $5, $7, $8)); */
                 }
	],
	[#Rule 27
		 'loop', 10,
sub
#line 323 "plpy.yp"
{#/* OP *forop;
             # PL_copline = (line_t)$2;
             # forop = newSTATEOP(0, $1,
                        #newWHILEOP(0, 1, (LOOP*)Nullop,
                        #$2, scalar($7),
                        #j$11, $9));
              #if ($5) {
                #forop = append_elem(OP_LINESEQ,
                                        #newSTATEOP(0, ($1?savepv($1):Nullch),
                           #$5),
                    #forop);
              #}

              #$$ = block_end($4, forop); */
              }
	],
	[#Rule 28
		 'loop', 2,
sub
#line 339 "plpy.yp"
{#/* $$ = newSTATEOP(0, $1,
                 #newWHILEOP(0, 1, (LOOP*)Nullop,
                        #NOLINE, Nullop, $2, $3)); */
            }
	],
	[#Rule 29
		 'nexpr', 0,
sub
#line 347 "plpy.yp"
{# $$ = Nullop;
            }
	],
	[#Rule 30
		 'nexpr', 1, undef
	],
	[#Rule 31
		 'texpr', 0,
sub
#line 354 "plpy.yp"
{# (void)scan_num("1", &yylval); $$ = yylval.opval;
            }
	],
	[#Rule 32
		 'texpr', 1, undef
	],
	[#Rule 33
		 'mexpr', 1,
sub
#line 368 "plpy.yp"
{# $$ = $1; intro_my();
            }
	],
	[#Rule 34
		 'mnexpr', 1,
sub
#line 373 "plpy.yp"
{# $$ = $1; intro_my();
            }
	],
	[#Rule 35
		 'mtexpr', 1,
sub
#line 378 "plpy.yp"
{# $$ = $1; intro_my();
            }
	],
	[#Rule 36
		 'decl', 1,
sub
#line 397 "plpy.yp"
{# $$ = 0;
            }
	],
	[#Rule 37
		 'decl', 1,
sub
#line 400 "plpy.yp"
{# $$ = 0;
            }
	],
	[#Rule 38
		 'decl', 1,
sub
#line 407 "plpy.yp"
{# $$ = 0; */
            }
	],
	[#Rule 39
		 'decl', 1,
sub
#line 410 "plpy.yp"
{# $$ = 0;
            }
	],
	[#Rule 40
		 'subrout', 4,
sub
#line 431 "plpy.yp"
{# newATTRSUB($2, $3, $4, $5, $6);
            }
	],
	[#Rule 41
		 'startsub', 0,
sub
#line 436 "plpy.yp"
{# $$ = start_subparse(FALSE, 0);
            }
	],
	[#Rule 42
		 'subname', 1,
sub
#line 452 "plpy.yp"
{#/*STRLEN n_a; char *name = SvPV(((SVOP*)$1)->op_sv,n_a);
              #if (strEQ(name, "BEGIN") || strEQ(name, "END")
                  #|| strEQ(name, "INIT") || strEQ(name, "CHECK"))
                  #CvSPECIAL_on(PL_compcv);
              #$$ = $1; */
              }
	],
	[#Rule 43
		 'subbody', 1,
sub
#line 487 "plpy.yp"
{/* $$ = $1; */}
	],
	[#Rule 44
		 'subbody', 1,
sub
#line 488 "plpy.yp"
{# $$ = Nullop; PL_expect = XSTATE;
            }
	],
	[#Rule 45
		 'package', 3,
sub
#line 493 "plpy.yp"
{# package($2);
            }
	],
	[#Rule 46
		 'package', 2,
sub
#line 496 "plpy.yp"
{# package(Nullop);
            }
	],
	[#Rule 47
		 '@1-2', 0,
sub
#line 501 "plpy.yp"
{# CvSPECIAL_on(PL_compcv); /* It's a BEGIN {} */
            }
	],
	[#Rule 48
		 'use', 7,
sub
#line 504 "plpy.yp"
{# utilize($1, $2, $4, $5, $6);
            }
	],
	[#Rule 49
		 'expr', 3,
sub
#line 510 "plpy.yp"
{# $$ = newLOGOP(OP_AND, 0, $1, $3);
            }
	],
	[#Rule 50
		 'expr', 3,
sub
#line 513 "plpy.yp"
{# $$ = newLOGOP($2, 0, $1, $3);
            }
	],
	[#Rule 51
		 'expr', 1, undef
	],
	[#Rule 52
		 'argexpr', 2,
sub
#line 520 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 53
		 'argexpr', 3,
sub
#line 523 "plpy.yp"
{# $$ = append_elem(OP_LIST, $1, $3);
            }
	],
	[#Rule 54
		 'argexpr', 1, undef
	],
	[#Rule 55
		 'listop', 3,
sub
#line 530 "plpy.yp"
{# $$ = convert($1, OPf_STACKED,
                #prepend_elem(OP_LIST, newGVREF($1,$2), $3) );
            }
	],
	[#Rule 56
		 'listop', 5,
sub
#line 534 "plpy.yp"
{# $$ = convert($1, OPf_STACKED,
                #prepend_elem(OP_LIST, newGVREF($1,$3), $4) );
            }
	],
	[#Rule 57
		 'listop', 2,
sub
#line 559 "plpy.yp"
{# $$ = convert($1, 0, $2);
            }
	],
	[#Rule 58
		 'listop', 4,
sub
#line 562 "plpy.yp"
{# $$ = convert($1, 0, $3);
            }
	],
	[#Rule 59
		 'subscripted', 4,
sub
#line 591 "plpy.yp"
{# $$ = newBINOP(OP_AELEM, 0, oopsAV($1), scalar($3));
            }
	],
	[#Rule 60
		 'termbinop', 3,
sub
#line 635 "plpy.yp"
{# $$ = newASSIGNOP(OPf_STACKED, $1, $2, $3);
            }
	],
	[#Rule 61
		 'termbinop', 3,
sub
#line 638 "plpy.yp"
{# $$ = newBINOP($2, 0, scalar($1), scalar($3));
            }
	],
	[#Rule 62
		 'termbinop', 3,
sub
#line 641 "plpy.yp"
{#   if ($2 != OP_REPEAT)
                #scalar($1);
               # $$ = newBINOP($2, 0, $1, scalar($3));
            }
	],
	[#Rule 63
		 'termbinop', 3,
sub
#line 646 "plpy.yp"
{# $$ = newBINOP($2, 0, scalar($1), scalar($3));
            }
	],
	[#Rule 64
		 'termbinop', 3,
sub
#line 653 "plpy.yp"
{# $$ = newBINOP($2, 0, scalar($1), scalar($3));
            }
	],
	[#Rule 65
		 'termbinop', 3,
sub
#line 656 "plpy.yp"
{# $$ = newBINOP($2, 0, scalar($1), scalar($3));
            }
	],
	[#Rule 66
		 'termbinop', 3,
sub
#line 665 "plpy.yp"
{# $$ = newRANGE($2, scalar($1), scalar($3));
            }
	],
	[#Rule 67
		 'termbinop', 3,
sub
#line 668 "plpy.yp"
{# $$ = newLOGOP(OP_AND, 0, $1, $3);
            }
	],
	[#Rule 68
		 'termbinop', 3,
sub
#line 671 "plpy.yp"
{# $$ = newLOGOP(OP_OR, 0, $1, $3);
            }
	],
	[#Rule 69
		 'termbinop', 3,
sub
#line 674 "plpy.yp"
{# $$ = bind_match($2, $1, $3);
            }
	],
	[#Rule 70
		 'termunop', 2,
sub
#line 680 "plpy.yp"
{# $$ = newUNOP(OP_NEGATE, 0, scalar($2));
            }
	],
	[#Rule 71
		 'termunop', 2,
sub
#line 683 "plpy.yp"
{# $$ = $2;
            }
	],
	[#Rule 72
		 'termunop', 2,
sub
#line 686 "plpy.yp"
{# $$ = newUNOP(OP_NOT, 0, scalar($2));
            }
	],
	[#Rule 73
		 'termunop', 2,
sub
#line 693 "plpy.yp"
{#$$ = newUNOP(OP_POSTINC, 0,
                    #mod(scalar($1), OP_POSTINC));
            }
	],
	[#Rule 74
		 'termunop', 2,
sub
#line 697 "plpy.yp"
{#$$ = newUNOP(OP_POSTDEC, 0,
                    #mod(scalar($1), OP_POSTDEC)); */
            }
	],
	[#Rule 75
		 'term', 1, undef
	],
	[#Rule 76
		 'term', 1, undef
	],
	[#Rule 77
		 'term', 1, undef
	],
	[#Rule 78
		 'term', 1,
sub
#line 775 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 79
		 'term', 3,
sub
#line 782 "plpy.yp"
{# $$ = sawparens($2);
            }
	],
	[#Rule 80
		 'term', 2,
sub
#line 785 "plpy.yp"
{# $$ = sawparens(newNULLLIST());
            }
	],
	[#Rule 81
		 'term', 1,
sub
#line 788 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 82
		 'term', 1,
sub
#line 795 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 83
		 'term', 1,
sub
#line 798 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 84
		 'term', 1,
sub
#line 801 "plpy.yp"
{# $$ = newUNOP(OP_AV2ARYLEN, 0, ref($1, OP_AV2ARYLEN));
            }
	],
	[#Rule 85
		 'term', 1,
sub
#line 804 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 86
		 'term', 6,
sub
#line 807 "plpy.yp"
{# $$ = newSLICEOP(0, $5, $2);
            }
	],
	[#Rule 87
		 'term', 5,
sub
#line 810 "plpy.yp"
{# $$ = newSLICEOP(0, $4, Nullop);
            }
	],
	[#Rule 88
		 'term', 4,
sub
#line 813 "plpy.yp"
{#$$ = prepend_elem(OP_ASLICE,
            #    newOP(OP_PUSHMARK, 0),
                    #newLISTOP(OP_ASLICE, 0,
                    #list($3),
                    #ref($1, OP_ASLICE)));
            }
	],
	[#Rule 89
		 'term', 5,
sub
#line 820 "plpy.yp"
{#$$ = prepend_elem(OP_HSLICE,
            #    newOP(OP_PUSHMARK, 0),
                    #newLISTOP(OP_HSLICE, 0,
                    #list($3),
                    #ref(oopsHV($1), OP_HSLICE)));
                #PL_expect = XOPERATOR; */
                }
	],
	[#Rule 90
		 'term', 1,
sub
#line 832 "plpy.yp"
{# $$ = newUNOP(OP_ENTERSUB, 0, scalar($1));
            }
	],
	[#Rule 91
		 'term', 3,
sub
#line 835 "plpy.yp"
{# $$ = newUNOP(OP_ENTERSUB, OPf_STACKED, scalar($1));
            }
	],
	[#Rule 92
		 'term', 4,
sub
#line 838 "plpy.yp"
{# $$ = newUNOP(OP_ENTERSUB, OPf_STACKED,
                #append_elem(OP_LIST, $3, scalar($1)));
                }
	],
	[#Rule 93
		 'term', 3,
sub
#line 842 "plpy.yp"
{# $$ = newUNOP(OP_ENTERSUB, OPf_STACKED,
                #append_elem(OP_LIST, $3, scalar($2)));
                }
	],
	[#Rule 94
		 'term', 1,
sub
#line 846 "plpy.yp"
{# $$ = newOP($1, OPf_SPECIAL);
                #PL_hints |= HINT_BLOCK_SCOPE;
                }
	],
	[#Rule 95
		 'term', 2,
sub
#line 854 "plpy.yp"
{# $$ = newUNOP(OP_NOT, 0, scalar($2));
            }
	],
	[#Rule 96
		 'term', 1,
sub
#line 857 "plpy.yp"
{# $$ = newOP($1, 0);
            }
	],
	[#Rule 97
		 'term', 2,
sub
#line 860 "plpy.yp"
{# $$ = newUNOP($1, 0, $2);
            }
	],
	[#Rule 98
		 'term', 2,
sub
#line 863 "plpy.yp"
{# $$ = newUNOP($1, 0, $2);
            }
	],
	[#Rule 99
		 'term', 1,
sub
#line 871 "plpy.yp"
{# $$ = newOP($1, 0);
            }
	],
	[#Rule 100
		 'term', 3,
sub
#line 874 "plpy.yp"
{# $$ = newOP($1, 0);
            }
	],
	[#Rule 101
		 'term', 3,
sub
#line 882 "plpy.yp"
{/* $$ = $1 == OP_NOT ? newUNOP($1, 0, newSVOP(OP_CONST, 0, newSViv(0)))
                        : newOP($1, OPf_SPECIAL); */}
	],
	[#Rule 102
		 'term', 4,
sub
#line 885 "plpy.yp"
{# $$ = newUNOP($1, 0, $3);
            }
	],
	[#Rule 103
		 'term', 4,
sub
#line 888 "plpy.yp"
{# $$ = pmruntime($1, $3, Nullop);
            }
	],
	[#Rule 104
		 'term', 6,
sub
#line 891 "plpy.yp"
{# $$ = pmruntime($1, $3, $5);
            }
	],
	[#Rule 105
		 'term', 1, undef
	],
	[#Rule 106
		 'term', 1, undef
	],
	[#Rule 107
		 'myattrterm', 3,
sub
#line 899 "plpy.yp"
{# $$ = my_attrs($2,$3);
            }
	],
	[#Rule 108
		 'myattrterm', 2,
sub
#line 902 "plpy.yp"
{# $$ = localize($2,$1);
            }
	],
	[#Rule 109
		 'myterm', 3,
sub
#line 908 "plpy.yp"
{# $$ = sawparens($2);
            }
	],
	[#Rule 110
		 'myterm', 2,
sub
#line 911 "plpy.yp"
{# $$ = sawparens(newNULLLIST());
            }
	],
	[#Rule 111
		 'myterm', 1,
sub
#line 914 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 112
		 'myterm', 1,
sub
#line 917 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 113
		 'myterm', 1,
sub
#line 920 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 114
		 'listexpr', 0,
sub
#line 926 "plpy.yp"
{# $$ = Nullop;
            }
	],
	[#Rule 115
		 'listexpr', 1,
sub
#line 929 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 116
		 'listexprcom', 0,
sub
#line 934 "plpy.yp"
{# $$ = Nullop;
            }
	],
	[#Rule 117
		 'listexprcom', 1,
sub
#line 937 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 118
		 'listexprcom', 2,
sub
#line 940 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 119
		 'my_scalar', 1,
sub
#line 947 "plpy.yp"
{# PL_in_my = 0; $$ = my($1);
            }
	],
	[#Rule 120
		 'amper', 2,
sub
#line 952 "plpy.yp"
{# $$ = newCVREF($1,$2);
            }
	],
	[#Rule 121
		 'scalar', 2,
sub
#line 957 "plpy.yp"
{# $$ = newSVREF($2);
            }
	],
	[#Rule 122
		 'ary', 2,
sub
#line 962 "plpy.yp"
{# $$ = newAVREF($2);
            }
	],
	[#Rule 123
		 'hsh', 2,
sub
#line 967 "plpy.yp"
{# $$ = newHVREF($2);
            }
	],
	[#Rule 124
		 'arylen', 2,
sub
#line 972 "plpy.yp"
{# $$ = newAVREF($2);
            }
	],
	[#Rule 125
		 'indirob', 1,
sub
#line 984 "plpy.yp"
{# $$ = scalar($1);
            }
	],
	[#Rule 126
		 'indirob', 1,
sub
#line 987 "plpy.yp"
{# $$ = scalar($1);
            }
	],
	[#Rule 127
		 'indirob', 1,
sub
#line 990 "plpy.yp"
{# $$ = scope($1);
            }
	]
],
                                  @_);
    bless($self,$class);
}

#line 998 "plpy.yp"

# PROGRAM */

# more stuff added to make perly_c.diff easier to apply */
# Tokens.
#define GRAMPROG 258
#define GRAMEXPR 259
#define GRAMBLOCK 260
#define GRAMBARESTMT 261
#define GRAMFULLSTMT 262
#define GRAMSTMTSEQ 263
#define WORD 264
#define METHOD 265
#define FUNCMETH 266
#define THING 267
#define PMFUNC 268
#define PRIVATEREF 269
#define QWLIST 270
#define FUNC0SUB 271
#define UNIOPSUB 272
#define LSTOPSUB 273
#define PLUGEXPR 274
#define PLUGSTMT 275
#define LABEL 276
#define FORMAT 277
#define SUB 278
#define ANONSUB 279
#define PACKAGE 280
#define USE 281
#define WHILE 282
#define UNTIL 283
#define IF 284
#define UNLESS 285
#define ELSE 286
#define ELSIF 287
#define CONTINUE 288
#define FOR 289
#define GIVEN 290
#define WHEN 291
#define DEFAULT 292
#define LOOPEX 293
#define DOTDOT 294
#define YADAYADA 295
#define FUNC0 296
#define FUNC1 297
#define FUNC 298
#define UNIOP 299
#define LSTOP 300
#define RELOP 301
#define EQOP 302
#define MULOP 303
#define ADDOP 304
#define DOLSHARP 305
#define DO 306
#define HASHBRACK 307
#define NOAMP 308
#define LOCAL 309
#define MY 310
#define MYSUB 311
#define REQUIRE 312
#define COLONATTR 313
#define PREC_LOW 314
#define DOROP 315
#define OROP 316
#define ANDOP 317
#define NOTOP 318
#define ASSIGNOP 319
#define DORDOR 320
#define OROR 321
#define ANDAND 322
#define BITOROP 323
#define BITANDOP 324
#define SHIFTOP 325
#define MATCHOP 326
#define REFGEN 327
#define UMINUS 328
#define POWOP 329
#define POSTDEC 330
#define POSTINC 331
#define PREDEC 332
#define PREINC 333
#define ARROW 334
#define PEG 335
#*/

1;
