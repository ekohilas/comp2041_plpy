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

sub getToken {
    my $uni = "chomp|exit|pop|shift|scalar|close|keys";
    my $lop = "print|printf|split|join|push|unshift|reverse|open|sort";
    my @tokens = (
        # matches a string with double or escaped quotes 
        ["STRING", qr/"(?:\\"|""|\\\\|[^"]|)*"/],
        # matches matching functions split (/foo/, $bar)
        ["PMFUNC", qr/split(?=\s*\(\s*\/)/],
        #matches all functions with brackets
        ["FUNC1", qr/(?:${uni})(?=\s*\()/],
        ["UNIOP", qr/(?:${uni})(?!\s*\()/],
        ["LSTOP", qr/(?:${lop})/],
        ["COMMENT", qr/\#.*/],
        ["FOR", qr/for|foreach/],
        ["WHILE", qr/while/],
        ["ELSIF", qr/elsif/],
        ["ELSE", qr/else/],
        #["CONTINUE", qr/next/],
        ["LOOPEX", qr/last|next/],
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
        ["FUNC", qr/\w+(?=\s*\()/a],
        ["WORD", qr/\w+/a]
    );

    $_[0]->YYData->{"DATA"} =~ s/^\s+//;
    if (1){
    print STDERR color('blue');
    print STDERR "___Remaining___\n", $_[0]->YYData->{"DATA"};
    print STDERR color('reset');
    }
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
        #print "$token : $&\n";
        return ($token, $&);
    }
    elsif (!$found && !length($_[0]->YYData->{"DATA"})) {
        return ('', undef);
    }
    else {
        print STDERR "unable to parse\n";
        print STDERR $_[0]->YYData->{"DATA"}, "\n";
        return ('', undef);
    }
}

sub Lexer {
    my ($type, $value) = getToken($_[0]);
    if (1){
    print STDERR color('red');
    print STDERR "Removed: (", color('reset'), "'$type': '$value'",
    color('red'), ")\n";
    print STDERR color('reset');
    }
    return ($type, $value);
    #return ('', undef);
}

sub printer{
    my @tokens = @{shift(@_)};
    my @words = @_;
    my $parser = shift(@tokens);
    my $word_string = shift(@words)." => ";
    $word_string .= join(" -> ", @words);
    my $token_string = "$words[0]"." => ";
    $token_string .= join(" -> ", @tokens);
    
    if (1){
    print STDERR color('green');
    print STDERR "$word_string\n";
    print STDERR "$token_string\n";
    print STDERR "\n";
    print STDERR color('reset');
    #print "('", $parser->YYCurtok, "': '", $parser->YYCurval, "')\n";
    #print "YYExpect: ", join("\n", $_[0]->YYExpect), "\n";
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
			'PACKAGE' => 8,
			"\@" => 7,
			"~" => 9,
			'COMMENT' => 12,
			'MY' => 11,
			"%" => 10,
			'LSTOP' => 13,
			"!" => 16,
			'IF' => 19,
			"\$" => 18,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'SUB' => 27,
			"(" => 31,
			'FUNC1' => 32,
			'FOR' => 35,
			"+" => 36,
			'NOAMP' => 37,
			'DOLSHARP' => 38,
			'FUNC' => 39,
			'STRING' => 41,
			'LOOPEX' => 44,
			'WHILE' => 45,
			"&" => 47,
			'UNIOP' => 48,
			"{" => 49,
			'USE' => 51,
			'format' => 52
		},
		DEFAULT => -1,
		GOTOS => {
			'scalar' => 6,
			'subrout' => 33,
			'sideff' => 34,
			'term' => 40,
			'loop' => 15,
			'ary' => 14,
			'use' => 43,
			'expr' => 42,
			'decl' => 17,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22,
			'line' => 23,
			'cond' => 26,
			'arylen' => 46,
			'amper' => 28,
			'myattrterm' => 29,
			'subscripted' => 30,
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
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 55,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 6
		ACTIONS => {
			"[" => 56
		},
		DEFAULT => -82
	},
	{#State 7
		ACTIONS => {
			'WORD' => 58,
			"\$" => 18,
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
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 63,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 10
		ACTIONS => {
			'WORD' => 58,
			"\$" => 18,
			"{" => 49
		},
		GOTOS => {
			'scalar' => 57,
			'indirob' => 64,
			'block' => 60
		}
	},
	{#State 11
		ACTIONS => {
			"(" => 68,
			"\@" => 7,
			"\$" => 18,
			"%" => 10
		},
		GOTOS => {
			'scalar' => 65,
			'myterm' => 69,
			'hsh' => 67,
			'ary' => 66
		}
	},
	{#State 12
		DEFAULT => -12
	},
	{#State 13
		ACTIONS => {
			"-" => 5,
			'WORD' => 70,
			"\@" => 7,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'LSTOP' => 13,
			"!" => 16,
			"\$" => 18,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			"(" => 31,
			'FUNC1' => 32,
			"+" => 36,
			'NOAMP' => 37,
			'DOLSHARP' => 38,
			'FUNC' => 39,
			'STRING' => 41,
			'LOOPEX' => 44,
			"&" => 47,
			'UNIOP' => 48,
			"{" => 49
		},
		DEFAULT => -116,
		GOTOS => {
			'scalar' => 71,
			'arylen' => 46,
			'indirob' => 72,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'termbinop' => 20,
			'block' => 60,
			'argexpr' => 74,
			'listexpr' => 73,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 14
		ACTIONS => {
			"[" => 75,
			"{" => 76
		},
		DEFAULT => -84
	},
	{#State 15
		DEFAULT => -10
	},
	{#State 16
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 77,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 17
		DEFAULT => -7
	},
	{#State 18
		ACTIONS => {
			'WORD' => 58,
			"\$" => 18,
			"{" => 49
		},
		GOTOS => {
			'scalar' => 57,
			'indirob' => 78,
			'block' => 60
		}
	},
	{#State 19
		ACTIONS => {
			"(" => 79
		}
	},
	{#State 20
		DEFAULT => -76
	},
	{#State 21
		DEFAULT => -83
	},
	{#State 22
		DEFAULT => -77
	},
	{#State 23
		DEFAULT => -8
	},
	{#State 24
		ACTIONS => {
			"(" => 80
		}
	},
	{#State 25
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'termbinop' => 20,
			'argexpr' => 81,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 26
		DEFAULT => -9
	},
	{#State 27
		DEFAULT => -41,
		GOTOS => {
			'startsub' => 82
		}
	},
	{#State 28
		ACTIONS => {
			"(" => 83
		},
		DEFAULT => -91
	},
	{#State 29
		DEFAULT => -79
	},
	{#State 30
		DEFAULT => -86
	},
	{#State 31
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			")" => 85,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 84,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 32
		ACTIONS => {
			"(" => 86
		}
	},
	{#State 33
		DEFAULT => -37
	},
	{#State 34
		ACTIONS => {
			";" => 87
		}
	},
	{#State 35
		ACTIONS => {
			"(" => 90,
			"\$" => 18,
			'MY' => 89
		},
		GOTOS => {
			'scalar' => 88
		}
	},
	{#State 36
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 91,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 37
		ACTIONS => {
			'WORD' => 92
		}
	},
	{#State 38
		ACTIONS => {
			'WORD' => 58,
			"\$" => 18,
			"{" => 49
		},
		GOTOS => {
			'scalar' => 57,
			'indirob' => 93,
			'block' => 60
		}
	},
	{#State 39
		ACTIONS => {
			"(" => 94
		}
	},
	{#State 40
		ACTIONS => {
			'BITANDOP' => 95,
			'ADDOP' => 103,
			'ASSIGNOP' => 96,
			'POSTINC' => 104,
			'BITOROP' => 105,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106,
			'DOTDOT' => 107,
			'MULOP' => 108,
			'BITXOROP' => 109,
			'SHIFTOP' => 99,
			'OROR' => 110,
			'ANDAND' => 100,
			'EQOP' => 101,
			'RELOP' => 102
		},
		DEFAULT => -54
	},
	{#State 41
		DEFAULT => -78
	},
	{#State 42
		ACTIONS => {
			'FOR' => 114,
			'OROP' => 113,
			'ANDOP' => 111,
			'IF' => 112,
			'WHILE' => 115
		},
		DEFAULT => -13
	},
	{#State 43
		DEFAULT => -39
	},
	{#State 44
		DEFAULT => -95
	},
	{#State 45
		ACTIONS => {
			"(" => 116
		}
	},
	{#State 46
		DEFAULT => -85
	},
	{#State 47
		ACTIONS => {
			'WORD' => 58,
			"\$" => 18,
			"{" => 49
		},
		GOTOS => {
			'scalar' => 57,
			'indirob' => 117,
			'block' => 60
		}
	},
	{#State 48
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'LSTOP' => 13,
			"!" => 16,
			"\$" => 18,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			"(" => 31,
			'FUNC1' => 32,
			"+" => 36,
			'NOAMP' => 37,
			'DOLSHARP' => 38,
			'FUNC' => 39,
			'STRING' => 41,
			'LOOPEX' => 44,
			"&" => 47,
			'UNIOP' => 48,
			"{" => 49
		},
		DEFAULT => -97,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 118,
			'ary' => 14,
			'termbinop' => 20,
			'block' => 119,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 49
		DEFAULT => -3,
		GOTOS => {
			'remember' => 120
		}
	},
	{#State 50
		DEFAULT => -38
	},
	{#State 51
		DEFAULT => -41,
		GOTOS => {
			'startsub' => 121
		}
	},
	{#State 52
		DEFAULT => -36
	},
	{#State 53
		ACTIONS => {
			'CONTINUE' => 122
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 123
		}
	},
	{#State 54
		ACTIONS => {
			"," => 124
		},
		DEFAULT => -51
	},
	{#State 55
		ACTIONS => {
			'POSTINC' => 104,
			'POWOP' => 97,
			'POSTDEC' => 106
		},
		DEFAULT => -70
	},
	{#State 56
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 125,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 57
		DEFAULT => -128
	},
	{#State 58
		DEFAULT => -127
	},
	{#State 59
		DEFAULT => -124
	},
	{#State 60
		DEFAULT => -129
	},
	{#State 61
		ACTIONS => {
			";" => 126
		}
	},
	{#State 62
		DEFAULT => -46
	},
	{#State 63
		ACTIONS => {
			'POSTINC' => 104,
			'POWOP' => 97,
			'POSTDEC' => 106
		},
		DEFAULT => -73
	},
	{#State 64
		DEFAULT => -125
	},
	{#State 65
		DEFAULT => -113
	},
	{#State 66
		DEFAULT => -115
	},
	{#State 67
		DEFAULT => -114
	},
	{#State 68
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			")" => 128,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 127,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 69
		ACTIONS => {
			'myattrlist' => 129
		},
		DEFAULT => -110
	},
	{#State 70
		ACTIONS => {
			"-" => -127,
			'WORD' => -127,
			"\@" => -127,
			"~" => -127,
			"%" => -127,
			'MY' => -127,
			'LSTOP' => -127,
			"!" => -127,
			"\$" => -127,
			'PMFUNC' => -127,
			'NOTOP' => -127,
			"(" => -127,
			'FUNC1' => -127,
			"+" => -127,
			'NOAMP' => -127,
			'DOLSHARP' => -127,
			'STRING' => -127,
			'FUNC' => -127,
			'LOOPEX' => -127,
			'UNIOP' => -127,
			"&" => -127
		},
		DEFAULT => -104
	},
	{#State 71
		ACTIONS => {
			"-" => -128,
			'WORD' => -128,
			"\@" => -128,
			"~" => -128,
			"%" => -128,
			'MY' => -128,
			'LSTOP' => -128,
			"!" => -128,
			"\$" => -128,
			"[" => 56,
			'PMFUNC' => -128,
			'NOTOP' => -128,
			"(" => -128,
			'FUNC1' => -128,
			"+" => -128,
			'NOAMP' => -128,
			'DOLSHARP' => -128,
			'STRING' => -128,
			'FUNC' => -128,
			'LOOPEX' => -128,
			'UNIOP' => -128,
			"&" => -128
		},
		DEFAULT => -82
	},
	{#State 72
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'termbinop' => 20,
			'argexpr' => 130,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 73
		DEFAULT => -107
	},
	{#State 74
		ACTIONS => {
			"," => 124
		},
		DEFAULT => -117
	},
	{#State 75
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 131,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 76
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 132,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 77
		ACTIONS => {
			'POSTINC' => 104,
			'POWOP' => 97,
			'POSTDEC' => 106
		},
		DEFAULT => -72
	},
	{#State 78
		DEFAULT => -123
	},
	{#State 79
		DEFAULT => -3,
		GOTOS => {
			'remember' => 133
		}
	},
	{#State 80
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 134,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 81
		ACTIONS => {
			"," => 124
		},
		DEFAULT => -96
	},
	{#State 82
		ACTIONS => {
			'WORD' => 135
		},
		GOTOS => {
			'subname' => 136
		}
	},
	{#State 83
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			")" => 138,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 137,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 84
		ACTIONS => {
			'OROP' => 113,
			")" => 139,
			'ANDOP' => 111
		}
	},
	{#State 85
		ACTIONS => {
			"[" => 140
		},
		DEFAULT => -81
	},
	{#State 86
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			")" => 142,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 141,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 87
		DEFAULT => -11
	},
	{#State 88
		ACTIONS => {
			"(" => 143
		}
	},
	{#State 89
		DEFAULT => -3,
		GOTOS => {
			'remember' => 144
		}
	},
	{#State 90
		DEFAULT => -3,
		GOTOS => {
			'remember' => 145
		}
	},
	{#State 91
		ACTIONS => {
			'POSTINC' => 104,
			'POWOP' => 97,
			'POSTDEC' => 106
		},
		DEFAULT => -71
	},
	{#State 92
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'LSTOP' => 13,
			"!" => 16,
			"\$" => 18,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			"(" => 31,
			'FUNC1' => 32,
			"+" => 36,
			'NOAMP' => 37,
			'DOLSHARP' => 38,
			'FUNC' => 39,
			'STRING' => 41,
			'LOOPEX' => 44,
			"&" => 47,
			'UNIOP' => 48
		},
		DEFAULT => -116,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'termbinop' => 20,
			'argexpr' => 74,
			'listexpr' => 146,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 93
		DEFAULT => -126
	},
	{#State 94
		ACTIONS => {
			"-" => 5,
			'WORD' => 70,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			"{" => 49,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		DEFAULT => -118,
		GOTOS => {
			'scalar' => 71,
			'arylen' => 46,
			'indirob' => 147,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 149,
			'termbinop' => 20,
			'listexprcom' => 148,
			'block' => 60,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 95
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 150,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 96
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 151,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 97
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 152,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 98
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 153,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 99
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 154,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 100
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 155,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 101
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 156,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 102
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 157,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 103
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 158,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 104
		DEFAULT => -74
	},
	{#State 105
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 159,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 106
		DEFAULT => -75
	},
	{#State 107
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 160,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 108
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 161,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 109
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 162,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 110
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 163,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 111
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 164,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 112
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 165,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 113
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 166,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 114
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 167,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 115
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 168,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 116
		DEFAULT => -3,
		GOTOS => {
			'remember' => 169
		}
	},
	{#State 117
		DEFAULT => -122
	},
	{#State 118
		ACTIONS => {
			'ADDOP' => 103,
			'POSTINC' => 104,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106,
			'MULOP' => 108,
			'SHIFTOP' => 99
		},
		DEFAULT => -99
	},
	{#State 119
		DEFAULT => -98
	},
	{#State 120
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 170
		}
	},
	{#State 121
		DEFAULT => -47,
		GOTOS => {
			'@1-2' => 171
		}
	},
	{#State 122
		ACTIONS => {
			"{" => 49
		},
		GOTOS => {
			'block' => 172
		}
	},
	{#State 123
		DEFAULT => -28
	},
	{#State 124
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'LSTOP' => 13,
			"!" => 16,
			"\$" => 18,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			"(" => 31,
			'FUNC1' => 32,
			"+" => 36,
			'NOAMP' => 37,
			'DOLSHARP' => 38,
			'FUNC' => 39,
			'STRING' => 41,
			'LOOPEX' => 44,
			"&" => 47,
			'UNIOP' => 48
		},
		DEFAULT => -52,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 173,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 125
		ACTIONS => {
			'OROP' => 113,
			"]" => 174,
			'ANDOP' => 111
		}
	},
	{#State 126
		DEFAULT => -45
	},
	{#State 127
		ACTIONS => {
			'OROP' => 113,
			")" => 175,
			'ANDOP' => 111
		}
	},
	{#State 128
		DEFAULT => -112
	},
	{#State 129
		DEFAULT => -109
	},
	{#State 130
		ACTIONS => {
			"," => 124
		},
		DEFAULT => -105
	},
	{#State 131
		ACTIONS => {
			'OROP' => 113,
			"]" => 176,
			'ANDOP' => 111
		}
	},
	{#State 132
		ACTIONS => {
			";" => 177,
			'OROP' => 113,
			'ANDOP' => 111
		}
	},
	{#State 133
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'mexpr' => 178,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 179,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 134
		ACTIONS => {
			'BITANDOP' => 95,
			'ADDOP' => 103,
			"," => 180,
			'ASSIGNOP' => 96,
			'POSTINC' => 104,
			")" => 181,
			'BITOROP' => 105,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106,
			'DOTDOT' => 107,
			'MULOP' => 108,
			'BITXOROP' => 109,
			'SHIFTOP' => 99,
			'OROR' => 110,
			'ANDAND' => 100,
			'RELOP' => 102,
			'EQOP' => 101
		}
	},
	{#State 135
		DEFAULT => -42
	},
	{#State 136
		ACTIONS => {
			";" => 183,
			"{" => 49
		},
		GOTOS => {
			'block' => 184,
			'subbody' => 182
		}
	},
	{#State 137
		ACTIONS => {
			'OROP' => 113,
			")" => 185,
			'ANDOP' => 111
		}
	},
	{#State 138
		DEFAULT => -92
	},
	{#State 139
		ACTIONS => {
			"[" => 186
		},
		DEFAULT => -80
	},
	{#State 140
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 187,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 141
		ACTIONS => {
			'OROP' => 113,
			")" => 188,
			'ANDOP' => 111
		}
	},
	{#State 142
		DEFAULT => -100
	},
	{#State 143
		DEFAULT => -3,
		GOTOS => {
			'remember' => 189
		}
	},
	{#State 144
		ACTIONS => {
			"\$" => 18
		},
		GOTOS => {
			'scalar' => 190,
			'my_scalar' => 191
		}
	},
	{#State 145
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		DEFAULT => -29,
		GOTOS => {
			'mexpr' => 192,
			'scalar' => 6,
			'sideff' => 194,
			'term' => 40,
			'ary' => 14,
			'expr' => 195,
			'nexpr' => 196,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22,
			'arylen' => 46,
			'mnexpr' => 193,
			'amper' => 28,
			'myattrterm' => 29,
			'subscripted' => 30,
			'argexpr' => 54
		}
	},
	{#State 146
		DEFAULT => -94
	},
	{#State 147
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 197,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 148
		ACTIONS => {
			")" => 198
		}
	},
	{#State 149
		ACTIONS => {
			'OROP' => 113,
			"," => 199,
			'ANDOP' => 111
		},
		DEFAULT => -119
	},
	{#State 150
		ACTIONS => {
			'ADDOP' => 103,
			'POSTINC' => 104,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106,
			'MULOP' => 108,
			'BITXOROP' => 109,
			'SHIFTOP' => 99,
			'EQOP' => 101,
			'RELOP' => 102
		},
		DEFAULT => -63
	},
	{#State 151
		ACTIONS => {
			'BITANDOP' => 95,
			'ADDOP' => 103,
			'ASSIGNOP' => 96,
			'POSTINC' => 104,
			'BITOROP' => 105,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106,
			'DOTDOT' => 107,
			'MULOP' => 108,
			'BITXOROP' => 109,
			'SHIFTOP' => 99,
			'OROR' => 110,
			'ANDAND' => 100,
			'EQOP' => 101,
			'RELOP' => 102
		},
		DEFAULT => -56
	},
	{#State 152
		ACTIONS => {
			'POSTINC' => 104,
			'POWOP' => 97,
			'POSTDEC' => 106
		},
		DEFAULT => -57
	},
	{#State 153
		ACTIONS => {
			'POSTINC' => 104,
			'POWOP' => 97,
			'POSTDEC' => 106
		},
		DEFAULT => -69
	},
	{#State 154
		ACTIONS => {
			'ADDOP' => 103,
			'POSTINC' => 104,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106,
			'MULOP' => 108
		},
		DEFAULT => -60
	},
	{#State 155
		ACTIONS => {
			'BITANDOP' => 95,
			'ADDOP' => 103,
			'POSTINC' => 104,
			'BITOROP' => 105,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106,
			'MULOP' => 108,
			'BITXOROP' => 109,
			'SHIFTOP' => 99,
			'EQOP' => 101,
			'RELOP' => 102
		},
		DEFAULT => -67
	},
	{#State 156
		ACTIONS => {
			'ADDOP' => 103,
			'POSTINC' => 104,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106,
			'MULOP' => 108,
			'SHIFTOP' => 99,
			'EQOP' => undef,
			'RELOP' => 102
		},
		DEFAULT => -62
	},
	{#State 157
		ACTIONS => {
			'ADDOP' => 103,
			'POSTINC' => 104,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106,
			'MULOP' => 108,
			'SHIFTOP' => 99,
			'RELOP' => undef
		},
		DEFAULT => -61
	},
	{#State 158
		ACTIONS => {
			'POSTINC' => 104,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106,
			'MULOP' => 108
		},
		DEFAULT => -59
	},
	{#State 159
		ACTIONS => {
			'BITANDOP' => 95,
			'ADDOP' => 103,
			'POSTINC' => 104,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106,
			'MULOP' => 108,
			'BITXOROP' => 109,
			'SHIFTOP' => 99,
			'EQOP' => 101,
			'RELOP' => 102
		},
		DEFAULT => -64
	},
	{#State 160
		ACTIONS => {
			'BITANDOP' => 95,
			'ADDOP' => 103,
			'POSTINC' => 104,
			'BITOROP' => 105,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106,
			'DOTDOT' => undef,
			'MULOP' => 108,
			'BITXOROP' => 109,
			'SHIFTOP' => 99,
			'OROR' => 110,
			'ANDAND' => 100,
			'EQOP' => 101,
			'RELOP' => 102
		},
		DEFAULT => -66
	},
	{#State 161
		ACTIONS => {
			'POSTINC' => 104,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106
		},
		DEFAULT => -58
	},
	{#State 162
		ACTIONS => {
			'ADDOP' => 103,
			'POSTINC' => 104,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106,
			'MULOP' => 108,
			'SHIFTOP' => 99,
			'EQOP' => 101,
			'RELOP' => 102
		},
		DEFAULT => -65
	},
	{#State 163
		ACTIONS => {
			'BITANDOP' => 95,
			'ADDOP' => 103,
			'POSTINC' => 104,
			'BITOROP' => 105,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106,
			'MULOP' => 108,
			'BITXOROP' => 109,
			'SHIFTOP' => 99,
			'ANDAND' => 100,
			'EQOP' => 101,
			'RELOP' => 102
		},
		DEFAULT => -68
	},
	{#State 164
		DEFAULT => -49
	},
	{#State 165
		ACTIONS => {
			'OROP' => 113,
			'ANDOP' => 111
		},
		DEFAULT => -14
	},
	{#State 166
		ACTIONS => {
			'ANDOP' => 111
		},
		DEFAULT => -50
	},
	{#State 167
		ACTIONS => {
			'OROP' => 113,
			'ANDOP' => 111
		},
		DEFAULT => -16
	},
	{#State 168
		ACTIONS => {
			'OROP' => 113,
			'ANDOP' => 111
		},
		DEFAULT => -15
	},
	{#State 169
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		DEFAULT => -31,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 202,
			'texpr' => 200,
			'termbinop' => 20,
			'mtexpr' => 201,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 170
		ACTIONS => {
			"}" => 203,
			"-" => 5,
			'WORD' => 4,
			'PACKAGE' => 8,
			"\@" => 7,
			'FOR' => 35,
			"+" => 36,
			"~" => 9,
			'COMMENT' => 12,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			'IF' => 19,
			"\$" => 18,
			'LOOPEX' => 44,
			'WHILE' => 45,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'SUB' => 27,
			"{" => 49,
			'UNIOP' => 48,
			"&" => 47,
			'USE' => 51,
			"(" => 31,
			'format' => 52,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 33,
			'sideff' => 34,
			'term' => 40,
			'loop' => 15,
			'ary' => 14,
			'expr' => 42,
			'use' => 43,
			'decl' => 17,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22,
			'line' => 23,
			'cond' => 26,
			'arylen' => 46,
			'amper' => 28,
			'myattrterm' => 29,
			'subscripted' => 30,
			'package' => 50,
			'block' => 53,
			'argexpr' => 54
		}
	},
	{#State 171
		ACTIONS => {
			'WORD' => 204
		}
	},
	{#State 172
		DEFAULT => -22
	},
	{#State 173
		ACTIONS => {
			'BITANDOP' => 95,
			'ADDOP' => 103,
			'ASSIGNOP' => 96,
			'POSTINC' => 104,
			'BITOROP' => 105,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106,
			'DOTDOT' => 107,
			'MULOP' => 108,
			'BITXOROP' => 109,
			'SHIFTOP' => 99,
			'OROR' => 110,
			'ANDAND' => 100,
			'EQOP' => 101,
			'RELOP' => 102
		},
		DEFAULT => -53
	},
	{#State 174
		DEFAULT => -55
	},
	{#State 175
		DEFAULT => -111
	},
	{#State 176
		DEFAULT => -89
	},
	{#State 177
		ACTIONS => {
			"}" => 205
		}
	},
	{#State 178
		ACTIONS => {
			")" => 206
		}
	},
	{#State 179
		ACTIONS => {
			'OROP' => 113,
			'ANDOP' => 111
		},
		DEFAULT => -33
	},
	{#State 180
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 207,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 181
		DEFAULT => -102
	},
	{#State 182
		DEFAULT => -40
	},
	{#State 183
		DEFAULT => -44
	},
	{#State 184
		DEFAULT => -43
	},
	{#State 185
		DEFAULT => -93
	},
	{#State 186
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 208,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 187
		ACTIONS => {
			'OROP' => 113,
			"]" => 209,
			'ANDOP' => 111
		}
	},
	{#State 188
		DEFAULT => -101
	},
	{#State 189
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'mexpr' => 210,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 179,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 190
		DEFAULT => -121
	},
	{#State 191
		ACTIONS => {
			"(" => 211
		}
	},
	{#State 192
		ACTIONS => {
			")" => 212
		}
	},
	{#State 193
		ACTIONS => {
			";" => 213
		}
	},
	{#State 194
		DEFAULT => -30
	},
	{#State 195
		ACTIONS => {
			'FOR' => 114,
			'OROP' => 113,
			'ANDOP' => 111,
			'IF' => 112,
			")" => -33,
			'WHILE' => 115
		},
		DEFAULT => -13
	},
	{#State 196
		DEFAULT => -34
	},
	{#State 197
		ACTIONS => {
			'OROP' => 113,
			")" => 214,
			'ANDOP' => 111
		}
	},
	{#State 198
		DEFAULT => -108
	},
	{#State 199
		DEFAULT => -120
	},
	{#State 200
		DEFAULT => -35
	},
	{#State 201
		ACTIONS => {
			")" => 215
		}
	},
	{#State 202
		ACTIONS => {
			'OROP' => 113,
			'ANDOP' => 111
		},
		DEFAULT => -32
	},
	{#State 203
		DEFAULT => -2
	},
	{#State 204
		ACTIONS => {
			'WORD' => 216
		}
	},
	{#State 205
		DEFAULT => -90
	},
	{#State 206
		ACTIONS => {
			"{" => 217
		},
		GOTOS => {
			'mblock' => 218
		}
	},
	{#State 207
		ACTIONS => {
			'BITANDOP' => 95,
			'ADDOP' => 103,
			'ASSIGNOP' => 96,
			'POSTINC' => 104,
			")" => 219,
			'BITOROP' => 105,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106,
			'DOTDOT' => 107,
			'MULOP' => 108,
			'BITXOROP' => 109,
			'SHIFTOP' => 99,
			'OROR' => 110,
			'ANDAND' => 100,
			'RELOP' => 102,
			'EQOP' => 101
		}
	},
	{#State 208
		ACTIONS => {
			'OROP' => 113,
			"]" => 220,
			'ANDOP' => 111
		}
	},
	{#State 209
		DEFAULT => -88
	},
	{#State 210
		ACTIONS => {
			")" => 221
		}
	},
	{#State 211
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'mexpr' => 222,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 179,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 212
		ACTIONS => {
			"{" => 217
		},
		GOTOS => {
			'mblock' => 223
		}
	},
	{#State 213
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		DEFAULT => -31,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 202,
			'texpr' => 200,
			'termbinop' => 20,
			'mtexpr' => 224,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 214
		DEFAULT => -106
	},
	{#State 215
		ACTIONS => {
			"{" => 217
		},
		GOTOS => {
			'mblock' => 225
		}
	},
	{#State 216
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		DEFAULT => -116,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'termbinop' => 20,
			'argexpr' => 74,
			'listexpr' => 226,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 217
		DEFAULT => -5,
		GOTOS => {
			'mremember' => 227
		}
	},
	{#State 218
		ACTIONS => {
			'ELSE' => 228,
			'ELSIF' => 230
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 229
		}
	},
	{#State 219
		DEFAULT => -103
	},
	{#State 220
		DEFAULT => -87
	},
	{#State 221
		ACTIONS => {
			"{" => 217
		},
		GOTOS => {
			'mblock' => 231
		}
	},
	{#State 222
		ACTIONS => {
			")" => 232
		}
	},
	{#State 223
		ACTIONS => {
			'CONTINUE' => 122
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 233
		}
	},
	{#State 224
		ACTIONS => {
			";" => 234
		}
	},
	{#State 225
		ACTIONS => {
			'CONTINUE' => 122
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 235
		}
	},
	{#State 226
		ACTIONS => {
			";" => 236
		}
	},
	{#State 227
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 237
		}
	},
	{#State 228
		ACTIONS => {
			"{" => 217
		},
		GOTOS => {
			'mblock' => 238
		}
	},
	{#State 229
		DEFAULT => -20
	},
	{#State 230
		ACTIONS => {
			"(" => 239
		}
	},
	{#State 231
		ACTIONS => {
			'CONTINUE' => 122
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 240
		}
	},
	{#State 232
		ACTIONS => {
			"{" => 217
		},
		GOTOS => {
			'mblock' => 241
		}
	},
	{#State 233
		DEFAULT => -26
	},
	{#State 234
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		DEFAULT => -29,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'sideff' => 194,
			'mnexpr' => 242,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 42,
			'nexpr' => 196,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 235
		DEFAULT => -23
	},
	{#State 236
		DEFAULT => -48
	},
	{#State 237
		ACTIONS => {
			"}" => 243,
			"-" => 5,
			'WORD' => 4,
			'PACKAGE' => 8,
			"\@" => 7,
			'FOR' => 35,
			"+" => 36,
			"~" => 9,
			'COMMENT' => 12,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			'IF' => 19,
			"\$" => 18,
			'LOOPEX' => 44,
			'WHILE' => 45,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'SUB' => 27,
			"{" => 49,
			'UNIOP' => 48,
			"&" => 47,
			'USE' => 51,
			"(" => 31,
			'format' => 52,
			'FUNC1' => 32
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 33,
			'sideff' => 34,
			'term' => 40,
			'loop' => 15,
			'ary' => 14,
			'expr' => 42,
			'use' => 43,
			'decl' => 17,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22,
			'line' => 23,
			'cond' => 26,
			'arylen' => 46,
			'amper' => 28,
			'myattrterm' => 29,
			'subscripted' => 30,
			'package' => 50,
			'block' => 53,
			'argexpr' => 54
		}
	},
	{#State 238
		DEFAULT => -18
	},
	{#State 239
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 36,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 37,
			'LSTOP' => 13,
			'STRING' => 41,
			'FUNC' => 39,
			'DOLSHARP' => 38,
			"!" => 16,
			"\$" => 18,
			'LOOPEX' => 44,
			'PMFUNC' => 24,
			'NOTOP' => 25,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		GOTOS => {
			'mexpr' => 244,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 179,
			'termbinop' => 20,
			'argexpr' => 54,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 240
		DEFAULT => -25
	},
	{#State 241
		ACTIONS => {
			'CONTINUE' => 122
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 245
		}
	},
	{#State 242
		ACTIONS => {
			")" => 246
		}
	},
	{#State 243
		DEFAULT => -4
	},
	{#State 244
		ACTIONS => {
			")" => 247
		}
	},
	{#State 245
		DEFAULT => -24
	},
	{#State 246
		ACTIONS => {
			"{" => 217
		},
		GOTOS => {
			'mblock' => 248
		}
	},
	{#State 247
		ACTIONS => {
			"{" => 217
		},
		GOTOS => {
			'mblock' => 249
		}
	},
	{#State 248
		DEFAULT => -27
	},
	{#State 249
		ACTIONS => {
			'ELSE' => 228,
			'ELSIF' => 230
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 250
		}
	},
	{#State 250
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
#line 209 "plpy.yp"
{
                printer(\@_, "prog", "lineseq");
                return "$_[1]";
            }
	],
	[#Rule 2
		 'block', 4,
sub
#line 217 "plpy.yp"
{
                printer(\@_, qw( block { lineseq } )); 
                return "\n    $_[3]\n";
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
                return "\n    $_[3]\n";
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
#line 239 "plpy.yp"
{
                printer(\@_, qw( lineseq lineseq decl )); 
                return "$_[1]$_[2]";
            }
	],
	[#Rule 8
		 'lineseq', 2,
sub
#line 244 "plpy.yp"
{
                printer(\@_, "lineseq", "lineseq", "line");
                return "$_[1]$_[2]";
            }
	],
	[#Rule 9
		 'line', 1,
sub
#line 252 "plpy.yp"
{
                printer(\@_, qw( line cond )); 
                return $_[1];
            }
	],
	[#Rule 10
		 'line', 1,
sub
#line 258 "plpy.yp"
{
                printer(\@_, qw( line loop )); 
                return $_[1];
            }
	],
	[#Rule 11
		 'line', 2,
sub
#line 264 "plpy.yp"
{
                printer(\@_, "line", "sideff", "';'");
                return "$_[1]\n";
            }
	],
	[#Rule 12
		 'line', 1,
sub
#line 269 "plpy.yp"
{
                printer(\@_, "line", "COMMENT");
                return "$_[1]\n";
            }
	],
	[#Rule 13
		 'sideff', 1,
sub
#line 278 "plpy.yp"
{
                printer(\@_, "sideff", "expr");
                return $_[1];
            }
	],
	[#Rule 14
		 'sideff', 3,
sub
#line 284 "plpy.yp"
{
                printer(\@_, qw( sideff expr IF expr ));
                return "$_[1] if $_[3]";
            }
	],
	[#Rule 15
		 'sideff', 3,
sub
#line 289 "plpy.yp"
{
                printer(\@_, qw( sideff expr WHILE expr ));
                return "$_[1] while $_[3]";
            }
	],
	[#Rule 16
		 'sideff', 3,
sub
#line 294 "plpy.yp"
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
#line 303 "plpy.yp"
{
                printer (\@_, qw( else ELSE mblock ));
                return "else: $_[2]";
            }
	],
	[#Rule 19
		 'else', 6,
sub
#line 308 "plpy.yp"
{
                printer (\@_, qw( else ELSIF '(' mexpr ')' mblock else)); 
                return "elif $_[3]:$_[5]$_[6]";
            }
	],
	[#Rule 20
		 'cond', 7,
sub
#line 316 "plpy.yp"
{
                printer (\@_, qw( IF '(' remember mexpr ')' mblock else));
                return "if $_[4]:$_[6]$_[7]";
                
            }
	],
	[#Rule 21
		 'cont', 0,
sub
#line 325 "plpy.yp"
{}
	],
	[#Rule 22
		 'cont', 2,
sub
#line 327 "plpy.yp"
{}
	],
	[#Rule 23
		 'loop', 7,
sub
#line 332 "plpy.yp"
{
                 printer (\@_, qw(WHILE '(' remember mtexpr ')' mblock cont)); 
                 return "while $_[4]:$_[6]$_[7]";
            }
	],
	[#Rule 24
		 'loop', 9,
sub
#line 337 "plpy.yp"
{}
	],
	[#Rule 25
		 'loop', 8,
sub
#line 339 "plpy.yp"
{}
	],
	[#Rule 26
		 'loop', 7,
sub
#line 341 "plpy.yp"
{}
	],
	[#Rule 27
		 'loop', 10,
sub
#line 343 "plpy.yp"
{
                printer (\@_, qw(loop FOR '(' remember mnexpr ';' mtexpr ';' mnexpr ')' mblock)); 
            }
	],
	[#Rule 28
		 'loop', 2,
sub
#line 349 "plpy.yp"
{}
	],
	[#Rule 29
		 'nexpr', 0,
sub
#line 354 "plpy.yp"
{}
	],
	[#Rule 30
		 'nexpr', 1, undef
	],
	[#Rule 31
		 'texpr', 0,
sub
#line 360 "plpy.yp"
{}
	],
	[#Rule 32
		 'texpr', 1, undef
	],
	[#Rule 33
		 'mexpr', 1,
sub
#line 366 "plpy.yp"
{
                printer (\@_, qw(mexpr expr) ); 
                return $_[1];
            }
	],
	[#Rule 34
		 'mnexpr', 1, undef
	],
	[#Rule 35
		 'mtexpr', 1, undef
	],
	[#Rule 36
		 'decl', 1,
sub
#line 380 "plpy.yp"
{}
	],
	[#Rule 37
		 'decl', 1,
sub
#line 382 "plpy.yp"
{}
	],
	[#Rule 38
		 'decl', 1,
sub
#line 384 "plpy.yp"
{}
	],
	[#Rule 39
		 'decl', 1,
sub
#line 386 "plpy.yp"
{}
	],
	[#Rule 40
		 'subrout', 4,
sub
#line 391 "plpy.yp"
{}
	],
	[#Rule 41
		 'startsub', 0,
sub
#line 395 "plpy.yp"
{}
	],
	[#Rule 42
		 'subname', 1,
sub
#line 399 "plpy.yp"
{}
	],
	[#Rule 43
		 'subbody', 1,
sub
#line 403 "plpy.yp"
{}
	],
	[#Rule 44
		 'subbody', 1,
sub
#line 404 "plpy.yp"
{}
	],
	[#Rule 45
		 'package', 3,
sub
#line 408 "plpy.yp"
{}
	],
	[#Rule 46
		 'package', 2,
sub
#line 410 "plpy.yp"
{}
	],
	[#Rule 47
		 '@1-2', 0,
sub
#line 414 "plpy.yp"
{}
	],
	[#Rule 48
		 'use', 7,
sub
#line 416 "plpy.yp"
{}
	],
	[#Rule 49
		 'expr', 3,
sub
#line 421 "plpy.yp"
{
                printer (\@_, qw(expr expr ANDOP expr)); 
                return "$_[1] and $_[3]";
            }
	],
	[#Rule 50
		 'expr', 3,
sub
#line 426 "plpy.yp"
{
                printer (\@_, qw(expr expr OROP expr)); 
                return "$_[1] or $_[3]";
            }
	],
	[#Rule 51
		 'expr', 1, undef
	],
	[#Rule 52
		 'argexpr', 2,
sub
#line 435 "plpy.yp"
{
                printer (\@_, "argexpr", "','");
                return "$_[1], ";
            }
	],
	[#Rule 53
		 'argexpr', 3,
sub
#line 440 "plpy.yp"
{
                printer (\@_, "argexpr", "','", "term");
                return "$_[1], $_[3]";
            }
	],
	[#Rule 54
		 'argexpr', 1,
sub
#line 445 "plpy.yp"
{
                printer (\@_, "argexpr", "term");
                return $_[1];
            }
	],
	[#Rule 55
		 'subscripted', 4,
sub
#line 455 "plpy.yp"
{}
	],
	[#Rule 56
		 'termbinop', 3,
sub
#line 460 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "ASSIGNOP", "term");
                if ($_[2] eq '.=') {$_[2] = '+='}
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 57
		 'termbinop', 3,
sub
#line 466 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "POWOP", "term");
                return "int($_[1]) $_[2] int($_[3])";
            }
	],
	[#Rule 58
		 'termbinop', 3,
sub
#line 471 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "MULOP", "term");
                return "int($_[1]) $_[2] int($_[3])";
            }
	],
	[#Rule 59
		 'termbinop', 3,
sub
#line 476 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "ADDOP", "term");
                return "int($_[1]) $_[2] int($_[3])";
            }
	],
	[#Rule 60
		 'termbinop', 3,
sub
#line 481 "plpy.yp"
{
                printer (\@_, qw(term SHIFTOP term)); 
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 61
		 'termbinop', 3,
sub
#line 486 "plpy.yp"
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
	[#Rule 62
		 'termbinop', 3,
sub
#line 498 "plpy.yp"
{
                printer (\@_, qw(termbinop term EQOP term)); 
                if ($_[2] eq 'eq') {$_[2] = '=='}
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 63
		 'termbinop', 3,
sub
#line 504 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITANDOP term)); 
                return "$_[1] & $_[2]";
            }
	],
	[#Rule 64
		 'termbinop', 3,
sub
#line 509 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITOROP term)); 
                return "$_[1] | $_[2]";
            }
	],
	[#Rule 65
		 'termbinop', 3,
sub
#line 514 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITXOROP term)); 
                return "$_[1] ^ $_[2]";
            }
	],
	[#Rule 66
		 'termbinop', 3,
sub
#line 519 "plpy.yp"
{}
	],
	[#Rule 67
		 'termbinop', 3,
sub
#line 521 "plpy.yp"
{
                printer (\@_, qw(termbinop term ANDAND term)); 
                return "$_[1] and $_[3]";
            }
	],
	[#Rule 68
		 'termbinop', 3,
sub
#line 526 "plpy.yp"
{
                printer (\@_, qw(termbinop term OROR term)); 
                return "$_[1] or $_[3]";
            }
	],
	[#Rule 69
		 'termbinop', 3,
sub
#line 531 "plpy.yp"
{}
	],
	[#Rule 70
		 'termunop', 2,
sub
#line 536 "plpy.yp"
{}
	],
	[#Rule 71
		 'termunop', 2,
sub
#line 538 "plpy.yp"
{}
	],
	[#Rule 72
		 'termunop', 2,
sub
#line 540 "plpy.yp"
{
                printer (\@_, qw(termunop '!' term)); 
                return "not $_[2]";
            }
	],
	[#Rule 73
		 'termunop', 2,
sub
#line 545 "plpy.yp"
{
                printer (\@_, qw(termunop '~' term)); 
                return "~$_[2]";
            }
	],
	[#Rule 74
		 'termunop', 2,
sub
#line 550 "plpy.yp"
{}
	],
	[#Rule 75
		 'termunop', 2,
sub
#line 552 "plpy.yp"
{}
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
#line 558 "plpy.yp"
{
                printer (\@_, "term", "STRING");
                return $_[1];
            
            }
	],
	[#Rule 79
		 'term', 1,
sub
#line 565 "plpy.yp"
{}
	],
	[#Rule 80
		 'term', 3,
sub
#line 567 "plpy.yp"
{}
	],
	[#Rule 81
		 'term', 2,
sub
#line 569 "plpy.yp"
{}
	],
	[#Rule 82
		 'term', 1,
sub
#line 571 "plpy.yp"
{
                printer (\@_, "term", "scalar");
                return $_[1];
            }
	],
	[#Rule 83
		 'term', 1,
sub
#line 576 "plpy.yp"
{}
	],
	[#Rule 84
		 'term', 1,
sub
#line 578 "plpy.yp"
{}
	],
	[#Rule 85
		 'term', 1,
sub
#line 580 "plpy.yp"
{}
	],
	[#Rule 86
		 'term', 1,
sub
#line 582 "plpy.yp"
{}
	],
	[#Rule 87
		 'term', 6,
sub
#line 584 "plpy.yp"
{}
	],
	[#Rule 88
		 'term', 5,
sub
#line 586 "plpy.yp"
{}
	],
	[#Rule 89
		 'term', 4,
sub
#line 588 "plpy.yp"
{}
	],
	[#Rule 90
		 'term', 5,
sub
#line 590 "plpy.yp"
{}
	],
	[#Rule 91
		 'term', 1,
sub
#line 592 "plpy.yp"
{}
	],
	[#Rule 92
		 'term', 3,
sub
#line 594 "plpy.yp"
{}
	],
	[#Rule 93
		 'term', 4,
sub
#line 596 "plpy.yp"
{}
	],
	[#Rule 94
		 'term', 3,
sub
#line 598 "plpy.yp"
{}
	],
	[#Rule 95
		 'term', 1, undef
	],
	[#Rule 96
		 'term', 2,
sub
#line 601 "plpy.yp"
{
                printer (\@_, qw(term NOTOP argexpr)); 
                return "not $_[2]";
            }
	],
	[#Rule 97
		 'term', 1,
sub
#line 606 "plpy.yp"
{}
	],
	[#Rule 98
		 'term', 2,
sub
#line 608 "plpy.yp"
{}
	],
	[#Rule 99
		 'term', 2,
sub
#line 610 "plpy.yp"
{}
	],
	[#Rule 100
		 'term', 3,
sub
#line 612 "plpy.yp"
{}
	],
	[#Rule 101
		 'term', 4,
sub
#line 614 "plpy.yp"
{}
	],
	[#Rule 102
		 'term', 4,
sub
#line 616 "plpy.yp"
{}
	],
	[#Rule 103
		 'term', 6,
sub
#line 618 "plpy.yp"
{}
	],
	[#Rule 104
		 'term', 1, undef
	],
	[#Rule 105
		 'term', 3,
sub
#line 623 "plpy.yp"
{
                printer (\@_, "term", "LSTOP", "indirob", "argexpr");
            }
	],
	[#Rule 106
		 'term', 5,
sub
#line 627 "plpy.yp"
{}
	],
	[#Rule 107
		 'term', 2,
sub
#line 629 "plpy.yp"
{
                printer (\@_, "term", "LSTOP", "listexpr");
                return "print($_[2])";
            
            }
	],
	[#Rule 108
		 'term', 4,
sub
#line 635 "plpy.yp"
{}
	],
	[#Rule 109
		 'myattrterm', 3,
sub
#line 640 "plpy.yp"
{}
	],
	[#Rule 110
		 'myattrterm', 2,
sub
#line 642 "plpy.yp"
{}
	],
	[#Rule 111
		 'myterm', 3,
sub
#line 647 "plpy.yp"
{}
	],
	[#Rule 112
		 'myterm', 2,
sub
#line 649 "plpy.yp"
{}
	],
	[#Rule 113
		 'myterm', 1,
sub
#line 651 "plpy.yp"
{}
	],
	[#Rule 114
		 'myterm', 1,
sub
#line 653 "plpy.yp"
{}
	],
	[#Rule 115
		 'myterm', 1,
sub
#line 655 "plpy.yp"
{}
	],
	[#Rule 116
		 'listexpr', 0,
sub
#line 661 "plpy.yp"
{print "empty listexpr\n";}
	],
	[#Rule 117
		 'listexpr', 1,
sub
#line 663 "plpy.yp"
{
                printer (\@_, "listexpr", "argexpr");
                return $_[1];
            }
	],
	[#Rule 118
		 'listexprcom', 0,
sub
#line 671 "plpy.yp"
{}
	],
	[#Rule 119
		 'listexprcom', 1,
sub
#line 673 "plpy.yp"
{}
	],
	[#Rule 120
		 'listexprcom', 2,
sub
#line 675 "plpy.yp"
{}
	],
	[#Rule 121
		 'my_scalar', 1,
sub
#line 681 "plpy.yp"
{}
	],
	[#Rule 122
		 'amper', 2,
sub
#line 685 "plpy.yp"
{}
	],
	[#Rule 123
		 'scalar', 2,
sub
#line 689 "plpy.yp"
{
                printer (\@_, "scalar", "'\$'", "indirob"); 
                return "$_[2]";
            }
	],
	[#Rule 124
		 'ary', 2,
sub
#line 696 "plpy.yp"
{}
	],
	[#Rule 125
		 'hsh', 2,
sub
#line 700 "plpy.yp"
{}
	],
	[#Rule 126
		 'arylen', 2,
sub
#line 704 "plpy.yp"
{}
	],
	[#Rule 127
		 'indirob', 1,
sub
#line 709 "plpy.yp"
{
                printer (\@_, "indirob", "WORD");
                return $_[1];
            }
	],
	[#Rule 128
		 'indirob', 1,
sub
#line 714 "plpy.yp"
{}
	],
	[#Rule 129
		 'indirob', 1,
sub
#line 716 "plpy.yp"
{}
	]
],
                                  @_);
    bless($self,$class);
}

#line 719 "plpy.yp"


1;
