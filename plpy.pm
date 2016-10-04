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
        ["STRING", qr/"(?:\\"|""|\\\\|[^"])*"/],
        ["STRING", qr/'.*(?<!\\)'/], #TEST THIS
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
			"+" => 36,
			'FOR' => 35,
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
			'UNIOP' => 48,
			"&" => 47,
			'USE' => 50,
			"(" => 31,
			'format' => 51,
			'FUNC1' => 32
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
			'package' => 49,
			'argexpr' => 52
		}
	},
	{#State 3
		DEFAULT => 0
	},
	{#State 4
		DEFAULT => -101
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
			'term' => 53,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 6
		ACTIONS => {
			"[" => 54
		},
		DEFAULT => -79
	},
	{#State 7
		ACTIONS => {
			'WORD' => 56,
			"\$" => 18,
			"{" => 58
		},
		GOTOS => {
			'scalar' => 55,
			'indirob' => 57,
			'block' => 59
		}
	},
	{#State 8
		ACTIONS => {
			'WORD' => 60,
			";" => 61
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
			'term' => 62,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 10
		ACTIONS => {
			'WORD' => 56,
			"\$" => 18,
			"{" => 58
		},
		GOTOS => {
			'scalar' => 55,
			'indirob' => 63,
			'block' => 59
		}
	},
	{#State 11
		ACTIONS => {
			"(" => 67,
			"\@" => 7,
			"\$" => 18,
			"%" => 10
		},
		GOTOS => {
			'scalar' => 64,
			'myterm' => 68,
			'hsh' => 66,
			'ary' => 65
		}
	},
	{#State 12
		DEFAULT => -12
	},
	{#State 13
		ACTIONS => {
			"-" => 5,
			'WORD' => 69,
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
			"{" => 58
		},
		DEFAULT => -113,
		GOTOS => {
			'scalar' => 70,
			'arylen' => 46,
			'indirob' => 71,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'termbinop' => 20,
			'block' => 59,
			'argexpr' => 73,
			'listexpr' => 72,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 14
		ACTIONS => {
			"[" => 74,
			"{" => 75
		},
		DEFAULT => -81
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
			'term' => 76,
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
			'WORD' => 56,
			"\$" => 18,
			"{" => 58
		},
		GOTOS => {
			'scalar' => 55,
			'indirob' => 77,
			'block' => 59
		}
	},
	{#State 19
		ACTIONS => {
			"(" => 78
		}
	},
	{#State 20
		DEFAULT => -73
	},
	{#State 21
		DEFAULT => -80
	},
	{#State 22
		DEFAULT => -74
	},
	{#State 23
		DEFAULT => -8
	},
	{#State 24
		ACTIONS => {
			"(" => 79
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
			'argexpr' => 80,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 26
		DEFAULT => -9
	},
	{#State 27
		DEFAULT => -38,
		GOTOS => {
			'startsub' => 81
		}
	},
	{#State 28
		ACTIONS => {
			"(" => 82
		},
		DEFAULT => -88
	},
	{#State 29
		DEFAULT => -76
	},
	{#State 30
		DEFAULT => -83
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
			")" => 84,
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
			'expr' => 83,
			'termbinop' => 20,
			'argexpr' => 52,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 32
		ACTIONS => {
			"(" => 85
		}
	},
	{#State 33
		DEFAULT => -34
	},
	{#State 34
		ACTIONS => {
			";" => 86
		}
	},
	{#State 35
		ACTIONS => {
			"(" => 89,
			"\$" => 18,
			'MY' => 88
		},
		GOTOS => {
			'scalar' => 87
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
			'term' => 90,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 37
		ACTIONS => {
			'WORD' => 91
		}
	},
	{#State 38
		ACTIONS => {
			'WORD' => 56,
			"\$" => 18,
			"{" => 58
		},
		GOTOS => {
			'scalar' => 55,
			'indirob' => 92,
			'block' => 59
		}
	},
	{#State 39
		ACTIONS => {
			"(" => 93
		}
	},
	{#State 40
		ACTIONS => {
			'BITANDOP' => 94,
			'ADDOP' => 102,
			'ASSIGNOP' => 95,
			'POSTINC' => 103,
			'BITOROP' => 104,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 105,
			'DOTDOT' => 106,
			'MULOP' => 107,
			'BITXOROP' => 108,
			'SHIFTOP' => 98,
			'OROR' => 109,
			'ANDAND' => 99,
			'EQOP' => 100,
			'RELOP' => 101
		},
		DEFAULT => -51
	},
	{#State 41
		DEFAULT => -75
	},
	{#State 42
		ACTIONS => {
			'FOR' => 113,
			'OROP' => 112,
			'ANDOP' => 110,
			'IF' => 111,
			'WHILE' => 114
		},
		DEFAULT => -13
	},
	{#State 43
		DEFAULT => -36
	},
	{#State 44
		DEFAULT => -92
	},
	{#State 45
		ACTIONS => {
			"(" => 115
		}
	},
	{#State 46
		DEFAULT => -82
	},
	{#State 47
		ACTIONS => {
			'WORD' => 56,
			"\$" => 18,
			"{" => 58
		},
		GOTOS => {
			'scalar' => 55,
			'indirob' => 116,
			'block' => 59
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
			"{" => 58
		},
		DEFAULT => -94,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 117,
			'ary' => 14,
			'termbinop' => 20,
			'block' => 118,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 49
		DEFAULT => -35
	},
	{#State 50
		DEFAULT => -38,
		GOTOS => {
			'startsub' => 119
		}
	},
	{#State 51
		DEFAULT => -33
	},
	{#State 52
		ACTIONS => {
			"," => 120
		},
		DEFAULT => -48
	},
	{#State 53
		ACTIONS => {
			'POSTINC' => 103,
			'POWOP' => 96,
			'POSTDEC' => 105
		},
		DEFAULT => -67
	},
	{#State 54
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
			'expr' => 121,
			'termbinop' => 20,
			'argexpr' => 52,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 55
		DEFAULT => -125
	},
	{#State 56
		DEFAULT => -124
	},
	{#State 57
		DEFAULT => -121
	},
	{#State 58
		DEFAULT => -3,
		GOTOS => {
			'remember' => 122
		}
	},
	{#State 59
		DEFAULT => -126
	},
	{#State 60
		ACTIONS => {
			";" => 123
		}
	},
	{#State 61
		DEFAULT => -43
	},
	{#State 62
		ACTIONS => {
			'POSTINC' => 103,
			'POWOP' => 96,
			'POSTDEC' => 105
		},
		DEFAULT => -70
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
			")" => 125,
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
			'expr' => 124,
			'termbinop' => 20,
			'argexpr' => 52,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 68
		ACTIONS => {
			'myattrlist' => 126
		},
		DEFAULT => -107
	},
	{#State 69
		ACTIONS => {
			"-" => -124,
			'WORD' => -124,
			"\@" => -124,
			"~" => -124,
			"%" => -124,
			'MY' => -124,
			'LSTOP' => -124,
			"!" => -124,
			"\$" => -124,
			'PMFUNC' => -124,
			'NOTOP' => -124,
			"(" => -124,
			'FUNC1' => -124,
			"+" => -124,
			'NOAMP' => -124,
			'DOLSHARP' => -124,
			'STRING' => -124,
			'FUNC' => -124,
			'LOOPEX' => -124,
			'UNIOP' => -124,
			"&" => -124
		},
		DEFAULT => -101
	},
	{#State 70
		ACTIONS => {
			"-" => -125,
			'WORD' => -125,
			"\@" => -125,
			"~" => -125,
			"%" => -125,
			'MY' => -125,
			'LSTOP' => -125,
			"!" => -125,
			"\$" => -125,
			"[" => 54,
			'PMFUNC' => -125,
			'NOTOP' => -125,
			"(" => -125,
			'FUNC1' => -125,
			"+" => -125,
			'NOAMP' => -125,
			'DOLSHARP' => -125,
			'STRING' => -125,
			'FUNC' => -125,
			'LOOPEX' => -125,
			'UNIOP' => -125,
			"&" => -125
		},
		DEFAULT => -79
	},
	{#State 71
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
			'argexpr' => 127,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 72
		DEFAULT => -104
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
			'expr' => 128,
			'termbinop' => 20,
			'argexpr' => 52,
			'hsh' => 21,
			'termunop' => 22
		}
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
			'expr' => 129,
			'termbinop' => 20,
			'argexpr' => 52,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 76
		ACTIONS => {
			'POSTINC' => 103,
			'POWOP' => 96,
			'POSTDEC' => 105
		},
		DEFAULT => -69
	},
	{#State 77
		DEFAULT => -120
	},
	{#State 78
		DEFAULT => -3,
		GOTOS => {
			'remember' => 130
		}
	},
	{#State 79
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
			'term' => 131,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 80
		ACTIONS => {
			"," => 120
		},
		DEFAULT => -93
	},
	{#State 81
		ACTIONS => {
			'WORD' => 132
		},
		GOTOS => {
			'subname' => 133
		}
	},
	{#State 82
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
			")" => 135,
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
			'expr' => 134,
			'termbinop' => 20,
			'argexpr' => 52,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 83
		ACTIONS => {
			'OROP' => 112,
			")" => 136,
			'ANDOP' => 110
		}
	},
	{#State 84
		ACTIONS => {
			"[" => 137
		},
		DEFAULT => -78
	},
	{#State 85
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
			")" => 139,
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
			'expr' => 138,
			'termbinop' => 20,
			'argexpr' => 52,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 86
		DEFAULT => -11
	},
	{#State 87
		ACTIONS => {
			"(" => 140
		}
	},
	{#State 88
		DEFAULT => -3,
		GOTOS => {
			'remember' => 141
		}
	},
	{#State 89
		DEFAULT => -3,
		GOTOS => {
			'remember' => 142
		}
	},
	{#State 90
		ACTIONS => {
			'POSTINC' => 103,
			'POWOP' => 96,
			'POSTDEC' => 105
		},
		DEFAULT => -68
	},
	{#State 91
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
		DEFAULT => -113,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'termbinop' => 20,
			'argexpr' => 73,
			'listexpr' => 143,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 92
		DEFAULT => -123
	},
	{#State 93
		ACTIONS => {
			"-" => 5,
			'WORD' => 69,
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
			"{" => 58,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 31,
			'FUNC1' => 32
		},
		DEFAULT => -115,
		GOTOS => {
			'scalar' => 70,
			'arylen' => 46,
			'indirob' => 144,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 146,
			'termbinop' => 20,
			'listexprcom' => 145,
			'block' => 59,
			'argexpr' => 52,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 94
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
			'term' => 147,
			'ary' => 14,
			'termbinop' => 20,
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
			'term' => 148,
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
			'term' => 149,
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
			'term' => 150,
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
			'term' => 151,
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
			'term' => 152,
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
			'term' => 153,
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
			'term' => 154,
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
			'term' => 155,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 103
		DEFAULT => -71
	},
	{#State 104
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
	{#State 105
		DEFAULT => -72
	},
	{#State 106
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
			'term' => 158,
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
			'term' => 159,
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
			'term' => 160,
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
			'term' => 40,
			'ary' => 14,
			'expr' => 161,
			'termbinop' => 20,
			'argexpr' => 52,
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
			'expr' => 162,
			'termbinop' => 20,
			'argexpr' => 52,
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
			'expr' => 163,
			'termbinop' => 20,
			'argexpr' => 52,
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
			'expr' => 164,
			'termbinop' => 20,
			'argexpr' => 52,
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
			'expr' => 165,
			'termbinop' => 20,
			'argexpr' => 52,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 115
		DEFAULT => -3,
		GOTOS => {
			'remember' => 166
		}
	},
	{#State 116
		DEFAULT => -119
	},
	{#State 117
		ACTIONS => {
			'ADDOP' => 102,
			'POSTINC' => 103,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 105,
			'MULOP' => 107,
			'SHIFTOP' => 98
		},
		DEFAULT => -96
	},
	{#State 118
		DEFAULT => -95
	},
	{#State 119
		DEFAULT => -44,
		GOTOS => {
			'@1-2' => 167
		}
	},
	{#State 120
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
		DEFAULT => -49,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 168,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 121
		ACTIONS => {
			'OROP' => 112,
			"]" => 169,
			'ANDOP' => 110
		}
	},
	{#State 122
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 170
		}
	},
	{#State 123
		DEFAULT => -42
	},
	{#State 124
		ACTIONS => {
			'OROP' => 112,
			")" => 171,
			'ANDOP' => 110
		}
	},
	{#State 125
		DEFAULT => -109
	},
	{#State 126
		DEFAULT => -106
	},
	{#State 127
		ACTIONS => {
			"," => 120
		},
		DEFAULT => -102
	},
	{#State 128
		ACTIONS => {
			'OROP' => 112,
			"]" => 172,
			'ANDOP' => 110
		}
	},
	{#State 129
		ACTIONS => {
			";" => 173,
			'OROP' => 112,
			'ANDOP' => 110
		}
	},
	{#State 130
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
			'mexpr' => 174,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 175,
			'termbinop' => 20,
			'argexpr' => 52,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 131
		ACTIONS => {
			'BITANDOP' => 94,
			'ADDOP' => 102,
			"," => 176,
			'ASSIGNOP' => 95,
			'POSTINC' => 103,
			")" => 177,
			'BITOROP' => 104,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 105,
			'DOTDOT' => 106,
			'MULOP' => 107,
			'BITXOROP' => 108,
			'SHIFTOP' => 98,
			'OROR' => 109,
			'ANDAND' => 99,
			'RELOP' => 101,
			'EQOP' => 100
		}
	},
	{#State 132
		DEFAULT => -39
	},
	{#State 133
		ACTIONS => {
			";" => 179,
			"{" => 58
		},
		GOTOS => {
			'block' => 180,
			'subbody' => 178
		}
	},
	{#State 134
		ACTIONS => {
			'OROP' => 112,
			")" => 181,
			'ANDOP' => 110
		}
	},
	{#State 135
		DEFAULT => -89
	},
	{#State 136
		ACTIONS => {
			"[" => 182
		},
		DEFAULT => -77
	},
	{#State 137
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
			'expr' => 183,
			'termbinop' => 20,
			'argexpr' => 52,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 138
		ACTIONS => {
			'OROP' => 112,
			")" => 184,
			'ANDOP' => 110
		}
	},
	{#State 139
		DEFAULT => -97
	},
	{#State 140
		DEFAULT => -3,
		GOTOS => {
			'remember' => 185
		}
	},
	{#State 141
		ACTIONS => {
			"\$" => 18
		},
		GOTOS => {
			'scalar' => 186,
			'my_scalar' => 187
		}
	},
	{#State 142
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
		DEFAULT => -26,
		GOTOS => {
			'mexpr' => 188,
			'scalar' => 6,
			'sideff' => 190,
			'term' => 40,
			'ary' => 14,
			'expr' => 191,
			'nexpr' => 192,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22,
			'arylen' => 46,
			'mnexpr' => 189,
			'amper' => 28,
			'myattrterm' => 29,
			'subscripted' => 30,
			'argexpr' => 52
		}
	},
	{#State 143
		DEFAULT => -91
	},
	{#State 144
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
			'expr' => 193,
			'termbinop' => 20,
			'argexpr' => 52,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 145
		ACTIONS => {
			")" => 194
		}
	},
	{#State 146
		ACTIONS => {
			'OROP' => 112,
			"," => 195,
			'ANDOP' => 110
		},
		DEFAULT => -116
	},
	{#State 147
		ACTIONS => {
			'ADDOP' => 102,
			'POSTINC' => 103,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 105,
			'MULOP' => 107,
			'BITXOROP' => 108,
			'SHIFTOP' => 98,
			'EQOP' => 100,
			'RELOP' => 101
		},
		DEFAULT => -60
	},
	{#State 148
		ACTIONS => {
			'BITANDOP' => 94,
			'ADDOP' => 102,
			'ASSIGNOP' => 95,
			'POSTINC' => 103,
			'BITOROP' => 104,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 105,
			'DOTDOT' => 106,
			'MULOP' => 107,
			'BITXOROP' => 108,
			'SHIFTOP' => 98,
			'OROR' => 109,
			'ANDAND' => 99,
			'EQOP' => 100,
			'RELOP' => 101
		},
		DEFAULT => -53
	},
	{#State 149
		ACTIONS => {
			'POSTINC' => 103,
			'POWOP' => 96,
			'POSTDEC' => 105
		},
		DEFAULT => -54
	},
	{#State 150
		ACTIONS => {
			'POSTINC' => 103,
			'POWOP' => 96,
			'POSTDEC' => 105
		},
		DEFAULT => -66
	},
	{#State 151
		ACTIONS => {
			'ADDOP' => 102,
			'POSTINC' => 103,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 105,
			'MULOP' => 107
		},
		DEFAULT => -57
	},
	{#State 152
		ACTIONS => {
			'BITANDOP' => 94,
			'ADDOP' => 102,
			'POSTINC' => 103,
			'BITOROP' => 104,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 105,
			'MULOP' => 107,
			'BITXOROP' => 108,
			'SHIFTOP' => 98,
			'EQOP' => 100,
			'RELOP' => 101
		},
		DEFAULT => -64
	},
	{#State 153
		ACTIONS => {
			'ADDOP' => 102,
			'POSTINC' => 103,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 105,
			'MULOP' => 107,
			'SHIFTOP' => 98,
			'EQOP' => undef,
			'RELOP' => 101
		},
		DEFAULT => -59
	},
	{#State 154
		ACTIONS => {
			'ADDOP' => 102,
			'POSTINC' => 103,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 105,
			'MULOP' => 107,
			'SHIFTOP' => 98,
			'RELOP' => undef
		},
		DEFAULT => -58
	},
	{#State 155
		ACTIONS => {
			'POSTINC' => 103,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 105,
			'MULOP' => 107
		},
		DEFAULT => -56
	},
	{#State 156
		ACTIONS => {
			'BITANDOP' => 94,
			'ADDOP' => 102,
			'POSTINC' => 103,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 105,
			'MULOP' => 107,
			'BITXOROP' => 108,
			'SHIFTOP' => 98,
			'EQOP' => 100,
			'RELOP' => 101
		},
		DEFAULT => -61
	},
	{#State 157
		ACTIONS => {
			'BITANDOP' => 94,
			'ADDOP' => 102,
			'POSTINC' => 103,
			'BITOROP' => 104,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 105,
			'DOTDOT' => undef,
			'MULOP' => 107,
			'BITXOROP' => 108,
			'SHIFTOP' => 98,
			'OROR' => 109,
			'ANDAND' => 99,
			'EQOP' => 100,
			'RELOP' => 101
		},
		DEFAULT => -63
	},
	{#State 158
		ACTIONS => {
			'POSTINC' => 103,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 105
		},
		DEFAULT => -55
	},
	{#State 159
		ACTIONS => {
			'ADDOP' => 102,
			'POSTINC' => 103,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 105,
			'MULOP' => 107,
			'SHIFTOP' => 98,
			'EQOP' => 100,
			'RELOP' => 101
		},
		DEFAULT => -62
	},
	{#State 160
		ACTIONS => {
			'BITANDOP' => 94,
			'ADDOP' => 102,
			'POSTINC' => 103,
			'BITOROP' => 104,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 105,
			'MULOP' => 107,
			'BITXOROP' => 108,
			'SHIFTOP' => 98,
			'ANDAND' => 99,
			'EQOP' => 100,
			'RELOP' => 101
		},
		DEFAULT => -65
	},
	{#State 161
		DEFAULT => -46
	},
	{#State 162
		ACTIONS => {
			'OROP' => 112,
			'ANDOP' => 110
		},
		DEFAULT => -14
	},
	{#State 163
		ACTIONS => {
			'ANDOP' => 110
		},
		DEFAULT => -47
	},
	{#State 164
		ACTIONS => {
			'OROP' => 112,
			'ANDOP' => 110
		},
		DEFAULT => -16
	},
	{#State 165
		ACTIONS => {
			'OROP' => 112,
			'ANDOP' => 110
		},
		DEFAULT => -15
	},
	{#State 166
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
		DEFAULT => -28,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 198,
			'texpr' => 196,
			'termbinop' => 20,
			'mtexpr' => 197,
			'argexpr' => 52,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 167
		ACTIONS => {
			'WORD' => 199
		}
	},
	{#State 168
		ACTIONS => {
			'BITANDOP' => 94,
			'ADDOP' => 102,
			'ASSIGNOP' => 95,
			'POSTINC' => 103,
			'BITOROP' => 104,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 105,
			'DOTDOT' => 106,
			'MULOP' => 107,
			'BITXOROP' => 108,
			'SHIFTOP' => 98,
			'OROR' => 109,
			'ANDAND' => 99,
			'EQOP' => 100,
			'RELOP' => 101
		},
		DEFAULT => -50
	},
	{#State 169
		DEFAULT => -52
	},
	{#State 170
		ACTIONS => {
			"}" => 200,
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
			'UNIOP' => 48,
			"&" => 47,
			'USE' => 50,
			"(" => 31,
			'format' => 51,
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
			'package' => 49,
			'argexpr' => 52
		}
	},
	{#State 171
		DEFAULT => -108
	},
	{#State 172
		DEFAULT => -86
	},
	{#State 173
		ACTIONS => {
			"}" => 201
		}
	},
	{#State 174
		ACTIONS => {
			")" => 202
		}
	},
	{#State 175
		ACTIONS => {
			'OROP' => 112,
			'ANDOP' => 110
		},
		DEFAULT => -30
	},
	{#State 176
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
			'term' => 203,
			'ary' => 14,
			'termbinop' => 20,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 177
		DEFAULT => -99
	},
	{#State 178
		DEFAULT => -37
	},
	{#State 179
		DEFAULT => -41
	},
	{#State 180
		DEFAULT => -40
	},
	{#State 181
		DEFAULT => -90
	},
	{#State 182
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
			'expr' => 204,
			'termbinop' => 20,
			'argexpr' => 52,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 183
		ACTIONS => {
			'OROP' => 112,
			"]" => 205,
			'ANDOP' => 110
		}
	},
	{#State 184
		DEFAULT => -98
	},
	{#State 185
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
			'mexpr' => 206,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 175,
			'termbinop' => 20,
			'argexpr' => 52,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 186
		DEFAULT => -118
	},
	{#State 187
		ACTIONS => {
			"(" => 207
		}
	},
	{#State 188
		ACTIONS => {
			")" => 208
		}
	},
	{#State 189
		ACTIONS => {
			";" => 209
		}
	},
	{#State 190
		DEFAULT => -27
	},
	{#State 191
		ACTIONS => {
			'FOR' => 113,
			'OROP' => 112,
			'ANDOP' => 110,
			'IF' => 111,
			")" => -30,
			'WHILE' => 114
		},
		DEFAULT => -13
	},
	{#State 192
		DEFAULT => -31
	},
	{#State 193
		ACTIONS => {
			'OROP' => 112,
			")" => 210,
			'ANDOP' => 110
		}
	},
	{#State 194
		DEFAULT => -105
	},
	{#State 195
		DEFAULT => -117
	},
	{#State 196
		DEFAULT => -32
	},
	{#State 197
		ACTIONS => {
			")" => 211
		}
	},
	{#State 198
		ACTIONS => {
			'OROP' => 112,
			'ANDOP' => 110
		},
		DEFAULT => -29
	},
	{#State 199
		ACTIONS => {
			'WORD' => 212
		}
	},
	{#State 200
		DEFAULT => -2
	},
	{#State 201
		DEFAULT => -87
	},
	{#State 202
		ACTIONS => {
			"{" => 213
		},
		GOTOS => {
			'mblock' => 214
		}
	},
	{#State 203
		ACTIONS => {
			'BITANDOP' => 94,
			'ADDOP' => 102,
			'ASSIGNOP' => 95,
			'POSTINC' => 103,
			")" => 215,
			'BITOROP' => 104,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 105,
			'DOTDOT' => 106,
			'MULOP' => 107,
			'BITXOROP' => 108,
			'SHIFTOP' => 98,
			'OROR' => 109,
			'ANDAND' => 99,
			'RELOP' => 101,
			'EQOP' => 100
		}
	},
	{#State 204
		ACTIONS => {
			'OROP' => 112,
			"]" => 216,
			'ANDOP' => 110
		}
	},
	{#State 205
		DEFAULT => -85
	},
	{#State 206
		ACTIONS => {
			")" => 217
		}
	},
	{#State 207
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
			'mexpr' => 218,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 175,
			'termbinop' => 20,
			'argexpr' => 52,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 208
		ACTIONS => {
			"{" => 213
		},
		GOTOS => {
			'mblock' => 219
		}
	},
	{#State 209
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
		DEFAULT => -28,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 198,
			'texpr' => 196,
			'termbinop' => 20,
			'mtexpr' => 220,
			'argexpr' => 52,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 210
		DEFAULT => -103
	},
	{#State 211
		ACTIONS => {
			"{" => 213
		},
		GOTOS => {
			'mblock' => 221
		}
	},
	{#State 212
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
		DEFAULT => -113,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'termbinop' => 20,
			'argexpr' => 73,
			'listexpr' => 222,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 213
		DEFAULT => -5,
		GOTOS => {
			'mremember' => 223
		}
	},
	{#State 214
		ACTIONS => {
			'ELSE' => 224,
			'ELSIF' => 226
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 225
		}
	},
	{#State 215
		DEFAULT => -100
	},
	{#State 216
		DEFAULT => -84
	},
	{#State 217
		ACTIONS => {
			"{" => 213
		},
		GOTOS => {
			'mblock' => 227
		}
	},
	{#State 218
		ACTIONS => {
			")" => 228
		}
	},
	{#State 219
		DEFAULT => -24
	},
	{#State 220
		ACTIONS => {
			";" => 229
		}
	},
	{#State 221
		DEFAULT => -21
	},
	{#State 222
		ACTIONS => {
			";" => 230
		}
	},
	{#State 223
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 231
		}
	},
	{#State 224
		ACTIONS => {
			"{" => 213
		},
		GOTOS => {
			'mblock' => 232
		}
	},
	{#State 225
		DEFAULT => -20
	},
	{#State 226
		ACTIONS => {
			"(" => 233
		}
	},
	{#State 227
		DEFAULT => -23
	},
	{#State 228
		ACTIONS => {
			"{" => 213
		},
		GOTOS => {
			'mblock' => 234
		}
	},
	{#State 229
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
		DEFAULT => -26,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'sideff' => 190,
			'mnexpr' => 235,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 42,
			'nexpr' => 192,
			'termbinop' => 20,
			'argexpr' => 52,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 230
		DEFAULT => -45
	},
	{#State 231
		ACTIONS => {
			"}" => 236,
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
			'UNIOP' => 48,
			"&" => 47,
			'USE' => 50,
			"(" => 31,
			'format' => 51,
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
			'package' => 49,
			'argexpr' => 52
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
			'mexpr' => 237,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 29,
			'amper' => 28,
			'subscripted' => 30,
			'term' => 40,
			'ary' => 14,
			'expr' => 175,
			'termbinop' => 20,
			'argexpr' => 52,
			'hsh' => 21,
			'termunop' => 22
		}
	},
	{#State 234
		DEFAULT => -22
	},
	{#State 235
		ACTIONS => {
			")" => 238
		}
	},
	{#State 236
		DEFAULT => -4
	},
	{#State 237
		ACTIONS => {
			")" => 239
		}
	},
	{#State 238
		ACTIONS => {
			"{" => 213
		},
		GOTOS => {
			'mblock' => 240
		}
	},
	{#State 239
		ACTIONS => {
			"{" => 213
		},
		GOTOS => {
			'mblock' => 241
		}
	},
	{#State 240
		DEFAULT => -25
	},
	{#State 241
		ACTIONS => {
			'ELSE' => 224,
			'ELSIF' => 226
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 242
		}
	},
	{#State 242
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
		 'loop', 6,
sub
#line 325 "plpy.yp"
{
                 printer (\@_, qw(WHILE '(' remember mtexpr ')' mblock cont)); 
                 return "while $_[4]:$_[6]$_[7]";
            }
	],
	[#Rule 22
		 'loop', 8,
sub
#line 330 "plpy.yp"
{
                printer (\@_, qw(loop FOR MY remember my_scalar '(' mexpr ')' mblock cont)); 
                return "for $_[4] in $_[6]:$_[8]";
            }
	],
	[#Rule 23
		 'loop', 7,
sub
#line 335 "plpy.yp"
{
                printer (\@_, qw(loop FOR scalar '(' mexpr ')' mblock cont)); 
                return "for $_[2] in $_[5]:$_[7]";
            }
	],
	[#Rule 24
		 'loop', 6,
sub
#line 340 "plpy.yp"
{}
	],
	[#Rule 25
		 'loop', 10,
sub
#line 342 "plpy.yp"
{
                printer (\@_, qw(loop FOR '(' remember mnexpr ';' mtexpr ';' mnexpr ')' mblock)); 
                return "$_[4]\nwhile $_[6]:$_[10]    $_[8]\n";
            }
	],
	[#Rule 26
		 'nexpr', 0,
sub
#line 350 "plpy.yp"
{}
	],
	[#Rule 27
		 'nexpr', 1, undef
	],
	[#Rule 28
		 'texpr', 0,
sub
#line 356 "plpy.yp"
{}
	],
	[#Rule 29
		 'texpr', 1, undef
	],
	[#Rule 30
		 'mexpr', 1,
sub
#line 362 "plpy.yp"
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
#line 376 "plpy.yp"
{}
	],
	[#Rule 34
		 'decl', 1,
sub
#line 378 "plpy.yp"
{}
	],
	[#Rule 35
		 'decl', 1,
sub
#line 380 "plpy.yp"
{}
	],
	[#Rule 36
		 'decl', 1,
sub
#line 382 "plpy.yp"
{}
	],
	[#Rule 37
		 'subrout', 4,
sub
#line 387 "plpy.yp"
{}
	],
	[#Rule 38
		 'startsub', 0,
sub
#line 391 "plpy.yp"
{}
	],
	[#Rule 39
		 'subname', 1,
sub
#line 395 "plpy.yp"
{}
	],
	[#Rule 40
		 'subbody', 1,
sub
#line 399 "plpy.yp"
{}
	],
	[#Rule 41
		 'subbody', 1,
sub
#line 400 "plpy.yp"
{}
	],
	[#Rule 42
		 'package', 3,
sub
#line 404 "plpy.yp"
{}
	],
	[#Rule 43
		 'package', 2,
sub
#line 406 "plpy.yp"
{}
	],
	[#Rule 44
		 '@1-2', 0,
sub
#line 410 "plpy.yp"
{}
	],
	[#Rule 45
		 'use', 7,
sub
#line 412 "plpy.yp"
{}
	],
	[#Rule 46
		 'expr', 3,
sub
#line 417 "plpy.yp"
{
                printer (\@_, qw(expr expr ANDOP expr)); 
                return "$_[1] and $_[3]";
            }
	],
	[#Rule 47
		 'expr', 3,
sub
#line 422 "plpy.yp"
{
                printer (\@_, qw(expr expr OROP expr)); 
                return "$_[1] or $_[3]";
            }
	],
	[#Rule 48
		 'expr', 1, undef
	],
	[#Rule 49
		 'argexpr', 2,
sub
#line 431 "plpy.yp"
{
                printer (\@_, "argexpr", "','");
                return "$_[1], ";
            }
	],
	[#Rule 50
		 'argexpr', 3,
sub
#line 436 "plpy.yp"
{
                printer (\@_, "argexpr", "','", "term");
                return "$_[1], $_[3]";
            }
	],
	[#Rule 51
		 'argexpr', 1,
sub
#line 441 "plpy.yp"
{
                printer (\@_, "argexpr", "term");
                return $_[1];
            }
	],
	[#Rule 52
		 'subscripted', 4,
sub
#line 451 "plpy.yp"
{}
	],
	[#Rule 53
		 'termbinop', 3,
sub
#line 456 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "ASSIGNOP", "term");
                if ($_[2] eq '.=') {$_[2] = '+='}
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 54
		 'termbinop', 3,
sub
#line 462 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "POWOP", "term");
                return "int($_[1]) $_[2] int($_[3])";
            }
	],
	[#Rule 55
		 'termbinop', 3,
sub
#line 467 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "MULOP", "term");
                return "int($_[1]) $_[2] int($_[3])";
            }
	],
	[#Rule 56
		 'termbinop', 3,
sub
#line 472 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "ADDOP", "term");
                return "int($_[1]) $_[2] int($_[3])";
            }
	],
	[#Rule 57
		 'termbinop', 3,
sub
#line 477 "plpy.yp"
{
                printer (\@_, qw(term SHIFTOP term)); 
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 58
		 'termbinop', 3,
sub
#line 482 "plpy.yp"
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
	[#Rule 59
		 'termbinop', 3,
sub
#line 494 "plpy.yp"
{
                printer (\@_, qw(termbinop term EQOP term)); 
                if ($_[2] eq 'eq') {$_[2] = '=='}
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 60
		 'termbinop', 3,
sub
#line 500 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITANDOP term)); 
                return "$_[1] & $_[2]";
            }
	],
	[#Rule 61
		 'termbinop', 3,
sub
#line 505 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITOROP term)); 
                return "$_[1] | $_[2]";
            }
	],
	[#Rule 62
		 'termbinop', 3,
sub
#line 510 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITXOROP term)); 
                return "$_[1] ^ $_[2]";
            }
	],
	[#Rule 63
		 'termbinop', 3,
sub
#line 515 "plpy.yp"
{}
	],
	[#Rule 64
		 'termbinop', 3,
sub
#line 517 "plpy.yp"
{
                printer (\@_, qw(termbinop term ANDAND term)); 
                return "$_[1] and $_[3]";
            }
	],
	[#Rule 65
		 'termbinop', 3,
sub
#line 522 "plpy.yp"
{
                printer (\@_, qw(termbinop term OROR term)); 
                return "$_[1] or $_[3]";
            }
	],
	[#Rule 66
		 'termbinop', 3,
sub
#line 527 "plpy.yp"
{}
	],
	[#Rule 67
		 'termunop', 2,
sub
#line 532 "plpy.yp"
{}
	],
	[#Rule 68
		 'termunop', 2,
sub
#line 534 "plpy.yp"
{}
	],
	[#Rule 69
		 'termunop', 2,
sub
#line 536 "plpy.yp"
{
                printer (\@_, qw(termunop '!' term)); 
                return "not $_[2]";
            }
	],
	[#Rule 70
		 'termunop', 2,
sub
#line 541 "plpy.yp"
{
                printer (\@_, qw(termunop '~' term)); 
                return "~$_[2]";
            }
	],
	[#Rule 71
		 'termunop', 2,
sub
#line 546 "plpy.yp"
{
                printer (\@_, qw(termunop term POSTINC)); 
                return "$_[1] += 1";
            }
	],
	[#Rule 72
		 'termunop', 2,
sub
#line 551 "plpy.yp"
{
                printer (\@_, qw(termunop term POSTDEC)); 
                return "$_[1] -= 1";
            }
	],
	[#Rule 73
		 'term', 1, undef
	],
	[#Rule 74
		 'term', 1, undef
	],
	[#Rule 75
		 'term', 1,
sub
#line 560 "plpy.yp"
{
                printer (\@_, "term", "STRING");
                $_[1] =~ s/^"\$(\w+)"/$1/;
                return $_[1];
            }
	],
	[#Rule 76
		 'term', 1,
sub
#line 567 "plpy.yp"
{}
	],
	[#Rule 77
		 'term', 3,
sub
#line 569 "plpy.yp"
{}
	],
	[#Rule 78
		 'term', 2,
sub
#line 571 "plpy.yp"
{}
	],
	[#Rule 79
		 'term', 1,
sub
#line 573 "plpy.yp"
{
                printer (\@_, "term", "scalar");
                return $_[1];
            }
	],
	[#Rule 80
		 'term', 1,
sub
#line 578 "plpy.yp"
{}
	],
	[#Rule 81
		 'term', 1,
sub
#line 580 "plpy.yp"
{}
	],
	[#Rule 82
		 'term', 1,
sub
#line 582 "plpy.yp"
{}
	],
	[#Rule 83
		 'term', 1,
sub
#line 584 "plpy.yp"
{}
	],
	[#Rule 84
		 'term', 6,
sub
#line 586 "plpy.yp"
{}
	],
	[#Rule 85
		 'term', 5,
sub
#line 588 "plpy.yp"
{}
	],
	[#Rule 86
		 'term', 4,
sub
#line 590 "plpy.yp"
{}
	],
	[#Rule 87
		 'term', 5,
sub
#line 592 "plpy.yp"
{}
	],
	[#Rule 88
		 'term', 1,
sub
#line 594 "plpy.yp"
{}
	],
	[#Rule 89
		 'term', 3,
sub
#line 596 "plpy.yp"
{}
	],
	[#Rule 90
		 'term', 4,
sub
#line 598 "plpy.yp"
{}
	],
	[#Rule 91
		 'term', 3,
sub
#line 600 "plpy.yp"
{}
	],
	[#Rule 92
		 'term', 1, undef
	],
	[#Rule 93
		 'term', 2,
sub
#line 603 "plpy.yp"
{
                printer (\@_, qw(term NOTOP argexpr)); 
                return "not $_[2]";
            }
	],
	[#Rule 94
		 'term', 1,
sub
#line 608 "plpy.yp"
{}
	],
	[#Rule 95
		 'term', 2,
sub
#line 610 "plpy.yp"
{}
	],
	[#Rule 96
		 'term', 2,
sub
#line 612 "plpy.yp"
{}
	],
	[#Rule 97
		 'term', 3,
sub
#line 614 "plpy.yp"
{}
	],
	[#Rule 98
		 'term', 4,
sub
#line 616 "plpy.yp"
{}
	],
	[#Rule 99
		 'term', 4,
sub
#line 618 "plpy.yp"
{}
	],
	[#Rule 100
		 'term', 6,
sub
#line 620 "plpy.yp"
{}
	],
	[#Rule 101
		 'term', 1, undef
	],
	[#Rule 102
		 'term', 3,
sub
#line 625 "plpy.yp"
{
                printer (\@_, "term", "LSTOP", "indirob", "argexpr");
            }
	],
	[#Rule 103
		 'term', 5,
sub
#line 629 "plpy.yp"
{}
	],
	[#Rule 104
		 'term', 2,
sub
#line 631 "plpy.yp"
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
            }
	],
	[#Rule 105
		 'term', 4,
sub
#line 655 "plpy.yp"
{}
	],
	[#Rule 106
		 'myattrterm', 3,
sub
#line 660 "plpy.yp"
{}
	],
	[#Rule 107
		 'myattrterm', 2,
sub
#line 662 "plpy.yp"
{}
	],
	[#Rule 108
		 'myterm', 3,
sub
#line 667 "plpy.yp"
{}
	],
	[#Rule 109
		 'myterm', 2,
sub
#line 669 "plpy.yp"
{}
	],
	[#Rule 110
		 'myterm', 1,
sub
#line 671 "plpy.yp"
{}
	],
	[#Rule 111
		 'myterm', 1,
sub
#line 673 "plpy.yp"
{}
	],
	[#Rule 112
		 'myterm', 1,
sub
#line 675 "plpy.yp"
{}
	],
	[#Rule 113
		 'listexpr', 0,
sub
#line 681 "plpy.yp"
{print "empty listexpr\n";}
	],
	[#Rule 114
		 'listexpr', 1,
sub
#line 683 "plpy.yp"
{
                printer (\@_, "listexpr", "argexpr");
                return $_[1];
            }
	],
	[#Rule 115
		 'listexprcom', 0,
sub
#line 691 "plpy.yp"
{}
	],
	[#Rule 116
		 'listexprcom', 1,
sub
#line 693 "plpy.yp"
{}
	],
	[#Rule 117
		 'listexprcom', 2,
sub
#line 695 "plpy.yp"
{}
	],
	[#Rule 118
		 'my_scalar', 1,
sub
#line 701 "plpy.yp"
{}
	],
	[#Rule 119
		 'amper', 2,
sub
#line 705 "plpy.yp"
{}
	],
	[#Rule 120
		 'scalar', 2,
sub
#line 709 "plpy.yp"
{
                printer (\@_, "scalar", "'\$'", "indirob"); 
                return "$_[2]";
            }
	],
	[#Rule 121
		 'ary', 2,
sub
#line 716 "plpy.yp"
{}
	],
	[#Rule 122
		 'hsh', 2,
sub
#line 720 "plpy.yp"
{}
	],
	[#Rule 123
		 'arylen', 2,
sub
#line 724 "plpy.yp"
{}
	],
	[#Rule 124
		 'indirob', 1,
sub
#line 729 "plpy.yp"
{
                printer (\@_, "indirob", "WORD");
                return $_[1];
            }
	],
	[#Rule 125
		 'indirob', 1,
sub
#line 734 "plpy.yp"
{}
	],
	[#Rule 126
		 'indirob', 1,
sub
#line 736 "plpy.yp"
{}
	]
],
                                  @_);
    bless($self,$class);
}

#line 739 "plpy.yp"


1;
