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
        ["PMFUNC", qr/split/],
        ["FUNC0", qr/(print)|(printf)|(chomp)|(split)|(exit)|(pop)|(shift)/],
        ["FUNC1", qr/(print)|(printf)|(chomp)|(split)|(exit)|(pop)|(shift)|(reverse)|(open)|(sort)|(keys)/],
        ["FUNC", qr/(print)|(printf)|(chomp)|(split)|(join)|(push)|(unshift)|(open)/],
        ["UNIOP", qr/(exit)|(return)|(scalar)|(chomp)|(close)|(keys)|(pop)|(shift)|(values)/],
        ["LSTOP", qr/(print)|(chomp)|(join)|(push)|(pop)|(shift)|(scalar)|(unshift)|(reverse)|(open)|(sort)|(keys)/],
        ["FOR", qr/(for)|(foreach)/],
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
        ["EQOP", qr/(==)|(!=)|(eq)/],
        ["ANDAND", qr/&&/],
        ["MATCHOP", qr/=~/],
        ["POWOP", qr/\*\*/],
        ["POSTINC", qr/\+\+/],
        ["POSTDEC", qr/--/],
        ["DOLSHARP", qr/\$#/],
        ["ASSIGNOP", qr/(=)|(\.=)/],
        ["ADDOP", qr/[+-.]/],
        ["RELOP", qr/(>)|(<)|(<=)|(>=)|(lt)|(gt)|(le)|(ge)/],
        ["MULOP", qr/[\/%*x]/],
        ["OROR", qr/\|\|/],
        [",", qr/,/],
        ["!", qr/!/],
        [")", qr/\)/],
        ["(", qr/\(/],
        ["{", qr/\{/],
        ["}", qr/\}/],
        ["[", qr/\[/],
        ["]", qr/\]/],
        ["&", qr/\&/],
        ["@", qr/\@/],
        ["%", qr/\%/],
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
    else {
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
			"+" => 34,
			'FOR' => 33,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'DOLSHARP' => 36,
			"!" => 14,
			'IF' => 17,
			"\$" => 16,
			'error' => 42,
			'LOOPEX' => 41,
			'WHILE' => 44,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'SUB' => 25,
			"{" => 49,
			'UNIOP' => 48,
			"&" => 47,
			'USE' => 51,
			"(" => 29,
			'format' => 52,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 31,
			'sideff' => 32,
			'term' => 37,
			'loop' => 13,
			'ary' => 12,
			'use' => 40,
			'expr' => 39,
			'decl' => 15,
			'termbinop' => 18,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20,
			'line' => 21,
			'cond' => 24,
			'arylen' => 46,
			'amper' => 26,
			'myattrterm' => 27,
			'subscripted' => 28,
			'package' => 50,
			'block' => 53,
			'argexpr' => 54
		}
	},
	{#State 3
		DEFAULT => 0
	},
	{#State 4
		DEFAULT => -104
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 55,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 6
		ACTIONS => {
			"[" => 56
		},
		DEFAULT => -80
	},
	{#State 7
		ACTIONS => {
			'WORD' => 58,
			"\$" => 16,
			"{" => 49
		},
		GOTOS => {
			'scalar' => 57,
			'indirob' => 59,
			'block' => 60
		}
	},
	{#State 8
		ACTIONS => {
			'WORD' => 61,
			";" => 62
		}
	},
	{#State 9
		ACTIONS => {
			'WORD' => 58,
			"\$" => 16,
			"{" => 49
		},
		GOTOS => {
			'scalar' => 57,
			'indirob' => 63,
			'block' => 60
		}
	},
	{#State 10
		ACTIONS => {
			"(" => 67,
			"\@" => 7,
			"\$" => 16,
			"%" => 9
		},
		GOTOS => {
			'scalar' => 64,
			'myterm' => 68,
			'hsh' => 66,
			'ary' => 65
		}
	},
	{#State 11
		ACTIONS => {
			"-" => 5,
			'WORD' => 69,
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
			'FUNC' => 38,
			'LOOPEX' => 41,
			'FUNC0' => 45,
			"&" => 47,
			'UNIOP' => 48,
			"{" => 49
		},
		DEFAULT => -113,
		GOTOS => {
			'scalar' => 70,
			'arylen' => 46,
			'indirob' => 71,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'termbinop' => 18,
			'block' => 60,
			'argexpr' => 73,
			'listop' => 43,
			'listexpr' => 72,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 12
		ACTIONS => {
			"[" => 74,
			"{" => 75
		},
		DEFAULT => -82
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 76,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 15
		DEFAULT => -7
	},
	{#State 16
		ACTIONS => {
			'WORD' => 58,
			"\$" => 16,
			"{" => 49
		},
		GOTOS => {
			'scalar' => 57,
			'indirob' => 77,
			'block' => 60
		}
	},
	{#State 17
		ACTIONS => {
			"(" => 78
		}
	},
	{#State 18
		DEFAULT => -75
	},
	{#State 19
		DEFAULT => -81
	},
	{#State 20
		DEFAULT => -76
	},
	{#State 21
		DEFAULT => -8
	},
	{#State 22
		ACTIONS => {
			"(" => 79
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 80,
			'listop' => 43,
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
			'startsub' => 81
		}
	},
	{#State 26
		ACTIONS => {
			"(" => 82
		},
		DEFAULT => -89
	},
	{#State 27
		DEFAULT => -77
	},
	{#State 28
		DEFAULT => -84
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			")" => 84,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 83,
			'termbinop' => 18,
			'argexpr' => 54,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 30
		ACTIONS => {
			"(" => 85
		}
	},
	{#State 31
		DEFAULT => -37
	},
	{#State 32
		ACTIONS => {
			";" => 86
		}
	},
	{#State 33
		ACTIONS => {
			"(" => 89,
			"\$" => 16,
			'MY' => 88
		},
		GOTOS => {
			'scalar' => 87
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 90,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 35
		ACTIONS => {
			'WORD' => 91
		}
	},
	{#State 36
		ACTIONS => {
			'WORD' => 58,
			"\$" => 16,
			"{" => 49
		},
		GOTOS => {
			'scalar' => 57,
			'indirob' => 92,
			'block' => 60
		}
	},
	{#State 37
		ACTIONS => {
			'ADDOP' => 99,
			'ASSIGNOP' => 93,
			'POSTINC' => 100,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 101,
			'DOTDOT' => 102,
			'MULOP' => 103,
			'ANDAND' => 96,
			'OROR' => 104,
			'RELOP' => 98,
			'EQOP' => 97
		},
		DEFAULT => -54
	},
	{#State 38
		ACTIONS => {
			"(" => 105
		}
	},
	{#State 39
		ACTIONS => {
			'FOR' => 109,
			'OROP' => 108,
			'ANDOP' => 106,
			'IF' => 107,
			'WHILE' => 110
		},
		DEFAULT => -13
	},
	{#State 40
		DEFAULT => -39
	},
	{#State 41
		DEFAULT => -93
	},
	{#State 42
		DEFAULT => -12
	},
	{#State 43
		DEFAULT => -105
	},
	{#State 44
		ACTIONS => {
			"(" => 111
		}
	},
	{#State 45
		ACTIONS => {
			"(" => 112
		},
		DEFAULT => -98
	},
	{#State 46
		DEFAULT => -83
	},
	{#State 47
		ACTIONS => {
			'WORD' => 58,
			"\$" => 16,
			"{" => 49
		},
		GOTOS => {
			'scalar' => 57,
			'indirob' => 113,
			'block' => 60
		}
	},
	{#State 48
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
			'FUNC' => 38,
			'LOOPEX' => 41,
			'FUNC0' => 45,
			"&" => 47,
			'UNIOP' => 48,
			"{" => 49
		},
		DEFAULT => -95,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 114,
			'ary' => 12,
			'termbinop' => 18,
			'block' => 115,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 49
		DEFAULT => -3,
		GOTOS => {
			'remember' => 116
		}
	},
	{#State 50
		DEFAULT => -38
	},
	{#State 51
		DEFAULT => -41,
		GOTOS => {
			'startsub' => 117
		}
	},
	{#State 52
		DEFAULT => -36
	},
	{#State 53
		ACTIONS => {
			'CONTINUE' => 118
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 119
		}
	},
	{#State 54
		ACTIONS => {
			"," => 120
		},
		DEFAULT => -51
	},
	{#State 55
		ACTIONS => {
			'POSTINC' => 100,
			'POWOP' => 94,
			'POSTDEC' => 101
		},
		DEFAULT => -70
	},
	{#State 56
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 121,
			'termbinop' => 18,
			'argexpr' => 54,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 57
		DEFAULT => -125
	},
	{#State 58
		DEFAULT => -124
	},
	{#State 59
		DEFAULT => -121
	},
	{#State 60
		DEFAULT => -126
	},
	{#State 61
		ACTIONS => {
			";" => 122
		}
	},
	{#State 62
		DEFAULT => -46
	},
	{#State 63
		DEFAULT => -122
	},
	{#State 64
		DEFAULT => -110
	},
	{#State 65
		DEFAULT => -112
	},
	{#State 66
		DEFAULT => -111
	},
	{#State 67
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			")" => 124,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 123,
			'termbinop' => 18,
			'argexpr' => 54,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 68
		ACTIONS => {
			'myattrlist' => 125
		},
		DEFAULT => -107
	},
	{#State 69
		ACTIONS => {
			"-" => -124,
			'WORD' => -124,
			"\@" => -124,
			"%" => -124,
			'MY' => -124,
			'LSTOP' => -124,
			"!" => -124,
			"\$" => -124,
			'NOTOP' => -124,
			'PMFUNC' => -124,
			"(" => -124,
			'FUNC1' => -124,
			"+" => -124,
			'NOAMP' => -124,
			'FUNC' => -124,
			'DOLSHARP' => -124,
			'LOOPEX' => -124,
			'FUNC0' => -124,
			"&" => -124,
			'UNIOP' => -124
		},
		DEFAULT => -104
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
			"[" => 56,
			'NOTOP' => -125,
			'PMFUNC' => -125,
			"(" => -125,
			'FUNC1' => -125,
			"+" => -125,
			'NOAMP' => -125,
			'FUNC' => -125,
			'DOLSHARP' => -125,
			'LOOPEX' => -125,
			'FUNC0' => -125,
			"&" => -125,
			'UNIOP' => -125
		},
		DEFAULT => -80
	},
	{#State 71
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 126,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 72
		DEFAULT => -57
	},
	{#State 73
		ACTIONS => {
			"," => 120
		},
		DEFAULT => -114
	},
	{#State 74
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 127,
			'termbinop' => 18,
			'argexpr' => 54,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 128,
			'termbinop' => 18,
			'argexpr' => 54,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 76
		ACTIONS => {
			'POSTINC' => 100,
			'POWOP' => 94,
			'POSTDEC' => 101
		},
		DEFAULT => -72
	},
	{#State 77
		DEFAULT => -120
	},
	{#State 78
		DEFAULT => -3,
		GOTOS => {
			'remember' => 129
		}
	},
	{#State 79
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 130,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 80
		ACTIONS => {
			"," => 120
		},
		DEFAULT => -94
	},
	{#State 81
		ACTIONS => {
			'WORD' => 131
		},
		GOTOS => {
			'subname' => 132
		}
	},
	{#State 82
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			")" => 134,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 133,
			'termbinop' => 18,
			'argexpr' => 54,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 83
		ACTIONS => {
			'OROP' => 108,
			")" => 135,
			'ANDOP' => 106
		}
	},
	{#State 84
		ACTIONS => {
			"[" => 136
		},
		DEFAULT => -79
	},
	{#State 85
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			")" => 138,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 137,
			'termbinop' => 18,
			'argexpr' => 54,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 86
		DEFAULT => -11
	},
	{#State 87
		ACTIONS => {
			"(" => 139
		}
	},
	{#State 88
		DEFAULT => -3,
		GOTOS => {
			'remember' => 140
		}
	},
	{#State 89
		DEFAULT => -3,
		GOTOS => {
			'remember' => 141
		}
	},
	{#State 90
		ACTIONS => {
			'POSTINC' => 100,
			'POWOP' => 94,
			'POSTDEC' => 101
		},
		DEFAULT => -71
	},
	{#State 91
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
			'FUNC' => 38,
			'LOOPEX' => 41,
			'FUNC0' => 45,
			"&" => 47,
			'UNIOP' => 48
		},
		DEFAULT => -113,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 73,
			'listop' => 43,
			'listexpr' => 142,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 92
		DEFAULT => -123
	},
	{#State 93
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 143,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 144,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 43,
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 145,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 43,
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 146,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 43,
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 147,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 43,
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 148,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 43,
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 149,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 100
		DEFAULT => -73
	},
	{#State 101
		DEFAULT => -74
	},
	{#State 102
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 150,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 151,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 43,
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 152,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 105
		ACTIONS => {
			"-" => 5,
			'WORD' => 69,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'FUNC' => 38,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			"{" => 49,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		DEFAULT => -115,
		GOTOS => {
			'scalar' => 70,
			'indirob' => 153,
			'term' => 37,
			'ary' => 12,
			'expr' => 155,
			'termbinop' => 18,
			'listexprcom' => 154,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20,
			'arylen' => 46,
			'amper' => 26,
			'myattrterm' => 27,
			'subscripted' => 28,
			'block' => 60,
			'argexpr' => 54
		}
	},
	{#State 106
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 156,
			'termbinop' => 18,
			'argexpr' => 54,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 157,
			'termbinop' => 18,
			'argexpr' => 54,
			'listop' => 43,
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 158,
			'termbinop' => 18,
			'argexpr' => 54,
			'listop' => 43,
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 159,
			'termbinop' => 18,
			'argexpr' => 54,
			'listop' => 43,
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 160,
			'termbinop' => 18,
			'argexpr' => 54,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 111
		DEFAULT => -3,
		GOTOS => {
			'remember' => 161
		}
	},
	{#State 112
		ACTIONS => {
			")" => 162
		}
	},
	{#State 113
		DEFAULT => -119
	},
	{#State 114
		ACTIONS => {
			'ADDOP' => 99,
			'POSTINC' => 100,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 101,
			'MULOP' => 103
		},
		DEFAULT => -97
	},
	{#State 115
		DEFAULT => -96
	},
	{#State 116
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 163
		}
	},
	{#State 117
		DEFAULT => -47,
		GOTOS => {
			'@1-2' => 164
		}
	},
	{#State 118
		ACTIONS => {
			"{" => 49
		},
		GOTOS => {
			'block' => 165
		}
	},
	{#State 119
		DEFAULT => -28
	},
	{#State 120
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
			'FUNC' => 38,
			'LOOPEX' => 41,
			'FUNC0' => 45,
			"&" => 47,
			'UNIOP' => 48
		},
		DEFAULT => -52,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 166,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 121
		ACTIONS => {
			'OROP' => 108,
			"]" => 167,
			'ANDOP' => 106
		}
	},
	{#State 122
		DEFAULT => -45
	},
	{#State 123
		ACTIONS => {
			'OROP' => 108,
			")" => 168,
			'ANDOP' => 106
		}
	},
	{#State 124
		DEFAULT => -109
	},
	{#State 125
		DEFAULT => -106
	},
	{#State 126
		ACTIONS => {
			"," => 120
		},
		DEFAULT => -55
	},
	{#State 127
		ACTIONS => {
			'OROP' => 108,
			"]" => 169,
			'ANDOP' => 106
		}
	},
	{#State 128
		ACTIONS => {
			";" => 170,
			'OROP' => 108,
			'ANDOP' => 106
		}
	},
	{#State 129
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'mexpr' => 171,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 172,
			'termbinop' => 18,
			'argexpr' => 54,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 130
		ACTIONS => {
			'MATCHOP' => 95,
			'POSTDEC' => 101,
			'MULOP' => 103,
			'DOTDOT' => 102,
			'ADDOP' => 99,
			"," => 173,
			'ASSIGNOP' => 93,
			'OROR' => 104,
			'POSTINC' => 100,
			'ANDAND' => 96,
			")" => 174,
			'POWOP' => 94,
			'EQOP' => 97,
			'RELOP' => 98
		}
	},
	{#State 131
		DEFAULT => -42
	},
	{#State 132
		ACTIONS => {
			";" => 176,
			"{" => 49
		},
		GOTOS => {
			'block' => 177,
			'subbody' => 175
		}
	},
	{#State 133
		ACTIONS => {
			'OROP' => 108,
			")" => 178,
			'ANDOP' => 106
		}
	},
	{#State 134
		DEFAULT => -90
	},
	{#State 135
		ACTIONS => {
			"[" => 179
		},
		DEFAULT => -78
	},
	{#State 136
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 180,
			'termbinop' => 18,
			'argexpr' => 54,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 137
		ACTIONS => {
			'OROP' => 108,
			")" => 181,
			'ANDOP' => 106
		}
	},
	{#State 138
		DEFAULT => -100
	},
	{#State 139
		DEFAULT => -3,
		GOTOS => {
			'remember' => 182
		}
	},
	{#State 140
		ACTIONS => {
			"\$" => 16
		},
		GOTOS => {
			'scalar' => 183,
			'my_scalar' => 184
		}
	},
	{#State 141
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'error' => 42,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'mexpr' => 185,
			'scalar' => 6,
			'sideff' => 187,
			'term' => 37,
			'ary' => 12,
			'expr' => 188,
			'nexpr' => 189,
			'termbinop' => 18,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20,
			'arylen' => 46,
			'mnexpr' => 186,
			'amper' => 26,
			'myattrterm' => 27,
			'subscripted' => 28,
			'argexpr' => 54
		}
	},
	{#State 142
		DEFAULT => -92
	},
	{#State 143
		ACTIONS => {
			'ADDOP' => 99,
			'ASSIGNOP' => 93,
			'POSTINC' => 100,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 101,
			'DOTDOT' => 102,
			'MULOP' => 103,
			'ANDAND' => 96,
			'OROR' => 104,
			'RELOP' => 98,
			'EQOP' => 97
		},
		DEFAULT => -60
	},
	{#State 144
		ACTIONS => {
			'POSTINC' => 100,
			'POWOP' => 94,
			'POSTDEC' => 101
		},
		DEFAULT => -61
	},
	{#State 145
		ACTIONS => {
			'POSTINC' => 100,
			'POWOP' => 94,
			'POSTDEC' => 101
		},
		DEFAULT => -69
	},
	{#State 146
		ACTIONS => {
			'ADDOP' => 99,
			'POSTINC' => 100,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 101,
			'MULOP' => 103,
			'RELOP' => 98,
			'EQOP' => 97
		},
		DEFAULT => -67
	},
	{#State 147
		ACTIONS => {
			'ADDOP' => 99,
			'POSTINC' => 100,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 101,
			'MULOP' => 103,
			'RELOP' => 98,
			'EQOP' => undef
		},
		DEFAULT => -65
	},
	{#State 148
		ACTIONS => {
			'ADDOP' => 99,
			'POSTINC' => 100,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 101,
			'MULOP' => 103,
			'RELOP' => undef
		},
		DEFAULT => -64
	},
	{#State 149
		ACTIONS => {
			'POSTINC' => 100,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 101,
			'MULOP' => 103
		},
		DEFAULT => -63
	},
	{#State 150
		ACTIONS => {
			'ADDOP' => 99,
			'POSTINC' => 100,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 101,
			'DOTDOT' => undef,
			'MULOP' => 103,
			'ANDAND' => 96,
			'OROR' => 104,
			'RELOP' => 98,
			'EQOP' => 97
		},
		DEFAULT => -66
	},
	{#State 151
		ACTIONS => {
			'POSTINC' => 100,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 101
		},
		DEFAULT => -62
	},
	{#State 152
		ACTIONS => {
			'ADDOP' => 99,
			'POSTINC' => 100,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 101,
			'MULOP' => 103,
			'ANDAND' => 96,
			'RELOP' => 98,
			'EQOP' => 97
		},
		DEFAULT => -68
	},
	{#State 153
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 190,
			'termbinop' => 18,
			'argexpr' => 54,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 154
		ACTIONS => {
			")" => 191
		}
	},
	{#State 155
		ACTIONS => {
			'OROP' => 108,
			"," => 192,
			'ANDOP' => 106
		},
		DEFAULT => -116
	},
	{#State 156
		DEFAULT => -49
	},
	{#State 157
		ACTIONS => {
			'OROP' => 108,
			'ANDOP' => 106
		},
		DEFAULT => -14
	},
	{#State 158
		ACTIONS => {
			'ANDOP' => 106
		},
		DEFAULT => -50
	},
	{#State 159
		ACTIONS => {
			'OROP' => 108,
			'ANDOP' => 106
		},
		DEFAULT => -16
	},
	{#State 160
		ACTIONS => {
			'OROP' => 108,
			'ANDOP' => 106
		},
		DEFAULT => -15
	},
	{#State 161
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		DEFAULT => -31,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 195,
			'texpr' => 193,
			'termbinop' => 18,
			'mtexpr' => 194,
			'argexpr' => 54,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 162
		DEFAULT => -99
	},
	{#State 163
		ACTIONS => {
			"}" => 196,
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
			'DOLSHARP' => 36,
			"!" => 14,
			'IF' => 17,
			"\$" => 16,
			'error' => 42,
			'LOOPEX' => 41,
			'WHILE' => 44,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'SUB' => 25,
			"{" => 49,
			'UNIOP' => 48,
			"&" => 47,
			'USE' => 51,
			"(" => 29,
			'format' => 52,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 31,
			'sideff' => 32,
			'term' => 37,
			'loop' => 13,
			'ary' => 12,
			'expr' => 39,
			'use' => 40,
			'decl' => 15,
			'termbinop' => 18,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20,
			'line' => 21,
			'cond' => 24,
			'arylen' => 46,
			'amper' => 26,
			'myattrterm' => 27,
			'subscripted' => 28,
			'package' => 50,
			'block' => 53,
			'argexpr' => 54
		}
	},
	{#State 164
		ACTIONS => {
			'WORD' => 197
		}
	},
	{#State 165
		DEFAULT => -22
	},
	{#State 166
		ACTIONS => {
			'ADDOP' => 99,
			'ASSIGNOP' => 93,
			'POSTINC' => 100,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 101,
			'DOTDOT' => 102,
			'MULOP' => 103,
			'ANDAND' => 96,
			'OROR' => 104,
			'RELOP' => 98,
			'EQOP' => 97
		},
		DEFAULT => -53
	},
	{#State 167
		DEFAULT => -59
	},
	{#State 168
		DEFAULT => -108
	},
	{#State 169
		DEFAULT => -87
	},
	{#State 170
		ACTIONS => {
			"}" => 198
		}
	},
	{#State 171
		ACTIONS => {
			")" => 199
		}
	},
	{#State 172
		ACTIONS => {
			'OROP' => 108,
			'ANDOP' => 106
		},
		DEFAULT => -33
	},
	{#State 173
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 200,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 174
		DEFAULT => -102
	},
	{#State 175
		DEFAULT => -40
	},
	{#State 176
		DEFAULT => -44
	},
	{#State 177
		DEFAULT => -43
	},
	{#State 178
		DEFAULT => -91
	},
	{#State 179
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 201,
			'termbinop' => 18,
			'argexpr' => 54,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 180
		ACTIONS => {
			'OROP' => 108,
			"]" => 202,
			'ANDOP' => 106
		}
	},
	{#State 181
		DEFAULT => -101
	},
	{#State 182
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'mexpr' => 203,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 172,
			'termbinop' => 18,
			'argexpr' => 54,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 183
		DEFAULT => -118
	},
	{#State 184
		ACTIONS => {
			"(" => 204
		}
	},
	{#State 185
		ACTIONS => {
			")" => 205
		}
	},
	{#State 186
		ACTIONS => {
			";" => 206
		}
	},
	{#State 187
		DEFAULT => -30
	},
	{#State 188
		ACTIONS => {
			'FOR' => 109,
			'OROP' => 108,
			'ANDOP' => 106,
			'IF' => 107,
			")" => -33,
			'WHILE' => 110
		},
		DEFAULT => -13
	},
	{#State 189
		DEFAULT => -34
	},
	{#State 190
		ACTIONS => {
			'OROP' => 108,
			")" => 207,
			'ANDOP' => 106
		}
	},
	{#State 191
		DEFAULT => -58
	},
	{#State 192
		DEFAULT => -117
	},
	{#State 193
		DEFAULT => -35
	},
	{#State 194
		ACTIONS => {
			")" => 208
		}
	},
	{#State 195
		ACTIONS => {
			'OROP' => 108,
			'ANDOP' => 106
		},
		DEFAULT => -32
	},
	{#State 196
		DEFAULT => -2
	},
	{#State 197
		ACTIONS => {
			'WORD' => 209
		}
	},
	{#State 198
		DEFAULT => -88
	},
	{#State 199
		ACTIONS => {
			"{" => 210
		},
		GOTOS => {
			'mblock' => 211
		}
	},
	{#State 200
		ACTIONS => {
			'MATCHOP' => 95,
			'POSTDEC' => 101,
			'MULOP' => 103,
			'DOTDOT' => 102,
			'ADDOP' => 99,
			'ASSIGNOP' => 93,
			'OROR' => 104,
			'ANDAND' => 96,
			'POSTINC' => 100,
			")" => 212,
			'POWOP' => 94,
			'EQOP' => 97,
			'RELOP' => 98
		}
	},
	{#State 201
		ACTIONS => {
			'OROP' => 108,
			"]" => 213,
			'ANDOP' => 106
		}
	},
	{#State 202
		DEFAULT => -86
	},
	{#State 203
		ACTIONS => {
			")" => 214
		}
	},
	{#State 204
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'mexpr' => 215,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 172,
			'termbinop' => 18,
			'argexpr' => 54,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 205
		ACTIONS => {
			"{" => 210
		},
		GOTOS => {
			'mblock' => 216
		}
	},
	{#State 206
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		DEFAULT => -31,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 195,
			'texpr' => 193,
			'termbinop' => 18,
			'mtexpr' => 217,
			'argexpr' => 54,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 207
		DEFAULT => -56
	},
	{#State 208
		ACTIONS => {
			"{" => 210
		},
		GOTOS => {
			'mblock' => 218
		}
	},
	{#State 209
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		DEFAULT => -113,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 73,
			'listop' => 43,
			'listexpr' => 219,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 210
		DEFAULT => -5,
		GOTOS => {
			'mremember' => 220
		}
	},
	{#State 211
		ACTIONS => {
			'ELSE' => 221,
			'ELSIF' => 223
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 222
		}
	},
	{#State 212
		DEFAULT => -103
	},
	{#State 213
		DEFAULT => -85
	},
	{#State 214
		ACTIONS => {
			"{" => 210
		},
		GOTOS => {
			'mblock' => 224
		}
	},
	{#State 215
		ACTIONS => {
			")" => 225
		}
	},
	{#State 216
		ACTIONS => {
			'CONTINUE' => 118
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 226
		}
	},
	{#State 217
		ACTIONS => {
			";" => 227
		}
	},
	{#State 218
		ACTIONS => {
			'CONTINUE' => 118
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 228
		}
	},
	{#State 219
		ACTIONS => {
			";" => 229
		}
	},
	{#State 220
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 230
		}
	},
	{#State 221
		ACTIONS => {
			"{" => 210
		},
		GOTOS => {
			'mblock' => 231
		}
	},
	{#State 222
		DEFAULT => -20
	},
	{#State 223
		ACTIONS => {
			"(" => 232
		}
	},
	{#State 224
		ACTIONS => {
			'CONTINUE' => 118
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 233
		}
	},
	{#State 225
		ACTIONS => {
			"{" => 210
		},
		GOTOS => {
			'mblock' => 234
		}
	},
	{#State 226
		DEFAULT => -26
	},
	{#State 227
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'error' => 42,
			'LOOPEX' => 41,
			")" => -29,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'sideff' => 187,
			'term' => 37,
			'ary' => 12,
			'expr' => 39,
			'nexpr' => 189,
			'termbinop' => 18,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20,
			'arylen' => 46,
			'mnexpr' => 235,
			'amper' => 26,
			'myattrterm' => 27,
			'subscripted' => 28,
			'argexpr' => 54
		}
	},
	{#State 228
		DEFAULT => -23
	},
	{#State 229
		DEFAULT => -48
	},
	{#State 230
		ACTIONS => {
			"}" => 236,
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
			'DOLSHARP' => 36,
			"!" => 14,
			'IF' => 17,
			"\$" => 16,
			'error' => 42,
			'LOOPEX' => 41,
			'WHILE' => 44,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'SUB' => 25,
			"{" => 49,
			'UNIOP' => 48,
			"&" => 47,
			'USE' => 51,
			"(" => 29,
			'format' => 52,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 31,
			'sideff' => 32,
			'term' => 37,
			'loop' => 13,
			'ary' => 12,
			'expr' => 39,
			'use' => 40,
			'decl' => 15,
			'termbinop' => 18,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20,
			'line' => 21,
			'cond' => 24,
			'arylen' => 46,
			'amper' => 26,
			'myattrterm' => 27,
			'subscripted' => 28,
			'package' => 50,
			'block' => 53,
			'argexpr' => 54
		}
	},
	{#State 231
		DEFAULT => -18
	},
	{#State 232
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
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 41,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 45,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'mexpr' => 237,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 37,
			'ary' => 12,
			'expr' => 172,
			'termbinop' => 18,
			'argexpr' => 54,
			'listop' => 43,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 233
		DEFAULT => -25
	},
	{#State 234
		ACTIONS => {
			'CONTINUE' => 118
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 238
		}
	},
	{#State 235
		ACTIONS => {
			")" => 239
		}
	},
	{#State 236
		DEFAULT => -4
	},
	{#State 237
		ACTIONS => {
			")" => 240
		}
	},
	{#State 238
		DEFAULT => -24
	},
	{#State 239
		ACTIONS => {
			"{" => 210
		},
		GOTOS => {
			'mblock' => 241
		}
	},
	{#State 240
		ACTIONS => {
			"{" => 210
		},
		GOTOS => {
			'mblock' => 242
		}
	},
	{#State 241
		DEFAULT => -27
	},
	{#State 242
		ACTIONS => {
			'ELSE' => 221,
			'ELSIF' => 223
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 243
		}
	},
	{#State 243
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
#line 161 "plpy.yp"
{# $$ = $1; newPROG(block_end($1,$2));
            }
	],
	[#Rule 2
		 'block', 4,
sub
#line 167 "plpy.yp"
{# /* if (PL_copline > (line_t)$1)
             #     PL_copline = (line_t)$1;
             # $$ = block_end($2, $3); */
             }
	],
	[#Rule 3
		 'remember', 0,
sub
#line 174 "plpy.yp"
{# $$ = block_start(TRUE);
            }
	],
	[#Rule 4
		 'mblock', 4,
sub
#line 179 "plpy.yp"
{#/* if (PL_copline > (line_t)$1)
             #     PL_copline = (line_t)$1;
             # $$ = block_end($2, $3); */
             }
	],
	[#Rule 5
		 'mremember', 0,
sub
#line 186 "plpy.yp"
{# $$ = block_start(FALSE);
            }
	],
	[#Rule 6
		 'lineseq', 0,
sub
#line 192 "plpy.yp"
{# $$ = Nullop;
             }
	],
	[#Rule 7
		 'lineseq', 2,
sub
#line 195 "plpy.yp"
{# $$ = $1;
             }
	],
	[#Rule 8
		 'lineseq', 2,
sub
#line 198 "plpy.yp"
{#/*   $$ = append_list(OP_LINESEQ,
            #    (LISTOP*)$1, (LISTOP*)$2);
                #PL_pad_reset_pending = TRUE;
                #if ($1 && $2) PL_hints |= HINT_BLOCK_SCOPE;*/
                }
	],
	[#Rule 9
		 'line', 1,
sub
#line 207 "plpy.yp"
{# $$ = newSTATEOP(0, $1, $2);
            }
	],
	[#Rule 10
		 'line', 1, undef
	],
	[#Rule 11
		 'line', 2,
sub
#line 222 "plpy.yp"
{#$$ = newSTATEOP(0, $1, $2);
            #PL_expect = XSTATE;
            }
	],
	[#Rule 12
		 'sideff', 1,
sub
#line 229 "plpy.yp"
{# $$ = Nullop;
            }
	],
	[#Rule 13
		 'sideff', 1,
sub
#line 232 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 14
		 'sideff', 3,
sub
#line 235 "plpy.yp"
{#$$ = newLOGOP(OP_AND, 0, $3, $1);
            }
	],
	[#Rule 15
		 'sideff', 3,
sub
#line 242 "plpy.yp"
{# $$ = newLOOPOP(OPf_PARENS, 1, scalar($3), $1);
            }
	],
	[#Rule 16
		 'sideff', 3,
sub
#line 247 "plpy.yp"
{#/* $$ = newFOROP(0, Nullch, (line_t)$2,
                #Nullop, $3, $1, Nullop); */
                }
	],
	[#Rule 17
		 'else', 0,
sub
#line 254 "plpy.yp"
{# $$ = Nullop;
            }
	],
	[#Rule 18
		 'else', 2,
sub
#line 257 "plpy.yp"
{# ($2)->op_flags |= OPf_PARENS; $$ = scope($2);
            }
	],
	[#Rule 19
		 'else', 6,
sub
#line 260 "plpy.yp"
{#/* PL_copline = (line_t)$1;
                #$$ = newCONDOP(0, $3, scope($5), $6);
                #PL_hints |= HINT_BLOCK_SCOPE; */
                }
	],
	[#Rule 20
		 'cond', 7,
sub
#line 268 "plpy.yp"
{ #/*PL_copline = (line_t)$1;
              #  $$ = block_end($3,
            #       newCONDOP(0, $4, scope($6), $7)); */
            }
	],
	[#Rule 21
		 'cont', 0,
sub
#line 282 "plpy.yp"
{# $$ = Nullop;
            }
	],
	[#Rule 22
		 'cont', 2,
sub
#line 285 "plpy.yp"
{# $$ = scope($2);
            }
	],
	[#Rule 23
		 'loop', 7,
sub
#line 291 "plpy.yp"
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
#line 306 "plpy.yp"
{#/* $$ = block_end($4,
                #newFOROP(0, $1, (line_t)$2, $5, $7, $9, $10)); */
            }
	],
	[#Rule 25
		 'loop', 8,
sub
#line 310 "plpy.yp"
{#/* $$ = block_end($5,
                #newFOROP(0, $1, (line_t)$2, mod($3, OP_ENTERLOOP),
                      #$6, $8, $9)); */
                      }
	],
	[#Rule 26
		 'loop', 7,
sub
#line 315 "plpy.yp"
{#/* $$ = block_end($4,
                 #newFOROP(0, $1, (line_t)$2, Nullop, $5, $7, $8)); */
                 }
	],
	[#Rule 27
		 'loop', 10,
sub
#line 320 "plpy.yp"
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
#line 336 "plpy.yp"
{#/* $$ = newSTATEOP(0, $1,
                 #newWHILEOP(0, 1, (LOOP*)Nullop,
                        #NOLINE, Nullop, $2, $3)); */
            }
	],
	[#Rule 29
		 'nexpr', 0,
sub
#line 344 "plpy.yp"
{# $$ = Nullop;
            }
	],
	[#Rule 30
		 'nexpr', 1, undef
	],
	[#Rule 31
		 'texpr', 0,
sub
#line 351 "plpy.yp"
{# (void)scan_num("1", &yylval); $$ = yylval.opval;
            }
	],
	[#Rule 32
		 'texpr', 1, undef
	],
	[#Rule 33
		 'mexpr', 1,
sub
#line 365 "plpy.yp"
{# $$ = $1; intro_my();
            }
	],
	[#Rule 34
		 'mnexpr', 1,
sub
#line 370 "plpy.yp"
{# $$ = $1; intro_my();
            }
	],
	[#Rule 35
		 'mtexpr', 1,
sub
#line 375 "plpy.yp"
{# $$ = $1; intro_my();
            }
	],
	[#Rule 36
		 'decl', 1,
sub
#line 394 "plpy.yp"
{# $$ = 0;
            }
	],
	[#Rule 37
		 'decl', 1,
sub
#line 397 "plpy.yp"
{# $$ = 0;
            }
	],
	[#Rule 38
		 'decl', 1,
sub
#line 404 "plpy.yp"
{# $$ = 0; */
            }
	],
	[#Rule 39
		 'decl', 1,
sub
#line 407 "plpy.yp"
{# $$ = 0;
            }
	],
	[#Rule 40
		 'subrout', 4,
sub
#line 428 "plpy.yp"
{# newATTRSUB($2, $3, $4, $5, $6);
            }
	],
	[#Rule 41
		 'startsub', 0,
sub
#line 433 "plpy.yp"
{# $$ = start_subparse(FALSE, 0);
            }
	],
	[#Rule 42
		 'subname', 1,
sub
#line 449 "plpy.yp"
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
#line 484 "plpy.yp"
{/* $$ = $1; */}
	],
	[#Rule 44
		 'subbody', 1,
sub
#line 485 "plpy.yp"
{# $$ = Nullop; PL_expect = XSTATE;
            }
	],
	[#Rule 45
		 'package', 3,
sub
#line 490 "plpy.yp"
{# package($2);
            }
	],
	[#Rule 46
		 'package', 2,
sub
#line 493 "plpy.yp"
{# package(Nullop);
            }
	],
	[#Rule 47
		 '@1-2', 0,
sub
#line 498 "plpy.yp"
{# CvSPECIAL_on(PL_compcv); /* It's a BEGIN {} */
            }
	],
	[#Rule 48
		 'use', 7,
sub
#line 501 "plpy.yp"
{# utilize($1, $2, $4, $5, $6);
            }
	],
	[#Rule 49
		 'expr', 3,
sub
#line 507 "plpy.yp"
{# $$ = newLOGOP(OP_AND, 0, $1, $3);
            }
	],
	[#Rule 50
		 'expr', 3,
sub
#line 510 "plpy.yp"
{# $$ = newLOGOP($2, 0, $1, $3);
            }
	],
	[#Rule 51
		 'expr', 1, undef
	],
	[#Rule 52
		 'argexpr', 2,
sub
#line 517 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 53
		 'argexpr', 3,
sub
#line 520 "plpy.yp"
{# $$ = append_elem(OP_LIST, $1, $3);
            }
	],
	[#Rule 54
		 'argexpr', 1, undef
	],
	[#Rule 55
		 'listop', 3,
sub
#line 527 "plpy.yp"
{# $$ = convert($1, OPf_STACKED,
                #prepend_elem(OP_LIST, newGVREF($1,$2), $3) );
            }
	],
	[#Rule 56
		 'listop', 5,
sub
#line 531 "plpy.yp"
{# $$ = convert($1, OPf_STACKED,
                #prepend_elem(OP_LIST, newGVREF($1,$3), $4) );
            }
	],
	[#Rule 57
		 'listop', 2,
sub
#line 556 "plpy.yp"
{# $$ = convert($1, 0, $2);
            }
	],
	[#Rule 58
		 'listop', 4,
sub
#line 559 "plpy.yp"
{# $$ = convert($1, 0, $3);
            }
	],
	[#Rule 59
		 'subscripted', 4,
sub
#line 588 "plpy.yp"
{# $$ = newBINOP(OP_AELEM, 0, oopsAV($1), scalar($3));
            }
	],
	[#Rule 60
		 'termbinop', 3,
sub
#line 632 "plpy.yp"
{# $$ = newASSIGNOP(OPf_STACKED, $1, $2, $3);
            }
	],
	[#Rule 61
		 'termbinop', 3,
sub
#line 635 "plpy.yp"
{# $$ = newBINOP($2, 0, scalar($1), scalar($3));
            }
	],
	[#Rule 62
		 'termbinop', 3,
sub
#line 638 "plpy.yp"
{#   if ($2 != OP_REPEAT)
                #scalar($1);
               # $$ = newBINOP($2, 0, $1, scalar($3));
            }
	],
	[#Rule 63
		 'termbinop', 3,
sub
#line 643 "plpy.yp"
{# $$ = newBINOP($2, 0, scalar($1), scalar($3));
            }
	],
	[#Rule 64
		 'termbinop', 3,
sub
#line 650 "plpy.yp"
{# $$ = newBINOP($2, 0, scalar($1), scalar($3));
            }
	],
	[#Rule 65
		 'termbinop', 3,
sub
#line 653 "plpy.yp"
{# $$ = newBINOP($2, 0, scalar($1), scalar($3));
            }
	],
	[#Rule 66
		 'termbinop', 3,
sub
#line 662 "plpy.yp"
{# $$ = newRANGE($2, scalar($1), scalar($3));
            }
	],
	[#Rule 67
		 'termbinop', 3,
sub
#line 665 "plpy.yp"
{# $$ = newLOGOP(OP_AND, 0, $1, $3);
            }
	],
	[#Rule 68
		 'termbinop', 3,
sub
#line 668 "plpy.yp"
{# $$ = newLOGOP(OP_OR, 0, $1, $3);
            }
	],
	[#Rule 69
		 'termbinop', 3,
sub
#line 671 "plpy.yp"
{# $$ = bind_match($2, $1, $3);
            }
	],
	[#Rule 70
		 'termunop', 2,
sub
#line 677 "plpy.yp"
{# $$ = newUNOP(OP_NEGATE, 0, scalar($2));
            }
	],
	[#Rule 71
		 'termunop', 2,
sub
#line 680 "plpy.yp"
{# $$ = $2;
            }
	],
	[#Rule 72
		 'termunop', 2,
sub
#line 683 "plpy.yp"
{# $$ = newUNOP(OP_NOT, 0, scalar($2));
            }
	],
	[#Rule 73
		 'termunop', 2,
sub
#line 690 "plpy.yp"
{#$$ = newUNOP(OP_POSTINC, 0,
                    #mod(scalar($1), OP_POSTINC));
            }
	],
	[#Rule 74
		 'termunop', 2,
sub
#line 694 "plpy.yp"
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
		 'term', 1,
sub
#line 771 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 78
		 'term', 3,
sub
#line 778 "plpy.yp"
{# $$ = sawparens($2);
            }
	],
	[#Rule 79
		 'term', 2,
sub
#line 781 "plpy.yp"
{# $$ = sawparens(newNULLLIST());
            }
	],
	[#Rule 80
		 'term', 1,
sub
#line 784 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 81
		 'term', 1,
sub
#line 791 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 82
		 'term', 1,
sub
#line 794 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 83
		 'term', 1,
sub
#line 797 "plpy.yp"
{# $$ = newUNOP(OP_AV2ARYLEN, 0, ref($1, OP_AV2ARYLEN));
            }
	],
	[#Rule 84
		 'term', 1,
sub
#line 800 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 85
		 'term', 6,
sub
#line 803 "plpy.yp"
{# $$ = newSLICEOP(0, $5, $2);
            }
	],
	[#Rule 86
		 'term', 5,
sub
#line 806 "plpy.yp"
{# $$ = newSLICEOP(0, $4, Nullop);
            }
	],
	[#Rule 87
		 'term', 4,
sub
#line 809 "plpy.yp"
{#$$ = prepend_elem(OP_ASLICE,
            #    newOP(OP_PUSHMARK, 0),
                    #newLISTOP(OP_ASLICE, 0,
                    #list($3),
                    #ref($1, OP_ASLICE)));
            }
	],
	[#Rule 88
		 'term', 5,
sub
#line 816 "plpy.yp"
{#$$ = prepend_elem(OP_HSLICE,
            #    newOP(OP_PUSHMARK, 0),
                    #newLISTOP(OP_HSLICE, 0,
                    #list($3),
                    #ref(oopsHV($1), OP_HSLICE)));
                #PL_expect = XOPERATOR; */
                }
	],
	[#Rule 89
		 'term', 1,
sub
#line 828 "plpy.yp"
{# $$ = newUNOP(OP_ENTERSUB, 0, scalar($1));
            }
	],
	[#Rule 90
		 'term', 3,
sub
#line 831 "plpy.yp"
{# $$ = newUNOP(OP_ENTERSUB, OPf_STACKED, scalar($1));
            }
	],
	[#Rule 91
		 'term', 4,
sub
#line 834 "plpy.yp"
{# $$ = newUNOP(OP_ENTERSUB, OPf_STACKED,
                #append_elem(OP_LIST, $3, scalar($1)));
                }
	],
	[#Rule 92
		 'term', 3,
sub
#line 838 "plpy.yp"
{# $$ = newUNOP(OP_ENTERSUB, OPf_STACKED,
                #append_elem(OP_LIST, $3, scalar($2)));
                }
	],
	[#Rule 93
		 'term', 1,
sub
#line 842 "plpy.yp"
{# $$ = newOP($1, OPf_SPECIAL);
                #PL_hints |= HINT_BLOCK_SCOPE;
                }
	],
	[#Rule 94
		 'term', 2,
sub
#line 850 "plpy.yp"
{# $$ = newUNOP(OP_NOT, 0, scalar($2));
            }
	],
	[#Rule 95
		 'term', 1,
sub
#line 853 "plpy.yp"
{# $$ = newOP($1, 0);
            }
	],
	[#Rule 96
		 'term', 2,
sub
#line 856 "plpy.yp"
{# $$ = newUNOP($1, 0, $2);
            }
	],
	[#Rule 97
		 'term', 2,
sub
#line 859 "plpy.yp"
{# $$ = newUNOP($1, 0, $2);
            }
	],
	[#Rule 98
		 'term', 1,
sub
#line 867 "plpy.yp"
{# $$ = newOP($1, 0);
            }
	],
	[#Rule 99
		 'term', 3,
sub
#line 870 "plpy.yp"
{# $$ = newOP($1, 0);
            }
	],
	[#Rule 100
		 'term', 3,
sub
#line 878 "plpy.yp"
{/* $$ = $1 == OP_NOT ? newUNOP($1, 0, newSVOP(OP_CONST, 0, newSViv(0)))
                        : newOP($1, OPf_SPECIAL); */}
	],
	[#Rule 101
		 'term', 4,
sub
#line 881 "plpy.yp"
{# $$ = newUNOP($1, 0, $3);
            }
	],
	[#Rule 102
		 'term', 4,
sub
#line 884 "plpy.yp"
{# $$ = pmruntime($1, $3, Nullop);
            }
	],
	[#Rule 103
		 'term', 6,
sub
#line 887 "plpy.yp"
{# $$ = pmruntime($1, $3, $5);
            }
	],
	[#Rule 104
		 'term', 1, undef
	],
	[#Rule 105
		 'term', 1, undef
	],
	[#Rule 106
		 'myattrterm', 3,
sub
#line 895 "plpy.yp"
{# $$ = my_attrs($2,$3);
            }
	],
	[#Rule 107
		 'myattrterm', 2,
sub
#line 898 "plpy.yp"
{# $$ = localize($2,$1);
            }
	],
	[#Rule 108
		 'myterm', 3,
sub
#line 904 "plpy.yp"
{# $$ = sawparens($2);
            }
	],
	[#Rule 109
		 'myterm', 2,
sub
#line 907 "plpy.yp"
{# $$ = sawparens(newNULLLIST());
            }
	],
	[#Rule 110
		 'myterm', 1,
sub
#line 910 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 111
		 'myterm', 1,
sub
#line 913 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 112
		 'myterm', 1,
sub
#line 916 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 113
		 'listexpr', 0,
sub
#line 922 "plpy.yp"
{# $$ = Nullop;
            }
	],
	[#Rule 114
		 'listexpr', 1,
sub
#line 925 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 115
		 'listexprcom', 0,
sub
#line 930 "plpy.yp"
{# $$ = Nullop;
            }
	],
	[#Rule 116
		 'listexprcom', 1,
sub
#line 933 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 117
		 'listexprcom', 2,
sub
#line 936 "plpy.yp"
{# $$ = $1;
            }
	],
	[#Rule 118
		 'my_scalar', 1,
sub
#line 943 "plpy.yp"
{# PL_in_my = 0; $$ = my($1);
            }
	],
	[#Rule 119
		 'amper', 2,
sub
#line 948 "plpy.yp"
{# $$ = newCVREF($1,$2);
            }
	],
	[#Rule 120
		 'scalar', 2,
sub
#line 953 "plpy.yp"
{# $$ = newSVREF($2);
            }
	],
	[#Rule 121
		 'ary', 2,
sub
#line 958 "plpy.yp"
{# $$ = newAVREF($2);
            }
	],
	[#Rule 122
		 'hsh', 2,
sub
#line 963 "plpy.yp"
{# $$ = newHVREF($2);
            }
	],
	[#Rule 123
		 'arylen', 2,
sub
#line 968 "plpy.yp"
{# $$ = newAVREF($2);
            }
	],
	[#Rule 124
		 'indirob', 1,
sub
#line 980 "plpy.yp"
{# $$ = scalar($1);
            }
	],
	[#Rule 125
		 'indirob', 1,
sub
#line 983 "plpy.yp"
{# $$ = scalar($1);
            }
	],
	[#Rule 126
		 'indirob', 1,
sub
#line 986 "plpy.yp"
{# $$ = scope($1);
            }
	]
],
                                  @_);
    bless($self,$class);
}

#line 994 "plpy.yp"

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
