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
    my $uni = "chomp|exit|pop|shift|scalar|close|keys";
    my $lop = "print|printf|split|join|push|unshift|reverse|open|sort";
    my @tokens = (
        # matches a string with double or escaped quotes 
        ["STRING", qr/"(?:\\"|""|\\\\|[^"]|)*"/],
        # matches matching functions split (/foo/, $bar)
        ["PMFUNC", qr/split(?=\s*\(\s*\/)/],
        #matches all functions with brackets
        ["FUNC", qr/\w+(?=\s*\()/a],
        ["FUNC1", qr/(?:${uni})(?=\s*\()/],
        ["UNIOP", qr/(?:${uni})(?!\s*\()/],
        ["LSTOP", qr/(?:${lop})/],
        ["COMMENT", qr/\#.*/],
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
        ["ADDOP", qr/[\+\.-]/],
        ["RELOP", qr/>|<|<=|>=|lt|gt|le|ge/],
        ["MULOP", qr/[\/%\*]/],
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
    print "___Remaining___\n", $_[0]->YYData->{"DATA"}, "\n";#_______________\n" ;
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
        print "unable to parse\n";
        print $_[0]->YYData->{"DATA"}, "\n";
        return ('', undef);
    }
}

sub Lexer {
    my ($type, $value) = getToken($_[0]);
    print "Removed: ( '$type' : '$value' )\n";
    return ($type, $value);
    #return ('', undef);
}

sub printer{
    print "\n";
    my @tokens = @{shift(@_)};
    my @words = @_;
    my $parser = shift(@tokens);
    my $word_string = join("->", @words);
    my $token_string = "$words[0]"."->";
    $token_string .= join("->", @tokens);
    
    print "$word_string\n";
    print "$token_string\n";
    #print "('", $parser->YYCurtok, "': '", $parser->YYCurval, "')\n";
    #print "YYExpect: ", join("\n", $_[0]->YYExpect), "\n";
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
			'COMMENT' => 11,
			'MY' => 10,
			"%" => 9,
			'LSTOP' => 12,
			"!" => 15,
			'IF' => 18,
			"\$" => 17,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'SUB' => 26,
			"(" => 30,
			'FUNC1' => 31,
			'FOR' => 34,
			"+" => 35,
			'NOAMP' => 36,
			'DOLSHARP' => 37,
			'FUNC' => 38,
			'STRING' => 40,
			'LOOPEX' => 43,
			'error' => 44,
			'WHILE' => 45,
			"&" => 47,
			'UNIOP' => 48,
			"{" => 49,
			'USE' => 51,
			'format' => 52
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 32,
			'sideff' => 33,
			'term' => 39,
			'loop' => 14,
			'ary' => 13,
			'use' => 42,
			'expr' => 41,
			'decl' => 16,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21,
			'line' => 22,
			'cond' => 25,
			'arylen' => 46,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'package' => 50,
			'block' => 53,
			'argexpr' => 54
		}
	},
	{#State 3
		DEFAULT => 0
	},
	{#State 4
		DEFAULT => -100
	},
	{#State 5
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 55,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 6
		ACTIONS => {
			"[" => 56
		},
		DEFAULT => -78
	},
	{#State 7
		ACTIONS => {
			'WORD' => 58,
			"\$" => 17,
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
			"\$" => 17,
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
			"\$" => 17,
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
		DEFAULT => -12
	},
	{#State 12
		ACTIONS => {
			"-" => 5,
			'WORD' => 69,
			"\@" => 7,
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
			'LOOPEX' => 43,
			"&" => 47,
			'UNIOP' => 48,
			"{" => 49
		},
		DEFAULT => -112,
		GOTOS => {
			'scalar' => 70,
			'arylen' => 46,
			'indirob' => 71,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'termbinop' => 19,
			'block' => 60,
			'argexpr' => 73,
			'listexpr' => 72,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 13
		ACTIONS => {
			"[" => 74,
			"{" => 75
		},
		DEFAULT => -80
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
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 76,
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
			'WORD' => 58,
			"\$" => 17,
			"{" => 49
		},
		GOTOS => {
			'scalar' => 57,
			'indirob' => 77,
			'block' => 60
		}
	},
	{#State 18
		ACTIONS => {
			"(" => 78
		}
	},
	{#State 19
		DEFAULT => -72
	},
	{#State 20
		DEFAULT => -79
	},
	{#State 21
		DEFAULT => -73
	},
	{#State 22
		DEFAULT => -8
	},
	{#State 23
		ACTIONS => {
			"(" => 79
		}
	},
	{#State 24
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'termbinop' => 19,
			'argexpr' => 80,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 25
		DEFAULT => -9
	},
	{#State 26
		DEFAULT => -42,
		GOTOS => {
			'startsub' => 81
		}
	},
	{#State 27
		ACTIONS => {
			"(" => 82
		},
		DEFAULT => -87
	},
	{#State 28
		DEFAULT => -75
	},
	{#State 29
		DEFAULT => -82
	},
	{#State 30
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			")" => 84,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 83,
			'termbinop' => 19,
			'argexpr' => 54,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 31
		ACTIONS => {
			"(" => 85
		}
	},
	{#State 32
		DEFAULT => -38
	},
	{#State 33
		ACTIONS => {
			";" => 86
		}
	},
	{#State 34
		ACTIONS => {
			"(" => 89,
			"\$" => 17,
			'MY' => 88
		},
		GOTOS => {
			'scalar' => 87
		}
	},
	{#State 35
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 90,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 36
		ACTIONS => {
			'WORD' => 91
		}
	},
	{#State 37
		ACTIONS => {
			'WORD' => 58,
			"\$" => 17,
			"{" => 49
		},
		GOTOS => {
			'scalar' => 57,
			'indirob' => 92,
			'block' => 60
		}
	},
	{#State 38
		ACTIONS => {
			"(" => 93
		}
	},
	{#State 39
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
		DEFAULT => -55
	},
	{#State 40
		DEFAULT => -74
	},
	{#State 41
		ACTIONS => {
			'FOR' => 109,
			'OROP' => 108,
			'ANDOP' => 106,
			'IF' => 107,
			'WHILE' => 110
		},
		DEFAULT => -14
	},
	{#State 42
		DEFAULT => -40
	},
	{#State 43
		DEFAULT => -91
	},
	{#State 44
		DEFAULT => -13
	},
	{#State 45
		ACTIONS => {
			"(" => 111
		}
	},
	{#State 46
		DEFAULT => -81
	},
	{#State 47
		ACTIONS => {
			'WORD' => 58,
			"\$" => 17,
			"{" => 49
		},
		GOTOS => {
			'scalar' => 57,
			'indirob' => 112,
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
			'LOOPEX' => 43,
			"&" => 47,
			'UNIOP' => 48,
			"{" => 49
		},
		DEFAULT => -93,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 113,
			'ary' => 13,
			'termbinop' => 19,
			'block' => 114,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 49
		DEFAULT => -3,
		GOTOS => {
			'remember' => 115
		}
	},
	{#State 50
		DEFAULT => -39
	},
	{#State 51
		DEFAULT => -42,
		GOTOS => {
			'startsub' => 116
		}
	},
	{#State 52
		DEFAULT => -37
	},
	{#State 53
		ACTIONS => {
			'CONTINUE' => 117
		},
		DEFAULT => -22,
		GOTOS => {
			'cont' => 118
		}
	},
	{#State 54
		ACTIONS => {
			"," => 119
		},
		DEFAULT => -52
	},
	{#State 55
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 95,
			'POSTDEC' => 102
		},
		DEFAULT => -67
	},
	{#State 56
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 120,
			'termbinop' => 19,
			'argexpr' => 54,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 57
		DEFAULT => -124
	},
	{#State 58
		DEFAULT => -123
	},
	{#State 59
		DEFAULT => -120
	},
	{#State 60
		DEFAULT => -125
	},
	{#State 61
		ACTIONS => {
			";" => 121
		}
	},
	{#State 62
		DEFAULT => -47
	},
	{#State 63
		DEFAULT => -121
	},
	{#State 64
		DEFAULT => -109
	},
	{#State 65
		DEFAULT => -111
	},
	{#State 66
		DEFAULT => -110
	},
	{#State 67
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			")" => 123,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 122,
			'termbinop' => 19,
			'argexpr' => 54,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 68
		ACTIONS => {
			'myattrlist' => 124
		},
		DEFAULT => -106
	},
	{#State 69
		ACTIONS => {
			"-" => -123,
			'WORD' => -123,
			"\@" => -123,
			"%" => -123,
			'MY' => -123,
			'LSTOP' => -123,
			"!" => -123,
			"\$" => -123,
			'NOTOP' => -123,
			'PMFUNC' => -123,
			"(" => -123,
			'FUNC1' => -123,
			"+" => -123,
			'NOAMP' => -123,
			'STRING' => -123,
			'FUNC' => -123,
			'DOLSHARP' => -123,
			'LOOPEX' => -123,
			"&" => -123,
			'UNIOP' => -123
		},
		DEFAULT => -100
	},
	{#State 70
		ACTIONS => {
			"-" => -124,
			'WORD' => -124,
			"\@" => -124,
			"%" => -124,
			'MY' => -124,
			'LSTOP' => -124,
			"!" => -124,
			"\$" => -124,
			"[" => 56,
			'NOTOP' => -124,
			'PMFUNC' => -124,
			"(" => -124,
			'FUNC1' => -124,
			"+" => -124,
			'NOAMP' => -124,
			'STRING' => -124,
			'FUNC' => -124,
			'DOLSHARP' => -124,
			'LOOPEX' => -124,
			"&" => -124,
			'UNIOP' => -124
		},
		DEFAULT => -78
	},
	{#State 71
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'termbinop' => 19,
			'argexpr' => 125,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 72
		DEFAULT => -103
	},
	{#State 73
		ACTIONS => {
			"," => 119
		},
		DEFAULT => -113
	},
	{#State 74
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 126,
			'termbinop' => 19,
			'argexpr' => 54,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 75
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 127,
			'termbinop' => 19,
			'argexpr' => 54,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 76
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 95,
			'POSTDEC' => 102
		},
		DEFAULT => -69
	},
	{#State 77
		DEFAULT => -119
	},
	{#State 78
		DEFAULT => -3,
		GOTOS => {
			'remember' => 128
		}
	},
	{#State 79
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 129,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 80
		ACTIONS => {
			"," => 119
		},
		DEFAULT => -92
	},
	{#State 81
		ACTIONS => {
			'WORD' => 130
		},
		GOTOS => {
			'subname' => 131
		}
	},
	{#State 82
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			")" => 133,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 132,
			'termbinop' => 19,
			'argexpr' => 54,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 83
		ACTIONS => {
			'OROP' => 108,
			")" => 134,
			'ANDOP' => 106
		}
	},
	{#State 84
		ACTIONS => {
			"[" => 135
		},
		DEFAULT => -77
	},
	{#State 85
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			")" => 137,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 136,
			'termbinop' => 19,
			'argexpr' => 54,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 86
		DEFAULT => -11
	},
	{#State 87
		ACTIONS => {
			"(" => 138
		}
	},
	{#State 88
		DEFAULT => -3,
		GOTOS => {
			'remember' => 139
		}
	},
	{#State 89
		DEFAULT => -3,
		GOTOS => {
			'remember' => 140
		}
	},
	{#State 90
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 95,
			'POSTDEC' => 102
		},
		DEFAULT => -68
	},
	{#State 91
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
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
			'LOOPEX' => 43,
			"&" => 47,
			'UNIOP' => 48
		},
		DEFAULT => -112,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'termbinop' => 19,
			'argexpr' => 73,
			'listexpr' => 141,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 92
		DEFAULT => -122
	},
	{#State 93
		ACTIONS => {
			"-" => 5,
			'WORD' => 69,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			"{" => 49,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		DEFAULT => -114,
		GOTOS => {
			'scalar' => 70,
			'arylen' => 46,
			'indirob' => 142,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 144,
			'termbinop' => 19,
			'listexprcom' => 143,
			'block' => 60,
			'argexpr' => 54,
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
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
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
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
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
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
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
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
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
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
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
	{#State 99
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
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
	{#State 100
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
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
	{#State 101
		DEFAULT => -70
	},
	{#State 102
		DEFAULT => -71
	},
	{#State 103
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
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
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
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
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
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
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 155,
			'termbinop' => 19,
			'argexpr' => 54,
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
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 156,
			'termbinop' => 19,
			'argexpr' => 54,
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
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 157,
			'termbinop' => 19,
			'argexpr' => 54,
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
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 158,
			'termbinop' => 19,
			'argexpr' => 54,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 110
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 159,
			'termbinop' => 19,
			'argexpr' => 54,
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
		DEFAULT => -118
	},
	{#State 113
		ACTIONS => {
			'ADDOP' => 100,
			'POSTINC' => 101,
			'POWOP' => 95,
			'MATCHOP' => 96,
			'POSTDEC' => 102,
			'MULOP' => 104
		},
		DEFAULT => -95
	},
	{#State 114
		DEFAULT => -94
	},
	{#State 115
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 161
		}
	},
	{#State 116
		DEFAULT => -48,
		GOTOS => {
			'@1-2' => 162
		}
	},
	{#State 117
		ACTIONS => {
			"{" => 49
		},
		GOTOS => {
			'block' => 163
		}
	},
	{#State 118
		DEFAULT => -29
	},
	{#State 119
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
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
			'LOOPEX' => 43,
			"&" => 47,
			'UNIOP' => 48
		},
		DEFAULT => -53,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 164,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 120
		ACTIONS => {
			'OROP' => 108,
			"]" => 165,
			'ANDOP' => 106
		}
	},
	{#State 121
		DEFAULT => -46
	},
	{#State 122
		ACTIONS => {
			'OROP' => 108,
			")" => 166,
			'ANDOP' => 106
		}
	},
	{#State 123
		DEFAULT => -108
	},
	{#State 124
		DEFAULT => -105
	},
	{#State 125
		ACTIONS => {
			"," => 119
		},
		DEFAULT => -101
	},
	{#State 126
		ACTIONS => {
			'OROP' => 108,
			"]" => 167,
			'ANDOP' => 106
		}
	},
	{#State 127
		ACTIONS => {
			";" => 168,
			'OROP' => 108,
			'ANDOP' => 106
		}
	},
	{#State 128
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 169,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 170,
			'termbinop' => 19,
			'argexpr' => 54,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 129
		ACTIONS => {
			'MATCHOP' => 96,
			'POSTDEC' => 102,
			'MULOP' => 104,
			'DOTDOT' => 103,
			'ADDOP' => 100,
			"," => 171,
			'ASSIGNOP' => 94,
			'OROR' => 105,
			'POSTINC' => 101,
			'ANDAND' => 97,
			")" => 172,
			'POWOP' => 95,
			'EQOP' => 98,
			'RELOP' => 99
		}
	},
	{#State 130
		DEFAULT => -43
	},
	{#State 131
		ACTIONS => {
			";" => 174,
			"{" => 49
		},
		GOTOS => {
			'block' => 175,
			'subbody' => 173
		}
	},
	{#State 132
		ACTIONS => {
			'OROP' => 108,
			")" => 176,
			'ANDOP' => 106
		}
	},
	{#State 133
		DEFAULT => -88
	},
	{#State 134
		ACTIONS => {
			"[" => 177
		},
		DEFAULT => -76
	},
	{#State 135
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 178,
			'termbinop' => 19,
			'argexpr' => 54,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 136
		ACTIONS => {
			'OROP' => 108,
			")" => 179,
			'ANDOP' => 106
		}
	},
	{#State 137
		DEFAULT => -96
	},
	{#State 138
		DEFAULT => -3,
		GOTOS => {
			'remember' => 180
		}
	},
	{#State 139
		ACTIONS => {
			"\$" => 17
		},
		GOTOS => {
			'scalar' => 181,
			'my_scalar' => 182
		}
	},
	{#State 140
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			";" => -30,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'error' => 44,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 183,
			'scalar' => 6,
			'sideff' => 185,
			'term' => 39,
			'ary' => 13,
			'expr' => 186,
			'nexpr' => 187,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21,
			'arylen' => 46,
			'mnexpr' => 184,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'argexpr' => 54
		}
	},
	{#State 141
		DEFAULT => -90
	},
	{#State 142
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 188,
			'termbinop' => 19,
			'argexpr' => 54,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 143
		ACTIONS => {
			")" => 189
		}
	},
	{#State 144
		ACTIONS => {
			'OROP' => 108,
			"," => 190,
			'ANDOP' => 106
		},
		DEFAULT => -115
	},
	{#State 145
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
		DEFAULT => -57
	},
	{#State 146
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 95,
			'POSTDEC' => 102
		},
		DEFAULT => -58
	},
	{#State 147
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 95,
			'POSTDEC' => 102
		},
		DEFAULT => -66
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
			'EQOP' => 98
		},
		DEFAULT => -64
	},
	{#State 149
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
		DEFAULT => -62
	},
	{#State 150
		ACTIONS => {
			'ADDOP' => 100,
			'POSTINC' => 101,
			'POWOP' => 95,
			'MATCHOP' => 96,
			'POSTDEC' => 102,
			'MULOP' => 104,
			'RELOP' => undef
		},
		DEFAULT => -61
	},
	{#State 151
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 95,
			'MATCHOP' => 96,
			'POSTDEC' => 102,
			'MULOP' => 104
		},
		DEFAULT => -60
	},
	{#State 152
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
		DEFAULT => -63
	},
	{#State 153
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 95,
			'MATCHOP' => 96,
			'POSTDEC' => 102
		},
		DEFAULT => -59
	},
	{#State 154
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
		DEFAULT => -65
	},
	{#State 155
		DEFAULT => -50
	},
	{#State 156
		ACTIONS => {
			'OROP' => 108,
			'ANDOP' => 106
		},
		DEFAULT => -15
	},
	{#State 157
		ACTIONS => {
			'ANDOP' => 106
		},
		DEFAULT => -51
	},
	{#State 158
		ACTIONS => {
			'OROP' => 108,
			'ANDOP' => 106
		},
		DEFAULT => -17
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
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		DEFAULT => -32,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 193,
			'texpr' => 191,
			'termbinop' => 19,
			'mtexpr' => 192,
			'argexpr' => 54,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 161
		ACTIONS => {
			"}" => 194,
			"-" => 5,
			'WORD' => 4,
			'PACKAGE' => 8,
			"\@" => 7,
			'FOR' => 34,
			"+" => 35,
			'COMMENT' => 11,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'IF' => 18,
			"\$" => 17,
			'error' => 44,
			'LOOPEX' => 43,
			'WHILE' => 45,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'SUB' => 26,
			"{" => 49,
			'UNIOP' => 48,
			"&" => 47,
			'USE' => 51,
			"(" => 30,
			'format' => 52,
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
			'use' => 42,
			'decl' => 16,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21,
			'line' => 22,
			'cond' => 25,
			'arylen' => 46,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'package' => 50,
			'block' => 53,
			'argexpr' => 54
		}
	},
	{#State 162
		ACTIONS => {
			'WORD' => 195
		}
	},
	{#State 163
		DEFAULT => -23
	},
	{#State 164
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
	{#State 165
		DEFAULT => -56
	},
	{#State 166
		DEFAULT => -107
	},
	{#State 167
		DEFAULT => -85
	},
	{#State 168
		ACTIONS => {
			"}" => 196
		}
	},
	{#State 169
		ACTIONS => {
			")" => 197
		}
	},
	{#State 170
		ACTIONS => {
			'OROP' => 108,
			'ANDOP' => 106
		},
		DEFAULT => -34
	},
	{#State 171
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 198,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 172
		DEFAULT => -98
	},
	{#State 173
		DEFAULT => -41
	},
	{#State 174
		DEFAULT => -45
	},
	{#State 175
		DEFAULT => -44
	},
	{#State 176
		DEFAULT => -89
	},
	{#State 177
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 199,
			'termbinop' => 19,
			'argexpr' => 54,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 178
		ACTIONS => {
			'OROP' => 108,
			"]" => 200,
			'ANDOP' => 106
		}
	},
	{#State 179
		DEFAULT => -97
	},
	{#State 180
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 201,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 170,
			'termbinop' => 19,
			'argexpr' => 54,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 181
		DEFAULT => -117
	},
	{#State 182
		ACTIONS => {
			"(" => 202
		}
	},
	{#State 183
		ACTIONS => {
			")" => 203
		}
	},
	{#State 184
		ACTIONS => {
			";" => 204
		}
	},
	{#State 185
		DEFAULT => -31
	},
	{#State 186
		ACTIONS => {
			'FOR' => 109,
			'OROP' => 108,
			'ANDOP' => 106,
			'IF' => 107,
			")" => -34,
			'WHILE' => 110
		},
		DEFAULT => -14
	},
	{#State 187
		DEFAULT => -35
	},
	{#State 188
		ACTIONS => {
			'OROP' => 108,
			")" => 205,
			'ANDOP' => 106
		}
	},
	{#State 189
		DEFAULT => -104
	},
	{#State 190
		DEFAULT => -116
	},
	{#State 191
		DEFAULT => -36
	},
	{#State 192
		ACTIONS => {
			")" => 206
		}
	},
	{#State 193
		ACTIONS => {
			'OROP' => 108,
			'ANDOP' => 106
		},
		DEFAULT => -33
	},
	{#State 194
		DEFAULT => -2
	},
	{#State 195
		ACTIONS => {
			'WORD' => 207
		}
	},
	{#State 196
		DEFAULT => -86
	},
	{#State 197
		ACTIONS => {
			"{" => 208
		},
		GOTOS => {
			'mblock' => 209
		}
	},
	{#State 198
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
			")" => 210,
			'POWOP' => 95,
			'EQOP' => 98,
			'RELOP' => 99
		}
	},
	{#State 199
		ACTIONS => {
			'OROP' => 108,
			"]" => 211,
			'ANDOP' => 106
		}
	},
	{#State 200
		DEFAULT => -84
	},
	{#State 201
		ACTIONS => {
			")" => 212
		}
	},
	{#State 202
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 213,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 170,
			'termbinop' => 19,
			'argexpr' => 54,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 203
		ACTIONS => {
			"{" => 208
		},
		GOTOS => {
			'mblock' => 214
		}
	},
	{#State 204
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		DEFAULT => -32,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 193,
			'texpr' => 191,
			'termbinop' => 19,
			'mtexpr' => 215,
			'argexpr' => 54,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 205
		DEFAULT => -102
	},
	{#State 206
		ACTIONS => {
			"{" => 208
		},
		GOTOS => {
			'mblock' => 216
		}
	},
	{#State 207
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		DEFAULT => -112,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'termbinop' => 19,
			'argexpr' => 73,
			'listexpr' => 217,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 208
		DEFAULT => -5,
		GOTOS => {
			'mremember' => 218
		}
	},
	{#State 209
		ACTIONS => {
			'ELSE' => 219,
			'ELSIF' => 221
		},
		DEFAULT => -18,
		GOTOS => {
			'else' => 220
		}
	},
	{#State 210
		DEFAULT => -99
	},
	{#State 211
		DEFAULT => -83
	},
	{#State 212
		ACTIONS => {
			"{" => 208
		},
		GOTOS => {
			'mblock' => 222
		}
	},
	{#State 213
		ACTIONS => {
			")" => 223
		}
	},
	{#State 214
		ACTIONS => {
			'CONTINUE' => 117
		},
		DEFAULT => -22,
		GOTOS => {
			'cont' => 224
		}
	},
	{#State 215
		ACTIONS => {
			";" => 225
		}
	},
	{#State 216
		ACTIONS => {
			'CONTINUE' => 117
		},
		DEFAULT => -22,
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
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 228
		}
	},
	{#State 219
		ACTIONS => {
			"{" => 208
		},
		GOTOS => {
			'mblock' => 229
		}
	},
	{#State 220
		DEFAULT => -21
	},
	{#State 221
		ACTIONS => {
			"(" => 230
		}
	},
	{#State 222
		ACTIONS => {
			'CONTINUE' => 117
		},
		DEFAULT => -22,
		GOTOS => {
			'cont' => 231
		}
	},
	{#State 223
		ACTIONS => {
			"{" => 208
		},
		GOTOS => {
			'mblock' => 232
		}
	},
	{#State 224
		DEFAULT => -27
	},
	{#State 225
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'error' => 44,
			'LOOPEX' => 43,
			")" => -30,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 46,
			'sideff' => 185,
			'mnexpr' => 233,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 41,
			'nexpr' => 187,
			'termbinop' => 19,
			'argexpr' => 54,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 226
		DEFAULT => -24
	},
	{#State 227
		DEFAULT => -49
	},
	{#State 228
		ACTIONS => {
			"}" => 234,
			"-" => 5,
			'WORD' => 4,
			'PACKAGE' => 8,
			"\@" => 7,
			'FOR' => 34,
			"+" => 35,
			'COMMENT' => 11,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			'IF' => 18,
			"\$" => 17,
			'error' => 44,
			'LOOPEX' => 43,
			'WHILE' => 45,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'SUB' => 26,
			"{" => 49,
			'UNIOP' => 48,
			"&" => 47,
			'USE' => 51,
			"(" => 30,
			'format' => 52,
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
			'use' => 42,
			'decl' => 16,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21,
			'line' => 22,
			'cond' => 25,
			'arylen' => 46,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'package' => 50,
			'block' => 53,
			'argexpr' => 54
		}
	},
	{#State 229
		DEFAULT => -19
	},
	{#State 230
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 12,
			'STRING' => 40,
			'FUNC' => 38,
			'DOLSHARP' => 37,
			"!" => 15,
			"\$" => 17,
			'LOOPEX' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 48,
			"&" => 47,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 235,
			'scalar' => 6,
			'arylen' => 46,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 170,
			'termbinop' => 19,
			'argexpr' => 54,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 231
		DEFAULT => -26
	},
	{#State 232
		ACTIONS => {
			'CONTINUE' => 117
		},
		DEFAULT => -22,
		GOTOS => {
			'cont' => 236
		}
	},
	{#State 233
		ACTIONS => {
			")" => 237
		}
	},
	{#State 234
		DEFAULT => -4
	},
	{#State 235
		ACTIONS => {
			")" => 238
		}
	},
	{#State 236
		DEFAULT => -25
	},
	{#State 237
		ACTIONS => {
			"{" => 208
		},
		GOTOS => {
			'mblock' => 239
		}
	},
	{#State 238
		ACTIONS => {
			"{" => 208
		},
		GOTOS => {
			'mblock' => 240
		}
	},
	{#State 239
		DEFAULT => -28
	},
	{#State 240
		ACTIONS => {
			'ELSE' => 219,
			'ELSIF' => 221
		},
		DEFAULT => -18,
		GOTOS => {
			'else' => 241
		}
	},
	{#State 241
		DEFAULT => -20
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
#line 185 "plpy.yp"
{
                printer(\@_, "prog", "lineseq");
                return "$_[1]";
            }
	],
	[#Rule 2
		 'block', 4,
sub
#line 193 "plpy.yp"
{}
	],
	[#Rule 3
		 'remember', 0,
sub
#line 197 "plpy.yp"
{}
	],
	[#Rule 4
		 'mblock', 4,
sub
#line 201 "plpy.yp"
{}
	],
	[#Rule 5
		 'mremember', 0,
sub
#line 205 "plpy.yp"
{}
	],
	[#Rule 6
		 'lineseq', 0,
sub
#line 210 "plpy.yp"
{}
	],
	[#Rule 7
		 'lineseq', 2,
sub
#line 212 "plpy.yp"
{}
	],
	[#Rule 8
		 'lineseq', 2,
sub
#line 214 "plpy.yp"
{
                printer(\@_, "lineseq", "lineseq", "line");
                return "$_[1]$_[2]";
            }
	],
	[#Rule 9
		 'line', 1,
sub
#line 222 "plpy.yp"
{}
	],
	[#Rule 10
		 'line', 1, undef
	],
	[#Rule 11
		 'line', 2,
sub
#line 225 "plpy.yp"
{
                printer(\@_, "line", "sideff", "';'");
                return "$_[1]\n";
            }
	],
	[#Rule 12
		 'line', 1,
sub
#line 230 "plpy.yp"
{
                printer(\@_, "line", "COMMENT");
                return "$_[1]\n";
            }
	],
	[#Rule 13
		 'sideff', 1,
sub
#line 238 "plpy.yp"
{}
	],
	[#Rule 14
		 'sideff', 1,
sub
#line 240 "plpy.yp"
{
                printer(\@_, "sideff", "expr");
                return $_[1];
            }
	],
	[#Rule 15
		 'sideff', 3,
sub
#line 246 "plpy.yp"
{}
	],
	[#Rule 16
		 'sideff', 3,
sub
#line 248 "plpy.yp"
{}
	],
	[#Rule 17
		 'sideff', 3,
sub
#line 250 "plpy.yp"
{}
	],
	[#Rule 18
		 'else', 0,
sub
#line 255 "plpy.yp"
{}
	],
	[#Rule 19
		 'else', 2,
sub
#line 257 "plpy.yp"
{}
	],
	[#Rule 20
		 'else', 6,
sub
#line 259 "plpy.yp"
{}
	],
	[#Rule 21
		 'cond', 7,
sub
#line 264 "plpy.yp"
{}
	],
	[#Rule 22
		 'cont', 0,
sub
#line 269 "plpy.yp"
{}
	],
	[#Rule 23
		 'cont', 2,
sub
#line 271 "plpy.yp"
{}
	],
	[#Rule 24
		 'loop', 7,
sub
#line 276 "plpy.yp"
{}
	],
	[#Rule 25
		 'loop', 9,
sub
#line 278 "plpy.yp"
{}
	],
	[#Rule 26
		 'loop', 8,
sub
#line 280 "plpy.yp"
{}
	],
	[#Rule 27
		 'loop', 7,
sub
#line 282 "plpy.yp"
{}
	],
	[#Rule 28
		 'loop', 10,
sub
#line 285 "plpy.yp"
{}
	],
	[#Rule 29
		 'loop', 2,
sub
#line 288 "plpy.yp"
{}
	],
	[#Rule 30
		 'nexpr', 0,
sub
#line 293 "plpy.yp"
{}
	],
	[#Rule 31
		 'nexpr', 1, undef
	],
	[#Rule 32
		 'texpr', 0,
sub
#line 299 "plpy.yp"
{}
	],
	[#Rule 33
		 'texpr', 1, undef
	],
	[#Rule 34
		 'mexpr', 1,
sub
#line 312 "plpy.yp"
{}
	],
	[#Rule 35
		 'mnexpr', 1,
sub
#line 316 "plpy.yp"
{}
	],
	[#Rule 36
		 'mtexpr', 1,
sub
#line 320 "plpy.yp"
{}
	],
	[#Rule 37
		 'decl', 1,
sub
#line 325 "plpy.yp"
{}
	],
	[#Rule 38
		 'decl', 1,
sub
#line 327 "plpy.yp"
{}
	],
	[#Rule 39
		 'decl', 1,
sub
#line 329 "plpy.yp"
{}
	],
	[#Rule 40
		 'decl', 1,
sub
#line 331 "plpy.yp"
{}
	],
	[#Rule 41
		 'subrout', 4,
sub
#line 336 "plpy.yp"
{}
	],
	[#Rule 42
		 'startsub', 0,
sub
#line 340 "plpy.yp"
{}
	],
	[#Rule 43
		 'subname', 1,
sub
#line 344 "plpy.yp"
{}
	],
	[#Rule 44
		 'subbody', 1,
sub
#line 348 "plpy.yp"
{}
	],
	[#Rule 45
		 'subbody', 1,
sub
#line 349 "plpy.yp"
{}
	],
	[#Rule 46
		 'package', 3,
sub
#line 353 "plpy.yp"
{}
	],
	[#Rule 47
		 'package', 2,
sub
#line 355 "plpy.yp"
{}
	],
	[#Rule 48
		 '@1-2', 0,
sub
#line 359 "plpy.yp"
{}
	],
	[#Rule 49
		 'use', 7,
sub
#line 361 "plpy.yp"
{}
	],
	[#Rule 50
		 'expr', 3,
sub
#line 366 "plpy.yp"
{}
	],
	[#Rule 51
		 'expr', 3,
sub
#line 368 "plpy.yp"
{}
	],
	[#Rule 52
		 'expr', 1, undef
	],
	[#Rule 53
		 'argexpr', 2,
sub
#line 374 "plpy.yp"
{
                printer (\@_, "argexpr", "','");
                return "$_[1], ";
            }
	],
	[#Rule 54
		 'argexpr', 3,
sub
#line 379 "plpy.yp"
{
                printer (\@_, "argexpr", "','", "term");
                return "$_[1], $_[3]";
            }
	],
	[#Rule 55
		 'argexpr', 1,
sub
#line 384 "plpy.yp"
{
                printer (\@_, "argexpr", "term");
                return $_[1];
            }
	],
	[#Rule 56
		 'subscripted', 4,
sub
#line 394 "plpy.yp"
{}
	],
	[#Rule 57
		 'termbinop', 3,
sub
#line 399 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "ASSIGNOP", "term");
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 58
		 'termbinop', 3,
sub
#line 404 "plpy.yp"
{}
	],
	[#Rule 59
		 'termbinop', 3,
sub
#line 406 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "MULOP", "term");
                return "int($_[1]) $_[2] int($_[3])";
            }
	],
	[#Rule 60
		 'termbinop', 3,
sub
#line 411 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "ADDOP", "term");
                return "int($_[1]) $_[2] int($_[3])";
            }
	],
	[#Rule 61
		 'termbinop', 3,
sub
#line 416 "plpy.yp"
{}
	],
	[#Rule 62
		 'termbinop', 3,
sub
#line 418 "plpy.yp"
{}
	],
	[#Rule 63
		 'termbinop', 3,
sub
#line 420 "plpy.yp"
{}
	],
	[#Rule 64
		 'termbinop', 3,
sub
#line 422 "plpy.yp"
{}
	],
	[#Rule 65
		 'termbinop', 3,
sub
#line 424 "plpy.yp"
{}
	],
	[#Rule 66
		 'termbinop', 3,
sub
#line 426 "plpy.yp"
{}
	],
	[#Rule 67
		 'termunop', 2,
sub
#line 431 "plpy.yp"
{}
	],
	[#Rule 68
		 'termunop', 2,
sub
#line 433 "plpy.yp"
{}
	],
	[#Rule 69
		 'termunop', 2,
sub
#line 435 "plpy.yp"
{}
	],
	[#Rule 70
		 'termunop', 2,
sub
#line 437 "plpy.yp"
{}
	],
	[#Rule 71
		 'termunop', 2,
sub
#line 439 "plpy.yp"
{}
	],
	[#Rule 72
		 'term', 1, undef
	],
	[#Rule 73
		 'term', 1, undef
	],
	[#Rule 74
		 'term', 1,
sub
#line 445 "plpy.yp"
{
                printer (\@_, "term", "STRING");
                return $_[1];
            
            }
	],
	[#Rule 75
		 'term', 1,
sub
#line 452 "plpy.yp"
{}
	],
	[#Rule 76
		 'term', 3,
sub
#line 454 "plpy.yp"
{}
	],
	[#Rule 77
		 'term', 2,
sub
#line 456 "plpy.yp"
{}
	],
	[#Rule 78
		 'term', 1,
sub
#line 458 "plpy.yp"
{
                printer (\@_, "term", "scalar");
                return $_[1];
            }
	],
	[#Rule 79
		 'term', 1,
sub
#line 463 "plpy.yp"
{}
	],
	[#Rule 80
		 'term', 1,
sub
#line 465 "plpy.yp"
{}
	],
	[#Rule 81
		 'term', 1,
sub
#line 467 "plpy.yp"
{}
	],
	[#Rule 82
		 'term', 1,
sub
#line 469 "plpy.yp"
{}
	],
	[#Rule 83
		 'term', 6,
sub
#line 471 "plpy.yp"
{}
	],
	[#Rule 84
		 'term', 5,
sub
#line 473 "plpy.yp"
{}
	],
	[#Rule 85
		 'term', 4,
sub
#line 475 "plpy.yp"
{}
	],
	[#Rule 86
		 'term', 5,
sub
#line 477 "plpy.yp"
{}
	],
	[#Rule 87
		 'term', 1,
sub
#line 479 "plpy.yp"
{}
	],
	[#Rule 88
		 'term', 3,
sub
#line 481 "plpy.yp"
{}
	],
	[#Rule 89
		 'term', 4,
sub
#line 483 "plpy.yp"
{}
	],
	[#Rule 90
		 'term', 3,
sub
#line 485 "plpy.yp"
{}
	],
	[#Rule 91
		 'term', 1,
sub
#line 487 "plpy.yp"
{}
	],
	[#Rule 92
		 'term', 2,
sub
#line 489 "plpy.yp"
{}
	],
	[#Rule 93
		 'term', 1,
sub
#line 491 "plpy.yp"
{}
	],
	[#Rule 94
		 'term', 2,
sub
#line 493 "plpy.yp"
{}
	],
	[#Rule 95
		 'term', 2,
sub
#line 495 "plpy.yp"
{}
	],
	[#Rule 96
		 'term', 3,
sub
#line 497 "plpy.yp"
{}
	],
	[#Rule 97
		 'term', 4,
sub
#line 499 "plpy.yp"
{}
	],
	[#Rule 98
		 'term', 4,
sub
#line 501 "plpy.yp"
{}
	],
	[#Rule 99
		 'term', 6,
sub
#line 503 "plpy.yp"
{}
	],
	[#Rule 100
		 'term', 1, undef
	],
	[#Rule 101
		 'term', 3,
sub
#line 508 "plpy.yp"
{
                printer (\@_, "term", "LSTOP", "indirob", "argexpr");
            }
	],
	[#Rule 102
		 'term', 5,
sub
#line 512 "plpy.yp"
{}
	],
	[#Rule 103
		 'term', 2,
sub
#line 514 "plpy.yp"
{
                printer (\@_, "term", "LSTOP", "listexpr");
                return "print($_[2])";
            
            }
	],
	[#Rule 104
		 'term', 4,
sub
#line 520 "plpy.yp"
{}
	],
	[#Rule 105
		 'myattrterm', 3,
sub
#line 525 "plpy.yp"
{}
	],
	[#Rule 106
		 'myattrterm', 2,
sub
#line 527 "plpy.yp"
{}
	],
	[#Rule 107
		 'myterm', 3,
sub
#line 532 "plpy.yp"
{}
	],
	[#Rule 108
		 'myterm', 2,
sub
#line 534 "plpy.yp"
{}
	],
	[#Rule 109
		 'myterm', 1,
sub
#line 536 "plpy.yp"
{}
	],
	[#Rule 110
		 'myterm', 1,
sub
#line 538 "plpy.yp"
{}
	],
	[#Rule 111
		 'myterm', 1,
sub
#line 540 "plpy.yp"
{}
	],
	[#Rule 112
		 'listexpr', 0,
sub
#line 546 "plpy.yp"
{print "empty listexpr\n";}
	],
	[#Rule 113
		 'listexpr', 1,
sub
#line 548 "plpy.yp"
{
                printer (\@_, "listexpr", "argexpr");
                return $_[1];
            }
	],
	[#Rule 114
		 'listexprcom', 0,
sub
#line 556 "plpy.yp"
{}
	],
	[#Rule 115
		 'listexprcom', 1,
sub
#line 558 "plpy.yp"
{}
	],
	[#Rule 116
		 'listexprcom', 2,
sub
#line 560 "plpy.yp"
{}
	],
	[#Rule 117
		 'my_scalar', 1,
sub
#line 566 "plpy.yp"
{}
	],
	[#Rule 118
		 'amper', 2,
sub
#line 570 "plpy.yp"
{}
	],
	[#Rule 119
		 'scalar', 2,
sub
#line 574 "plpy.yp"
{
                printer (\@_, "scalar", "'\$'", "indirob"); 
                return "$_[2]";
            }
	],
	[#Rule 120
		 'ary', 2,
sub
#line 581 "plpy.yp"
{}
	],
	[#Rule 121
		 'hsh', 2,
sub
#line 585 "plpy.yp"
{}
	],
	[#Rule 122
		 'arylen', 2,
sub
#line 589 "plpy.yp"
{}
	],
	[#Rule 123
		 'indirob', 1,
sub
#line 594 "plpy.yp"
{
                printer (\@_, "indirob", "WORD");
                return $_[1];
            }
	],
	[#Rule 124
		 'indirob', 1,
sub
#line 599 "plpy.yp"
{}
	],
	[#Rule 125
		 'indirob', 1,
sub
#line 601 "plpy.yp"
{}
	]
],
                                  @_);
    bless($self,$class);
}

#line 604 "plpy.yp"


1;
