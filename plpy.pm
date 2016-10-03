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
    print "___Remaining___\n", $_[0]->YYData->{"DATA"}, "\n_______________\n" ;
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
            print "Found match ($token): ($&), $length[$i]\n";
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
    my @tokens = @{shift(@_)};
    my @words = @_;
    my $parser = shift(@tokens);
    my $word_string = join("->", @words);
    my $token_string = "$words[0]"."->";
    $token_string .= join("->", @tokens);
    
    print "$word_string\n";
    print "$token_string\n";
    print "('", $parser->YYCurtok, "': '", $parser->YYCurval, "')\n";
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
			"+" => 34,
			'FOR' => 33,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			'IF' => 17,
			"\$" => 16,
			'error' => 43,
			'LOOPEX' => 42,
			'WHILE' => 44,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'SUB' => 25,
			"{" => 48,
			'UNIOP' => 47,
			"&" => 46,
			'USE' => 50,
			"(" => 29,
			'format' => 51,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 31,
			'sideff' => 32,
			'term' => 38,
			'loop' => 13,
			'ary' => 12,
			'use' => 41,
			'expr' => 40,
			'decl' => 15,
			'termbinop' => 18,
			'hsh' => 19,
			'termunop' => 20,
			'line' => 21,
			'cond' => 24,
			'arylen' => 45,
			'amper' => 26,
			'myattrterm' => 27,
			'subscripted' => 28,
			'package' => 49,
			'block' => 52,
			'argexpr' => 53
		}
	},
	{#State 3
		DEFAULT => 0
	},
	{#State 4
		DEFAULT => -99
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 54,
			'ary' => 12,
			'termbinop' => 18,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 6
		ACTIONS => {
			"[" => 55
		},
		DEFAULT => -77
	},
	{#State 7
		ACTIONS => {
			'WORD' => 57,
			"\$" => 16,
			"{" => 48
		},
		GOTOS => {
			'scalar' => 56,
			'indirob' => 58,
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
			'WORD' => 57,
			"\$" => 16,
			"{" => 48
		},
		GOTOS => {
			'scalar' => 56,
			'indirob' => 62,
			'block' => 59
		}
	},
	{#State 10
		ACTIONS => {
			"(" => 66,
			"\@" => 7,
			"\$" => 16,
			"%" => 9
		},
		GOTOS => {
			'scalar' => 63,
			'myterm' => 67,
			'hsh' => 65,
			'ary' => 64
		}
	},
	{#State 11
		ACTIONS => {
			"-" => 5,
			'WORD' => 68,
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
			'FUNC' => 37,
			'STRING' => 39,
			'LOOPEX' => 42,
			"&" => 46,
			'UNIOP' => 47,
			"{" => 48
		},
		DEFAULT => -111,
		GOTOS => {
			'scalar' => 69,
			'arylen' => 45,
			'indirob' => 70,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'termbinop' => 18,
			'block' => 59,
			'argexpr' => 72,
			'listexpr' => 71,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 12
		ACTIONS => {
			"[" => 73,
			"{" => 74
		},
		DEFAULT => -79
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 75,
			'ary' => 12,
			'termbinop' => 18,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 15
		DEFAULT => -7
	},
	{#State 16
		ACTIONS => {
			'WORD' => 57,
			"\$" => 16,
			"{" => 48
		},
		GOTOS => {
			'scalar' => 56,
			'indirob' => 76,
			'block' => 59
		}
	},
	{#State 17
		ACTIONS => {
			"(" => 77
		}
	},
	{#State 18
		DEFAULT => -71
	},
	{#State 19
		DEFAULT => -78
	},
	{#State 20
		DEFAULT => -72
	},
	{#State 21
		DEFAULT => -8
	},
	{#State 22
		ACTIONS => {
			"(" => 78
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 79,
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
			'startsub' => 80
		}
	},
	{#State 26
		ACTIONS => {
			"(" => 81
		},
		DEFAULT => -86
	},
	{#State 27
		DEFAULT => -74
	},
	{#State 28
		DEFAULT => -81
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			")" => 83,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 82,
			'termbinop' => 18,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 30
		ACTIONS => {
			"(" => 84
		}
	},
	{#State 31
		DEFAULT => -37
	},
	{#State 32
		ACTIONS => {
			";" => 85
		}
	},
	{#State 33
		ACTIONS => {
			"(" => 88,
			"\$" => 16,
			'MY' => 87
		},
		GOTOS => {
			'scalar' => 86
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 89,
			'ary' => 12,
			'termbinop' => 18,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 35
		ACTIONS => {
			'WORD' => 90
		}
	},
	{#State 36
		ACTIONS => {
			'WORD' => 57,
			"\$" => 16,
			"{" => 48
		},
		GOTOS => {
			'scalar' => 56,
			'indirob' => 91,
			'block' => 59
		}
	},
	{#State 37
		ACTIONS => {
			"(" => 92
		}
	},
	{#State 38
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
	{#State 39
		DEFAULT => -73
	},
	{#State 40
		ACTIONS => {
			'FOR' => 108,
			'OROP' => 107,
			'ANDOP' => 105,
			'IF' => 106,
			'WHILE' => 109
		},
		DEFAULT => -13
	},
	{#State 41
		DEFAULT => -39
	},
	{#State 42
		DEFAULT => -90
	},
	{#State 43
		DEFAULT => -12
	},
	{#State 44
		ACTIONS => {
			"(" => 110
		}
	},
	{#State 45
		DEFAULT => -80
	},
	{#State 46
		ACTIONS => {
			'WORD' => 57,
			"\$" => 16,
			"{" => 48
		},
		GOTOS => {
			'scalar' => 56,
			'indirob' => 111,
			'block' => 59
		}
	},
	{#State 47
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
			'FUNC' => 37,
			'STRING' => 39,
			'LOOPEX' => 42,
			"&" => 46,
			'UNIOP' => 47,
			"{" => 48
		},
		DEFAULT => -92,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 112,
			'ary' => 12,
			'termbinop' => 18,
			'block' => 113,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 48
		DEFAULT => -3,
		GOTOS => {
			'remember' => 114
		}
	},
	{#State 49
		DEFAULT => -38
	},
	{#State 50
		DEFAULT => -41,
		GOTOS => {
			'startsub' => 115
		}
	},
	{#State 51
		DEFAULT => -36
	},
	{#State 52
		ACTIONS => {
			'CONTINUE' => 116
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 117
		}
	},
	{#State 53
		ACTIONS => {
			"," => 118
		},
		DEFAULT => -51
	},
	{#State 54
		ACTIONS => {
			'POSTINC' => 100,
			'POWOP' => 94,
			'POSTDEC' => 101
		},
		DEFAULT => -66
	},
	{#State 55
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 119,
			'termbinop' => 18,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 56
		DEFAULT => -123
	},
	{#State 57
		DEFAULT => -122
	},
	{#State 58
		DEFAULT => -119
	},
	{#State 59
		DEFAULT => -124
	},
	{#State 60
		ACTIONS => {
			";" => 120
		}
	},
	{#State 61
		DEFAULT => -46
	},
	{#State 62
		DEFAULT => -120
	},
	{#State 63
		DEFAULT => -108
	},
	{#State 64
		DEFAULT => -110
	},
	{#State 65
		DEFAULT => -109
	},
	{#State 66
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			")" => 122,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 121,
			'termbinop' => 18,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 67
		ACTIONS => {
			'myattrlist' => 123
		},
		DEFAULT => -105
	},
	{#State 68
		ACTIONS => {
			"-" => -122,
			'WORD' => -122,
			"\@" => -122,
			"%" => -122,
			'MY' => -122,
			'LSTOP' => -122,
			"!" => -122,
			"\$" => -122,
			'NOTOP' => -122,
			'PMFUNC' => -122,
			"(" => -122,
			'FUNC1' => -122,
			"+" => -122,
			'NOAMP' => -122,
			'STRING' => -122,
			'FUNC' => -122,
			'DOLSHARP' => -122,
			'LOOPEX' => -122,
			"&" => -122,
			'UNIOP' => -122
		},
		DEFAULT => -99
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
			"[" => 55,
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
		DEFAULT => -77
	},
	{#State 70
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 124,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 71
		DEFAULT => -102
	},
	{#State 72
		ACTIONS => {
			"," => 118
		},
		DEFAULT => -112
	},
	{#State 73
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 125,
			'termbinop' => 18,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
		}
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 126,
			'termbinop' => 18,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 75
		ACTIONS => {
			'POSTINC' => 100,
			'POWOP' => 94,
			'POSTDEC' => 101
		},
		DEFAULT => -68
	},
	{#State 76
		DEFAULT => -118
	},
	{#State 77
		DEFAULT => -3,
		GOTOS => {
			'remember' => 127
		}
	},
	{#State 78
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 128,
			'ary' => 12,
			'termbinop' => 18,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 79
		ACTIONS => {
			"," => 118
		},
		DEFAULT => -91
	},
	{#State 80
		ACTIONS => {
			'WORD' => 129
		},
		GOTOS => {
			'subname' => 130
		}
	},
	{#State 81
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			")" => 132,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 131,
			'termbinop' => 18,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 82
		ACTIONS => {
			'OROP' => 107,
			")" => 133,
			'ANDOP' => 105
		}
	},
	{#State 83
		ACTIONS => {
			"[" => 134
		},
		DEFAULT => -76
	},
	{#State 84
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			")" => 136,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 135,
			'termbinop' => 18,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 85
		DEFAULT => -11
	},
	{#State 86
		ACTIONS => {
			"(" => 137
		}
	},
	{#State 87
		DEFAULT => -3,
		GOTOS => {
			'remember' => 138
		}
	},
	{#State 88
		DEFAULT => -3,
		GOTOS => {
			'remember' => 139
		}
	},
	{#State 89
		ACTIONS => {
			'POSTINC' => 100,
			'POWOP' => 94,
			'POSTDEC' => 101
		},
		DEFAULT => -67
	},
	{#State 90
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
			'FUNC' => 37,
			'STRING' => 39,
			'LOOPEX' => 42,
			"&" => 46,
			'UNIOP' => 47
		},
		DEFAULT => -111,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 72,
			'listexpr' => 140,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 91
		DEFAULT => -121
	},
	{#State 92
		ACTIONS => {
			"-" => 5,
			'WORD' => 68,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			"{" => 48,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		DEFAULT => -113,
		GOTOS => {
			'scalar' => 69,
			'arylen' => 45,
			'indirob' => 141,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 143,
			'termbinop' => 18,
			'listexprcom' => 142,
			'block' => 59,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
		}
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 144,
			'ary' => 12,
			'termbinop' => 18,
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 145,
			'ary' => 12,
			'termbinop' => 18,
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 146,
			'ary' => 12,
			'termbinop' => 18,
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 147,
			'ary' => 12,
			'termbinop' => 18,
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 148,
			'ary' => 12,
			'termbinop' => 18,
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 149,
			'ary' => 12,
			'termbinop' => 18,
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 150,
			'ary' => 12,
			'termbinop' => 18,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 100
		DEFAULT => -69
	},
	{#State 101
		DEFAULT => -70
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 151,
			'ary' => 12,
			'termbinop' => 18,
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 152,
			'ary' => 12,
			'termbinop' => 18,
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 153,
			'ary' => 12,
			'termbinop' => 18,
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 154,
			'termbinop' => 18,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 155,
			'termbinop' => 18,
			'argexpr' => 53,
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 156,
			'termbinop' => 18,
			'argexpr' => 53,
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 157,
			'termbinop' => 18,
			'argexpr' => 53,
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 158,
			'termbinop' => 18,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 110
		DEFAULT => -3,
		GOTOS => {
			'remember' => 159
		}
	},
	{#State 111
		DEFAULT => -117
	},
	{#State 112
		ACTIONS => {
			'ADDOP' => 99,
			'POSTINC' => 100,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 101,
			'MULOP' => 103
		},
		DEFAULT => -94
	},
	{#State 113
		DEFAULT => -93
	},
	{#State 114
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 160
		}
	},
	{#State 115
		DEFAULT => -47,
		GOTOS => {
			'@1-2' => 161
		}
	},
	{#State 116
		ACTIONS => {
			"{" => 48
		},
		GOTOS => {
			'block' => 162
		}
	},
	{#State 117
		DEFAULT => -28
	},
	{#State 118
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
			'FUNC' => 37,
			'STRING' => 39,
			'LOOPEX' => 42,
			"&" => 46,
			'UNIOP' => 47
		},
		DEFAULT => -52,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 163,
			'ary' => 12,
			'termbinop' => 18,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 119
		ACTIONS => {
			'OROP' => 107,
			"]" => 164,
			'ANDOP' => 105
		}
	},
	{#State 120
		DEFAULT => -45
	},
	{#State 121
		ACTIONS => {
			'OROP' => 107,
			")" => 165,
			'ANDOP' => 105
		}
	},
	{#State 122
		DEFAULT => -107
	},
	{#State 123
		DEFAULT => -104
	},
	{#State 124
		ACTIONS => {
			"," => 118
		},
		DEFAULT => -100
	},
	{#State 125
		ACTIONS => {
			'OROP' => 107,
			"]" => 166,
			'ANDOP' => 105
		}
	},
	{#State 126
		ACTIONS => {
			";" => 167,
			'OROP' => 107,
			'ANDOP' => 105
		}
	},
	{#State 127
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'mexpr' => 168,
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 169,
			'termbinop' => 18,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 128
		ACTIONS => {
			'MATCHOP' => 95,
			'POSTDEC' => 101,
			'MULOP' => 103,
			'DOTDOT' => 102,
			'ADDOP' => 99,
			"," => 170,
			'ASSIGNOP' => 93,
			'OROR' => 104,
			'POSTINC' => 100,
			'ANDAND' => 96,
			")" => 171,
			'POWOP' => 94,
			'EQOP' => 97,
			'RELOP' => 98
		}
	},
	{#State 129
		DEFAULT => -42
	},
	{#State 130
		ACTIONS => {
			";" => 173,
			"{" => 48
		},
		GOTOS => {
			'block' => 174,
			'subbody' => 172
		}
	},
	{#State 131
		ACTIONS => {
			'OROP' => 107,
			")" => 175,
			'ANDOP' => 105
		}
	},
	{#State 132
		DEFAULT => -87
	},
	{#State 133
		ACTIONS => {
			"[" => 176
		},
		DEFAULT => -75
	},
	{#State 134
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 177,
			'termbinop' => 18,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 135
		ACTIONS => {
			'OROP' => 107,
			")" => 178,
			'ANDOP' => 105
		}
	},
	{#State 136
		DEFAULT => -95
	},
	{#State 137
		DEFAULT => -3,
		GOTOS => {
			'remember' => 179
		}
	},
	{#State 138
		ACTIONS => {
			"\$" => 16
		},
		GOTOS => {
			'scalar' => 180,
			'my_scalar' => 181
		}
	},
	{#State 139
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'error' => 43,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'mexpr' => 182,
			'scalar' => 6,
			'sideff' => 184,
			'term' => 38,
			'ary' => 12,
			'expr' => 185,
			'nexpr' => 186,
			'termbinop' => 18,
			'hsh' => 19,
			'termunop' => 20,
			'arylen' => 45,
			'mnexpr' => 183,
			'amper' => 26,
			'myattrterm' => 27,
			'subscripted' => 28,
			'argexpr' => 53
		}
	},
	{#State 140
		DEFAULT => -89
	},
	{#State 141
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 187,
			'termbinop' => 18,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 142
		ACTIONS => {
			")" => 188
		}
	},
	{#State 143
		ACTIONS => {
			'OROP' => 107,
			"," => 189,
			'ANDOP' => 105
		},
		DEFAULT => -114
	},
	{#State 144
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
		DEFAULT => -56
	},
	{#State 145
		ACTIONS => {
			'POSTINC' => 100,
			'POWOP' => 94,
			'POSTDEC' => 101
		},
		DEFAULT => -57
	},
	{#State 146
		ACTIONS => {
			'POSTINC' => 100,
			'POWOP' => 94,
			'POSTDEC' => 101
		},
		DEFAULT => -65
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
			'EQOP' => 97
		},
		DEFAULT => -63
	},
	{#State 148
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
		DEFAULT => -61
	},
	{#State 149
		ACTIONS => {
			'ADDOP' => 99,
			'POSTINC' => 100,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 101,
			'MULOP' => 103,
			'RELOP' => undef
		},
		DEFAULT => -60
	},
	{#State 150
		ACTIONS => {
			'POSTINC' => 100,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 101,
			'MULOP' => 103
		},
		DEFAULT => -59
	},
	{#State 151
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
		DEFAULT => -62
	},
	{#State 152
		ACTIONS => {
			'POSTINC' => 100,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 101
		},
		DEFAULT => -58
	},
	{#State 153
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
		DEFAULT => -64
	},
	{#State 154
		DEFAULT => -49
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
		DEFAULT => -50
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
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		DEFAULT => -31,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 192,
			'texpr' => 190,
			'termbinop' => 18,
			'mtexpr' => 191,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 160
		ACTIONS => {
			"}" => 193,
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			'IF' => 17,
			"\$" => 16,
			'error' => 43,
			'LOOPEX' => 42,
			'WHILE' => 44,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'SUB' => 25,
			"{" => 48,
			'UNIOP' => 47,
			"&" => 46,
			'USE' => 50,
			"(" => 29,
			'format' => 51,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 31,
			'sideff' => 32,
			'term' => 38,
			'loop' => 13,
			'ary' => 12,
			'expr' => 40,
			'use' => 41,
			'decl' => 15,
			'termbinop' => 18,
			'hsh' => 19,
			'termunop' => 20,
			'line' => 21,
			'cond' => 24,
			'arylen' => 45,
			'amper' => 26,
			'myattrterm' => 27,
			'subscripted' => 28,
			'package' => 49,
			'block' => 52,
			'argexpr' => 53
		}
	},
	{#State 161
		ACTIONS => {
			'WORD' => 194
		}
	},
	{#State 162
		DEFAULT => -22
	},
	{#State 163
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
	{#State 164
		DEFAULT => -55
	},
	{#State 165
		DEFAULT => -106
	},
	{#State 166
		DEFAULT => -84
	},
	{#State 167
		ACTIONS => {
			"}" => 195
		}
	},
	{#State 168
		ACTIONS => {
			")" => 196
		}
	},
	{#State 169
		ACTIONS => {
			'OROP' => 107,
			'ANDOP' => 105
		},
		DEFAULT => -33
	},
	{#State 170
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 197,
			'ary' => 12,
			'termbinop' => 18,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 171
		DEFAULT => -97
	},
	{#State 172
		DEFAULT => -40
	},
	{#State 173
		DEFAULT => -44
	},
	{#State 174
		DEFAULT => -43
	},
	{#State 175
		DEFAULT => -88
	},
	{#State 176
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 198,
			'termbinop' => 18,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 177
		ACTIONS => {
			'OROP' => 107,
			"]" => 199,
			'ANDOP' => 105
		}
	},
	{#State 178
		DEFAULT => -96
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'mexpr' => 200,
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 169,
			'termbinop' => 18,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 180
		DEFAULT => -116
	},
	{#State 181
		ACTIONS => {
			"(" => 201
		}
	},
	{#State 182
		ACTIONS => {
			")" => 202
		}
	},
	{#State 183
		ACTIONS => {
			";" => 203
		}
	},
	{#State 184
		DEFAULT => -30
	},
	{#State 185
		ACTIONS => {
			'FOR' => 108,
			'OROP' => 107,
			'ANDOP' => 105,
			'IF' => 106,
			")" => -33,
			'WHILE' => 109
		},
		DEFAULT => -13
	},
	{#State 186
		DEFAULT => -34
	},
	{#State 187
		ACTIONS => {
			'OROP' => 107,
			")" => 204,
			'ANDOP' => 105
		}
	},
	{#State 188
		DEFAULT => -103
	},
	{#State 189
		DEFAULT => -115
	},
	{#State 190
		DEFAULT => -35
	},
	{#State 191
		ACTIONS => {
			")" => 205
		}
	},
	{#State 192
		ACTIONS => {
			'OROP' => 107,
			'ANDOP' => 105
		},
		DEFAULT => -32
	},
	{#State 193
		DEFAULT => -2
	},
	{#State 194
		ACTIONS => {
			'WORD' => 206
		}
	},
	{#State 195
		DEFAULT => -85
	},
	{#State 196
		ACTIONS => {
			"{" => 207
		},
		GOTOS => {
			'mblock' => 208
		}
	},
	{#State 197
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
			")" => 209,
			'POWOP' => 94,
			'EQOP' => 97,
			'RELOP' => 98
		}
	},
	{#State 198
		ACTIONS => {
			'OROP' => 107,
			"]" => 210,
			'ANDOP' => 105
		}
	},
	{#State 199
		DEFAULT => -83
	},
	{#State 200
		ACTIONS => {
			")" => 211
		}
	},
	{#State 201
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'mexpr' => 212,
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 169,
			'termbinop' => 18,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 202
		ACTIONS => {
			"{" => 207
		},
		GOTOS => {
			'mblock' => 213
		}
	},
	{#State 203
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		DEFAULT => -31,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 192,
			'texpr' => 190,
			'termbinop' => 18,
			'mtexpr' => 214,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 204
		DEFAULT => -101
	},
	{#State 205
		ACTIONS => {
			"{" => 207
		},
		GOTOS => {
			'mblock' => 215
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		DEFAULT => -111,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 72,
			'listexpr' => 216,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 207
		DEFAULT => -5,
		GOTOS => {
			'mremember' => 217
		}
	},
	{#State 208
		ACTIONS => {
			'ELSE' => 218,
			'ELSIF' => 220
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 219
		}
	},
	{#State 209
		DEFAULT => -98
	},
	{#State 210
		DEFAULT => -82
	},
	{#State 211
		ACTIONS => {
			"{" => 207
		},
		GOTOS => {
			'mblock' => 221
		}
	},
	{#State 212
		ACTIONS => {
			")" => 222
		}
	},
	{#State 213
		ACTIONS => {
			'CONTINUE' => 116
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 223
		}
	},
	{#State 214
		ACTIONS => {
			";" => 224
		}
	},
	{#State 215
		ACTIONS => {
			'CONTINUE' => 116
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 225
		}
	},
	{#State 216
		ACTIONS => {
			";" => 226
		}
	},
	{#State 217
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 227
		}
	},
	{#State 218
		ACTIONS => {
			"{" => 207
		},
		GOTOS => {
			'mblock' => 228
		}
	},
	{#State 219
		DEFAULT => -20
	},
	{#State 220
		ACTIONS => {
			"(" => 229
		}
	},
	{#State 221
		ACTIONS => {
			'CONTINUE' => 116
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 230
		}
	},
	{#State 222
		ACTIONS => {
			"{" => 207
		},
		GOTOS => {
			'mblock' => 231
		}
	},
	{#State 223
		DEFAULT => -26
	},
	{#State 224
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'error' => 43,
			'LOOPEX' => 42,
			")" => -29,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 45,
			'sideff' => 184,
			'mnexpr' => 232,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 40,
			'nexpr' => 186,
			'termbinop' => 18,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 225
		DEFAULT => -23
	},
	{#State 226
		DEFAULT => -48
	},
	{#State 227
		ACTIONS => {
			"}" => 233,
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
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			'IF' => 17,
			"\$" => 16,
			'error' => 43,
			'LOOPEX' => 42,
			'WHILE' => 44,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'SUB' => 25,
			"{" => 48,
			'UNIOP' => 47,
			"&" => 46,
			'USE' => 50,
			"(" => 29,
			'format' => 51,
			'FUNC1' => 30
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 31,
			'sideff' => 32,
			'term' => 38,
			'loop' => 13,
			'ary' => 12,
			'expr' => 40,
			'use' => 41,
			'decl' => 15,
			'termbinop' => 18,
			'hsh' => 19,
			'termunop' => 20,
			'line' => 21,
			'cond' => 24,
			'arylen' => 45,
			'amper' => 26,
			'myattrterm' => 27,
			'subscripted' => 28,
			'package' => 49,
			'block' => 52,
			'argexpr' => 53
		}
	},
	{#State 228
		DEFAULT => -18
	},
	{#State 229
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 35,
			'LSTOP' => 11,
			'STRING' => 39,
			'FUNC' => 37,
			'DOLSHARP' => 36,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'UNIOP' => 47,
			"&" => 46,
			"(" => 29,
			'FUNC1' => 30
		},
		GOTOS => {
			'mexpr' => 234,
			'scalar' => 6,
			'arylen' => 45,
			'myattrterm' => 27,
			'amper' => 26,
			'subscripted' => 28,
			'term' => 38,
			'ary' => 12,
			'expr' => 169,
			'termbinop' => 18,
			'argexpr' => 53,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 230
		DEFAULT => -25
	},
	{#State 231
		ACTIONS => {
			'CONTINUE' => 116
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 235
		}
	},
	{#State 232
		ACTIONS => {
			")" => 236
		}
	},
	{#State 233
		DEFAULT => -4
	},
	{#State 234
		ACTIONS => {
			")" => 237
		}
	},
	{#State 235
		DEFAULT => -24
	},
	{#State 236
		ACTIONS => {
			"{" => 207
		},
		GOTOS => {
			'mblock' => 238
		}
	},
	{#State 237
		ACTIONS => {
			"{" => 207
		},
		GOTOS => {
			'mblock' => 239
		}
	},
	{#State 238
		DEFAULT => -27
	},
	{#State 239
		ACTIONS => {
			'ELSE' => 218,
			'ELSIF' => 220
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 240
		}
	},
	{#State 240
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
#line 183 "plpy.yp"
{
                #print "prog->lineseq\n";
                #print "prog->", $_[1], "\n";
                #print "('", $_[0]->YYCurtok, "': '", $_[0]->YYCurval, "')\n";
                #print "YYExpect: ", join("\n", $_[0]->YYExpect), "\n";
                #print "-----\n";
                printer(\@_, "prog", "lineseq");
                return "$_[1]";
            }
	],
	[#Rule 2
		 'block', 4,
sub
#line 196 "plpy.yp"
{}
	],
	[#Rule 3
		 'remember', 0,
sub
#line 200 "plpy.yp"
{}
	],
	[#Rule 4
		 'mblock', 4,
sub
#line 204 "plpy.yp"
{}
	],
	[#Rule 5
		 'mremember', 0,
sub
#line 208 "plpy.yp"
{}
	],
	[#Rule 6
		 'lineseq', 0,
sub
#line 213 "plpy.yp"
{}
	],
	[#Rule 7
		 'lineseq', 2,
sub
#line 215 "plpy.yp"
{}
	],
	[#Rule 8
		 'lineseq', 2,
sub
#line 217 "plpy.yp"
{
                print "lineseq->lineseq->line\n";
                print "lineseq->", $_[1], "->", $_[2], "\n";
                print "('", $_[0]->YYCurtok, "': '", $_[0]->YYCurval, "')\n";
                #print "YYExpect: ", join("\n", $_[0]->YYExpect), "\n";
                return "$_[1]$_[2]";
            }
	],
	[#Rule 9
		 'line', 1,
sub
#line 228 "plpy.yp"
{}
	],
	[#Rule 10
		 'line', 1, undef
	],
	[#Rule 11
		 'line', 2,
sub
#line 231 "plpy.yp"
{
                print "line->sideff->';'\n";
                print "line->", $_[1], "->", $_[2], "\n";
                print "('", $_[0]->YYCurtok, "': '", $_[0]->YYCurval, "')\n";
                #print "YYExpect: ", join("\n", $_[0]->YYExpect), "\n";
                return "$_[1]\n";
            }
	],
	[#Rule 12
		 'sideff', 1,
sub
#line 242 "plpy.yp"
{}
	],
	[#Rule 13
		 'sideff', 1,
sub
#line 244 "plpy.yp"
{
                print "sideff->expr;\n";
                print "sideff->", $_[1], "\n";
                print "('", $_[0]->YYCurtok, "': '", $_[0]->YYCurval, "')\n";
                #print "YYExpect: ", join("\n", $_[0]->YYExpect), "\n";
                return $_[1];
            }
	],
	[#Rule 14
		 'sideff', 3,
sub
#line 253 "plpy.yp"
{}
	],
	[#Rule 15
		 'sideff', 3,
sub
#line 255 "plpy.yp"
{}
	],
	[#Rule 16
		 'sideff', 3,
sub
#line 257 "plpy.yp"
{}
	],
	[#Rule 17
		 'else', 0,
sub
#line 262 "plpy.yp"
{}
	],
	[#Rule 18
		 'else', 2,
sub
#line 264 "plpy.yp"
{}
	],
	[#Rule 19
		 'else', 6,
sub
#line 266 "plpy.yp"
{}
	],
	[#Rule 20
		 'cond', 7,
sub
#line 271 "plpy.yp"
{}
	],
	[#Rule 21
		 'cont', 0,
sub
#line 276 "plpy.yp"
{}
	],
	[#Rule 22
		 'cont', 2,
sub
#line 278 "plpy.yp"
{}
	],
	[#Rule 23
		 'loop', 7,
sub
#line 283 "plpy.yp"
{}
	],
	[#Rule 24
		 'loop', 9,
sub
#line 285 "plpy.yp"
{}
	],
	[#Rule 25
		 'loop', 8,
sub
#line 287 "plpy.yp"
{}
	],
	[#Rule 26
		 'loop', 7,
sub
#line 289 "plpy.yp"
{}
	],
	[#Rule 27
		 'loop', 10,
sub
#line 292 "plpy.yp"
{}
	],
	[#Rule 28
		 'loop', 2,
sub
#line 295 "plpy.yp"
{}
	],
	[#Rule 29
		 'nexpr', 0,
sub
#line 300 "plpy.yp"
{}
	],
	[#Rule 30
		 'nexpr', 1, undef
	],
	[#Rule 31
		 'texpr', 0,
sub
#line 306 "plpy.yp"
{}
	],
	[#Rule 32
		 'texpr', 1, undef
	],
	[#Rule 33
		 'mexpr', 1,
sub
#line 319 "plpy.yp"
{}
	],
	[#Rule 34
		 'mnexpr', 1,
sub
#line 323 "plpy.yp"
{}
	],
	[#Rule 35
		 'mtexpr', 1,
sub
#line 327 "plpy.yp"
{}
	],
	[#Rule 36
		 'decl', 1,
sub
#line 332 "plpy.yp"
{}
	],
	[#Rule 37
		 'decl', 1,
sub
#line 334 "plpy.yp"
{}
	],
	[#Rule 38
		 'decl', 1,
sub
#line 336 "plpy.yp"
{}
	],
	[#Rule 39
		 'decl', 1,
sub
#line 338 "plpy.yp"
{}
	],
	[#Rule 40
		 'subrout', 4,
sub
#line 343 "plpy.yp"
{}
	],
	[#Rule 41
		 'startsub', 0,
sub
#line 347 "plpy.yp"
{}
	],
	[#Rule 42
		 'subname', 1,
sub
#line 351 "plpy.yp"
{}
	],
	[#Rule 43
		 'subbody', 1,
sub
#line 355 "plpy.yp"
{}
	],
	[#Rule 44
		 'subbody', 1,
sub
#line 356 "plpy.yp"
{}
	],
	[#Rule 45
		 'package', 3,
sub
#line 360 "plpy.yp"
{}
	],
	[#Rule 46
		 'package', 2,
sub
#line 362 "plpy.yp"
{}
	],
	[#Rule 47
		 '@1-2', 0,
sub
#line 366 "plpy.yp"
{}
	],
	[#Rule 48
		 'use', 7,
sub
#line 368 "plpy.yp"
{}
	],
	[#Rule 49
		 'expr', 3,
sub
#line 373 "plpy.yp"
{}
	],
	[#Rule 50
		 'expr', 3,
sub
#line 375 "plpy.yp"
{}
	],
	[#Rule 51
		 'expr', 1, undef
	],
	[#Rule 52
		 'argexpr', 2,
sub
#line 381 "plpy.yp"
{}
	],
	[#Rule 53
		 'argexpr', 3,
sub
#line 383 "plpy.yp"
{}
	],
	[#Rule 54
		 'argexpr', 1,
sub
#line 385 "plpy.yp"
{
                print "argexpr->term\n";
                print "argexpr->", $_[1], "\n";
                print "('", $_[0]->YYCurtok, "': '", $_[0]->YYCurval, "')\n";
                #print "YYExpect: ", join("\n", $_[0]->YYExpect), "\n";
                return $_[1];
            }
	],
	[#Rule 55
		 'subscripted', 4,
sub
#line 398 "plpy.yp"
{}
	],
	[#Rule 56
		 'termbinop', 3,
sub
#line 403 "plpy.yp"
{}
	],
	[#Rule 57
		 'termbinop', 3,
sub
#line 405 "plpy.yp"
{}
	],
	[#Rule 58
		 'termbinop', 3,
sub
#line 407 "plpy.yp"
{}
	],
	[#Rule 59
		 'termbinop', 3,
sub
#line 409 "plpy.yp"
{}
	],
	[#Rule 60
		 'termbinop', 3,
sub
#line 411 "plpy.yp"
{}
	],
	[#Rule 61
		 'termbinop', 3,
sub
#line 413 "plpy.yp"
{}
	],
	[#Rule 62
		 'termbinop', 3,
sub
#line 415 "plpy.yp"
{}
	],
	[#Rule 63
		 'termbinop', 3,
sub
#line 417 "plpy.yp"
{}
	],
	[#Rule 64
		 'termbinop', 3,
sub
#line 419 "plpy.yp"
{}
	],
	[#Rule 65
		 'termbinop', 3,
sub
#line 421 "plpy.yp"
{}
	],
	[#Rule 66
		 'termunop', 2,
sub
#line 426 "plpy.yp"
{}
	],
	[#Rule 67
		 'termunop', 2,
sub
#line 428 "plpy.yp"
{}
	],
	[#Rule 68
		 'termunop', 2,
sub
#line 430 "plpy.yp"
{}
	],
	[#Rule 69
		 'termunop', 2,
sub
#line 432 "plpy.yp"
{}
	],
	[#Rule 70
		 'termunop', 2,
sub
#line 434 "plpy.yp"
{}
	],
	[#Rule 71
		 'term', 1, undef
	],
	[#Rule 72
		 'term', 1, undef
	],
	[#Rule 73
		 'term', 1,
sub
#line 440 "plpy.yp"
{
                print "term->STRING\n";
                print "term->", $_[1], "\n";
                print "('", $_[0]->YYCurtok, "': '", $_[0]->YYCurval, "')\n";
                #print "YYExpect: ", join("\n", $_[0]->YYExpect), "\n";
                return $_[1];
            
            }
	],
	[#Rule 74
		 'term', 1,
sub
#line 450 "plpy.yp"
{}
	],
	[#Rule 75
		 'term', 3,
sub
#line 452 "plpy.yp"
{}
	],
	[#Rule 76
		 'term', 2,
sub
#line 454 "plpy.yp"
{}
	],
	[#Rule 77
		 'term', 1,
sub
#line 456 "plpy.yp"
{}
	],
	[#Rule 78
		 'term', 1,
sub
#line 458 "plpy.yp"
{}
	],
	[#Rule 79
		 'term', 1,
sub
#line 460 "plpy.yp"
{}
	],
	[#Rule 80
		 'term', 1,
sub
#line 462 "plpy.yp"
{}
	],
	[#Rule 81
		 'term', 1,
sub
#line 464 "plpy.yp"
{}
	],
	[#Rule 82
		 'term', 6,
sub
#line 466 "plpy.yp"
{}
	],
	[#Rule 83
		 'term', 5,
sub
#line 468 "plpy.yp"
{}
	],
	[#Rule 84
		 'term', 4,
sub
#line 470 "plpy.yp"
{}
	],
	[#Rule 85
		 'term', 5,
sub
#line 472 "plpy.yp"
{}
	],
	[#Rule 86
		 'term', 1,
sub
#line 474 "plpy.yp"
{}
	],
	[#Rule 87
		 'term', 3,
sub
#line 476 "plpy.yp"
{}
	],
	[#Rule 88
		 'term', 4,
sub
#line 478 "plpy.yp"
{}
	],
	[#Rule 89
		 'term', 3,
sub
#line 480 "plpy.yp"
{}
	],
	[#Rule 90
		 'term', 1,
sub
#line 482 "plpy.yp"
{}
	],
	[#Rule 91
		 'term', 2,
sub
#line 484 "plpy.yp"
{}
	],
	[#Rule 92
		 'term', 1,
sub
#line 486 "plpy.yp"
{}
	],
	[#Rule 93
		 'term', 2,
sub
#line 488 "plpy.yp"
{}
	],
	[#Rule 94
		 'term', 2,
sub
#line 490 "plpy.yp"
{}
	],
	[#Rule 95
		 'term', 3,
sub
#line 492 "plpy.yp"
{}
	],
	[#Rule 96
		 'term', 4,
sub
#line 494 "plpy.yp"
{}
	],
	[#Rule 97
		 'term', 4,
sub
#line 496 "plpy.yp"
{}
	],
	[#Rule 98
		 'term', 6,
sub
#line 498 "plpy.yp"
{}
	],
	[#Rule 99
		 'term', 1, undef
	],
	[#Rule 100
		 'term', 3,
sub
#line 503 "plpy.yp"
{}
	],
	[#Rule 101
		 'term', 5,
sub
#line 505 "plpy.yp"
{}
	],
	[#Rule 102
		 'term', 2,
sub
#line 507 "plpy.yp"
{
                print "term->LSTOP->listexpr\n";
                print "term->", $_[1], "->", $_[2], "\n";
                print "('", $_[0]->YYCurtok, "': '", $_[0]->YYCurval, "')\n";
                #print "YYExpect: ", join("\n", $_[0]->YYExpect), "\n";
                return "print($_[2])";
            
            }
	],
	[#Rule 103
		 'term', 4,
sub
#line 516 "plpy.yp"
{}
	],
	[#Rule 104
		 'myattrterm', 3,
sub
#line 521 "plpy.yp"
{}
	],
	[#Rule 105
		 'myattrterm', 2,
sub
#line 523 "plpy.yp"
{}
	],
	[#Rule 106
		 'myterm', 3,
sub
#line 528 "plpy.yp"
{}
	],
	[#Rule 107
		 'myterm', 2,
sub
#line 530 "plpy.yp"
{}
	],
	[#Rule 108
		 'myterm', 1,
sub
#line 532 "plpy.yp"
{}
	],
	[#Rule 109
		 'myterm', 1,
sub
#line 534 "plpy.yp"
{}
	],
	[#Rule 110
		 'myterm', 1,
sub
#line 536 "plpy.yp"
{}
	],
	[#Rule 111
		 'listexpr', 0,
sub
#line 542 "plpy.yp"
{print "empty listexpr\n";}
	],
	[#Rule 112
		 'listexpr', 1,
sub
#line 544 "plpy.yp"
{
                print "listexpr->argexpr\n";
                print "listexpr", "->", $_[1], "\n";
                print "('", $_[0]->YYCurtok, "': '", $_[0]->YYCurval, "')\n";
                #print "YYExpect: ", join("\n", $_[0]->YYExpect), "\n";
                return $_[1];
            }
	],
	[#Rule 113
		 'listexprcom', 0,
sub
#line 555 "plpy.yp"
{}
	],
	[#Rule 114
		 'listexprcom', 1,
sub
#line 557 "plpy.yp"
{}
	],
	[#Rule 115
		 'listexprcom', 2,
sub
#line 559 "plpy.yp"
{}
	],
	[#Rule 116
		 'my_scalar', 1,
sub
#line 565 "plpy.yp"
{}
	],
	[#Rule 117
		 'amper', 2,
sub
#line 569 "plpy.yp"
{}
	],
	[#Rule 118
		 'scalar', 2,
sub
#line 573 "plpy.yp"
{}
	],
	[#Rule 119
		 'ary', 2,
sub
#line 577 "plpy.yp"
{}
	],
	[#Rule 120
		 'hsh', 2,
sub
#line 581 "plpy.yp"
{}
	],
	[#Rule 121
		 'arylen', 2,
sub
#line 585 "plpy.yp"
{}
	],
	[#Rule 122
		 'indirob', 1,
sub
#line 590 "plpy.yp"
{}
	],
	[#Rule 123
		 'indirob', 1,
sub
#line 592 "plpy.yp"
{}
	],
	[#Rule 124
		 'indirob', 1,
sub
#line 594 "plpy.yp"
{}
	]
],
                                  @_);
    bless($self,$class);
}

#line 597 "plpy.yp"


1;
