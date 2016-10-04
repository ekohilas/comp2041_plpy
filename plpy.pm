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
    if ($_[0]->YYData->{"DEBUG"}){
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
    $_[0]->YYData->{"DEBUG"} = 1;
    my ($type, $value) = getToken($_[0]);
    if ($_[0]->YYData->{"DEBUG"}){
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
    
    if ($parser->YYData->{"DEBUG"}){
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
			'IF' => 18,
			"\$" => 17,
			'LOOPEX' => 42,
			'WHILE' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'SUB' => 26,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
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
			'arylen' => 44,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'argexpr' => 47
		}
	},
	{#State 3
		DEFAULT => 0
	},
	{#State 4
		DEFAULT => -94
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 48,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 6
		ACTIONS => {
			"[" => 49
		},
		DEFAULT => -72
	},
	{#State 7
		ACTIONS => {
			'WORD' => 51,
			"\$" => 17,
			"{" => 53
		},
		GOTOS => {
			'scalar' => 50,
			'indirob' => 52,
			'block' => 54
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
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
	{#State 9
		ACTIONS => {
			'WORD' => 51,
			"\$" => 17,
			"{" => 53
		},
		GOTOS => {
			'scalar' => 50,
			'indirob' => 56,
			'block' => 54
		}
	},
	{#State 10
		ACTIONS => {
			"(" => 60,
			"\@" => 7,
			"\$" => 17,
			"%" => 9
		},
		GOTOS => {
			'scalar' => 57,
			'myterm' => 61,
			'hsh' => 59,
			'ary' => 58
		}
	},
	{#State 11
		DEFAULT => -12
	},
	{#State 12
		ACTIONS => {
			"-" => 5,
			'WORD' => 62,
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
			'LOOPEX' => 42,
			"&" => 45,
			'UNIOP' => 46,
			"{" => 53
		},
		DEFAULT => -106,
		GOTOS => {
			'scalar' => 63,
			'arylen' => 44,
			'indirob' => 64,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'termbinop' => 19,
			'block' => 54,
			'argexpr' => 66,
			'listexpr' => 65,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 13
		ACTIONS => {
			"[" => 67,
			"{" => 68
		},
		DEFAULT => -74
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 69,
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
			'WORD' => 51,
			"\$" => 17,
			"{" => 53
		},
		GOTOS => {
			'scalar' => 50,
			'indirob' => 70,
			'block' => 54
		}
	},
	{#State 18
		ACTIONS => {
			"(" => 71
		}
	},
	{#State 19
		DEFAULT => -66
	},
	{#State 20
		DEFAULT => -73
	},
	{#State 21
		DEFAULT => -67
	},
	{#State 22
		DEFAULT => -8
	},
	{#State 23
		ACTIONS => {
			"(" => 72
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'termbinop' => 19,
			'argexpr' => 73,
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
			'startsub' => 74
		}
	},
	{#State 27
		ACTIONS => {
			"(" => 75
		},
		DEFAULT => -81
	},
	{#State 28
		DEFAULT => -69
	},
	{#State 29
		DEFAULT => -76
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
			"\$" => 17,
			'LOOPEX' => 42,
			")" => 77,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 76,
			'termbinop' => 19,
			'argexpr' => 47,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 31
		ACTIONS => {
			"(" => 78
		}
	},
	{#State 32
		DEFAULT => -33
	},
	{#State 33
		ACTIONS => {
			";" => 79
		}
	},
	{#State 34
		ACTIONS => {
			"(" => 82,
			"\$" => 17,
			'MY' => 81
		},
		GOTOS => {
			'scalar' => 80
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 83,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 36
		ACTIONS => {
			'WORD' => 84
		}
	},
	{#State 37
		ACTIONS => {
			'WORD' => 51,
			"\$" => 17,
			"{" => 53
		},
		GOTOS => {
			'scalar' => 50,
			'indirob' => 85,
			'block' => 54
		}
	},
	{#State 38
		ACTIONS => {
			"(" => 86
		}
	},
	{#State 39
		ACTIONS => {
			'BITANDOP' => 87,
			'ADDOP' => 95,
			'ASSIGNOP' => 88,
			'POSTINC' => 96,
			'BITOROP' => 97,
			'POWOP' => 89,
			'MATCHOP' => 90,
			'POSTDEC' => 98,
			'DOTDOT' => 99,
			'MULOP' => 100,
			'BITXOROP' => 101,
			'SHIFTOP' => 91,
			'OROR' => 102,
			'ANDAND' => 92,
			'EQOP' => 93,
			'RELOP' => 94
		},
		DEFAULT => -44
	},
	{#State 40
		DEFAULT => -68
	},
	{#State 41
		ACTIONS => {
			'FOR' => 106,
			'OROP' => 105,
			'ANDOP' => 103,
			'IF' => 104,
			'WHILE' => 107
		},
		DEFAULT => -13
	},
	{#State 42
		DEFAULT => -85
	},
	{#State 43
		ACTIONS => {
			"(" => 108
		}
	},
	{#State 44
		DEFAULT => -75
	},
	{#State 45
		ACTIONS => {
			'WORD' => 51,
			"\$" => 17,
			"{" => 53
		},
		GOTOS => {
			'scalar' => 50,
			'indirob' => 109,
			'block' => 54
		}
	},
	{#State 46
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
			'LOOPEX' => 42,
			"&" => 45,
			'UNIOP' => 46,
			"{" => 53
		},
		DEFAULT => -87,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 110,
			'ary' => 13,
			'termbinop' => 19,
			'block' => 111,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 47
		ACTIONS => {
			"," => 112
		},
		DEFAULT => -41
	},
	{#State 48
		ACTIONS => {
			'POSTINC' => 96,
			'POWOP' => 89,
			'POSTDEC' => 98
		},
		DEFAULT => -60
	},
	{#State 49
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 113,
			'termbinop' => 19,
			'argexpr' => 47,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 50
		DEFAULT => -118
	},
	{#State 51
		DEFAULT => -117
	},
	{#State 52
		DEFAULT => -114
	},
	{#State 53
		DEFAULT => -3,
		GOTOS => {
			'remember' => 114
		}
	},
	{#State 54
		DEFAULT => -119
	},
	{#State 55
		ACTIONS => {
			'POSTINC' => 96,
			'POWOP' => 89,
			'POSTDEC' => 98
		},
		DEFAULT => -63
	},
	{#State 56
		DEFAULT => -115
	},
	{#State 57
		DEFAULT => -103
	},
	{#State 58
		DEFAULT => -105
	},
	{#State 59
		DEFAULT => -104
	},
	{#State 60
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
			"\$" => 17,
			'LOOPEX' => 42,
			")" => 116,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 115,
			'termbinop' => 19,
			'argexpr' => 47,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 61
		ACTIONS => {
			'myattrlist' => 117
		},
		DEFAULT => -100
	},
	{#State 62
		ACTIONS => {
			"-" => -117,
			'WORD' => -117,
			"\@" => -117,
			"~" => -117,
			"%" => -117,
			'MY' => -117,
			'LSTOP' => -117,
			"!" => -117,
			"\$" => -117,
			'NOTOP' => -117,
			'PMFUNC' => -117,
			"(" => -117,
			'FUNC1' => -117,
			"+" => -117,
			'NOAMP' => -117,
			'STRING' => -117,
			'FUNC' => -117,
			'DOLSHARP' => -117,
			'LOOPEX' => -117,
			"&" => -117,
			'UNIOP' => -117
		},
		DEFAULT => -94
	},
	{#State 63
		ACTIONS => {
			"-" => -118,
			'WORD' => -118,
			"\@" => -118,
			"~" => -118,
			"%" => -118,
			'MY' => -118,
			'LSTOP' => -118,
			"!" => -118,
			"\$" => -118,
			"[" => 49,
			'NOTOP' => -118,
			'PMFUNC' => -118,
			"(" => -118,
			'FUNC1' => -118,
			"+" => -118,
			'NOAMP' => -118,
			'STRING' => -118,
			'FUNC' => -118,
			'DOLSHARP' => -118,
			'LOOPEX' => -118,
			"&" => -118,
			'UNIOP' => -118
		},
		DEFAULT => -72
	},
	{#State 64
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'termbinop' => 19,
			'argexpr' => 118,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 65
		DEFAULT => -97
	},
	{#State 66
		ACTIONS => {
			"," => 112
		},
		DEFAULT => -107
	},
	{#State 67
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 119,
			'termbinop' => 19,
			'argexpr' => 47,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 68
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 120,
			'termbinop' => 19,
			'argexpr' => 47,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 69
		ACTIONS => {
			'POSTINC' => 96,
			'POWOP' => 89,
			'POSTDEC' => 98
		},
		DEFAULT => -62
	},
	{#State 70
		DEFAULT => -113
	},
	{#State 71
		DEFAULT => -3,
		GOTOS => {
			'remember' => 121
		}
	},
	{#State 72
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 122,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 73
		ACTIONS => {
			"," => 112
		},
		DEFAULT => -86
	},
	{#State 74
		ACTIONS => {
			'WORD' => 123
		},
		GOTOS => {
			'subname' => 124
		}
	},
	{#State 75
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
			"\$" => 17,
			'LOOPEX' => 42,
			")" => 126,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 125,
			'termbinop' => 19,
			'argexpr' => 47,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 76
		ACTIONS => {
			'OROP' => 105,
			")" => 127,
			'ANDOP' => 103
		}
	},
	{#State 77
		ACTIONS => {
			"[" => 128
		},
		DEFAULT => -71
	},
	{#State 78
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
			"\$" => 17,
			'LOOPEX' => 42,
			")" => 130,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 129,
			'termbinop' => 19,
			'argexpr' => 47,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 79
		DEFAULT => -11
	},
	{#State 80
		ACTIONS => {
			"(" => 131
		}
	},
	{#State 81
		DEFAULT => -3,
		GOTOS => {
			'remember' => 132
		}
	},
	{#State 82
		DEFAULT => -3,
		GOTOS => {
			'remember' => 133
		}
	},
	{#State 83
		ACTIONS => {
			'POSTINC' => 96,
			'POWOP' => 89,
			'POSTDEC' => 98
		},
		DEFAULT => -61
	},
	{#State 84
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
			'LOOPEX' => 42,
			"&" => 45,
			'UNIOP' => 46
		},
		DEFAULT => -106,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'termbinop' => 19,
			'argexpr' => 66,
			'listexpr' => 134,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 85
		DEFAULT => -116
	},
	{#State 86
		ACTIONS => {
			"-" => 5,
			'WORD' => 62,
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			"{" => 53,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		DEFAULT => -108,
		GOTOS => {
			'scalar' => 63,
			'arylen' => 44,
			'indirob' => 135,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 137,
			'termbinop' => 19,
			'listexprcom' => 136,
			'block' => 54,
			'argexpr' => 47,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 87
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 138,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 88
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 139,
			'ary' => 13,
			'termbinop' => 19,
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
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
		DEFAULT => -64
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
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
	{#State 98
		DEFAULT => -65
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
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
	{#State 100
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 152,
			'termbinop' => 19,
			'argexpr' => 47,
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 153,
			'termbinop' => 19,
			'argexpr' => 47,
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 154,
			'termbinop' => 19,
			'argexpr' => 47,
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 155,
			'termbinop' => 19,
			'argexpr' => 47,
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 156,
			'termbinop' => 19,
			'argexpr' => 47,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 108
		DEFAULT => -3,
		GOTOS => {
			'remember' => 157
		}
	},
	{#State 109
		DEFAULT => -112
	},
	{#State 110
		ACTIONS => {
			'ADDOP' => 95,
			'POSTINC' => 96,
			'POWOP' => 89,
			'MATCHOP' => 90,
			'POSTDEC' => 98,
			'MULOP' => 100,
			'SHIFTOP' => 91
		},
		DEFAULT => -89
	},
	{#State 111
		DEFAULT => -88
	},
	{#State 112
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
			'LOOPEX' => 42,
			"&" => 45,
			'UNIOP' => 46
		},
		DEFAULT => -42,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 158,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 113
		ACTIONS => {
			'OROP' => 105,
			"]" => 159,
			'ANDOP' => 103
		}
	},
	{#State 114
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 160
		}
	},
	{#State 115
		ACTIONS => {
			'OROP' => 105,
			")" => 161,
			'ANDOP' => 103
		}
	},
	{#State 116
		DEFAULT => -102
	},
	{#State 117
		DEFAULT => -99
	},
	{#State 118
		ACTIONS => {
			"," => 112
		},
		DEFAULT => -95
	},
	{#State 119
		ACTIONS => {
			'OROP' => 105,
			"]" => 162,
			'ANDOP' => 103
		}
	},
	{#State 120
		ACTIONS => {
			";" => 163,
			'OROP' => 105,
			'ANDOP' => 103
		}
	},
	{#State 121
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 164,
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 165,
			'termbinop' => 19,
			'argexpr' => 47,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 122
		ACTIONS => {
			'BITANDOP' => 87,
			'ADDOP' => 95,
			"," => 166,
			'ASSIGNOP' => 88,
			'POSTINC' => 96,
			")" => 167,
			'BITOROP' => 97,
			'POWOP' => 89,
			'MATCHOP' => 90,
			'POSTDEC' => 98,
			'DOTDOT' => 99,
			'MULOP' => 100,
			'BITXOROP' => 101,
			'SHIFTOP' => 91,
			'OROR' => 102,
			'ANDAND' => 92,
			'RELOP' => 94,
			'EQOP' => 93
		}
	},
	{#State 123
		DEFAULT => -36
	},
	{#State 124
		ACTIONS => {
			";" => 169,
			"{" => 53
		},
		GOTOS => {
			'block' => 170,
			'subbody' => 168
		}
	},
	{#State 125
		ACTIONS => {
			'OROP' => 105,
			")" => 171,
			'ANDOP' => 103
		}
	},
	{#State 126
		DEFAULT => -82
	},
	{#State 127
		ACTIONS => {
			"[" => 172
		},
		DEFAULT => -70
	},
	{#State 128
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 173,
			'termbinop' => 19,
			'argexpr' => 47,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 129
		ACTIONS => {
			'OROP' => 105,
			")" => 174,
			'ANDOP' => 103
		}
	},
	{#State 130
		DEFAULT => -90
	},
	{#State 131
		DEFAULT => -3,
		GOTOS => {
			'remember' => 175
		}
	},
	{#State 132
		ACTIONS => {
			"\$" => 17
		},
		GOTOS => {
			'scalar' => 176,
			'my_scalar' => 177
		}
	},
	{#State 133
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		DEFAULT => -26,
		GOTOS => {
			'mexpr' => 178,
			'scalar' => 6,
			'sideff' => 180,
			'term' => 39,
			'ary' => 13,
			'expr' => 181,
			'nexpr' => 182,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21,
			'arylen' => 44,
			'mnexpr' => 179,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'argexpr' => 47
		}
	},
	{#State 134
		DEFAULT => -84
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 183,
			'termbinop' => 19,
			'argexpr' => 47,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 136
		ACTIONS => {
			")" => 184
		}
	},
	{#State 137
		ACTIONS => {
			'OROP' => 105,
			"," => 185,
			'ANDOP' => 103
		},
		DEFAULT => -109
	},
	{#State 138
		ACTIONS => {
			'ADDOP' => 95,
			'POSTINC' => 96,
			'POWOP' => 89,
			'MATCHOP' => 90,
			'POSTDEC' => 98,
			'MULOP' => 100,
			'BITXOROP' => 101,
			'SHIFTOP' => 91,
			'EQOP' => 93,
			'RELOP' => 94
		},
		DEFAULT => -53
	},
	{#State 139
		ACTIONS => {
			'BITANDOP' => 87,
			'ADDOP' => 95,
			'ASSIGNOP' => 88,
			'POSTINC' => 96,
			'BITOROP' => 97,
			'POWOP' => 89,
			'MATCHOP' => 90,
			'POSTDEC' => 98,
			'DOTDOT' => 99,
			'MULOP' => 100,
			'BITXOROP' => 101,
			'SHIFTOP' => 91,
			'OROR' => 102,
			'ANDAND' => 92,
			'EQOP' => 93,
			'RELOP' => 94
		},
		DEFAULT => -46
	},
	{#State 140
		ACTIONS => {
			'POSTINC' => 96,
			'POWOP' => 89,
			'POSTDEC' => 98
		},
		DEFAULT => -47
	},
	{#State 141
		ACTIONS => {
			'POSTINC' => 96,
			'POWOP' => 89,
			'POSTDEC' => 98
		},
		DEFAULT => -59
	},
	{#State 142
		ACTIONS => {
			'ADDOP' => 95,
			'POSTINC' => 96,
			'POWOP' => 89,
			'MATCHOP' => 90,
			'POSTDEC' => 98,
			'MULOP' => 100
		},
		DEFAULT => -50
	},
	{#State 143
		ACTIONS => {
			'BITANDOP' => 87,
			'ADDOP' => 95,
			'POSTINC' => 96,
			'BITOROP' => 97,
			'POWOP' => 89,
			'MATCHOP' => 90,
			'POSTDEC' => 98,
			'MULOP' => 100,
			'BITXOROP' => 101,
			'SHIFTOP' => 91,
			'EQOP' => 93,
			'RELOP' => 94
		},
		DEFAULT => -57
	},
	{#State 144
		ACTIONS => {
			'ADDOP' => 95,
			'POSTINC' => 96,
			'POWOP' => 89,
			'MATCHOP' => 90,
			'POSTDEC' => 98,
			'MULOP' => 100,
			'SHIFTOP' => 91,
			'EQOP' => undef,
			'RELOP' => 94
		},
		DEFAULT => -52
	},
	{#State 145
		ACTIONS => {
			'ADDOP' => 95,
			'POSTINC' => 96,
			'POWOP' => 89,
			'MATCHOP' => 90,
			'POSTDEC' => 98,
			'MULOP' => 100,
			'SHIFTOP' => 91,
			'RELOP' => undef
		},
		DEFAULT => -51
	},
	{#State 146
		ACTIONS => {
			'POSTINC' => 96,
			'POWOP' => 89,
			'MATCHOP' => 90,
			'POSTDEC' => 98,
			'MULOP' => 100
		},
		DEFAULT => -49
	},
	{#State 147
		ACTIONS => {
			'BITANDOP' => 87,
			'ADDOP' => 95,
			'POSTINC' => 96,
			'POWOP' => 89,
			'MATCHOP' => 90,
			'POSTDEC' => 98,
			'MULOP' => 100,
			'BITXOROP' => 101,
			'SHIFTOP' => 91,
			'EQOP' => 93,
			'RELOP' => 94
		},
		DEFAULT => -54
	},
	{#State 148
		ACTIONS => {
			'BITANDOP' => 87,
			'ADDOP' => 95,
			'POSTINC' => 96,
			'BITOROP' => 97,
			'POWOP' => 89,
			'MATCHOP' => 90,
			'POSTDEC' => 98,
			'DOTDOT' => undef,
			'MULOP' => 100,
			'BITXOROP' => 101,
			'SHIFTOP' => 91,
			'OROR' => 102,
			'ANDAND' => 92,
			'EQOP' => 93,
			'RELOP' => 94
		},
		DEFAULT => -56
	},
	{#State 149
		ACTIONS => {
			'POSTINC' => 96,
			'POWOP' => 89,
			'MATCHOP' => 90,
			'POSTDEC' => 98
		},
		DEFAULT => -48
	},
	{#State 150
		ACTIONS => {
			'ADDOP' => 95,
			'POSTINC' => 96,
			'POWOP' => 89,
			'MATCHOP' => 90,
			'POSTDEC' => 98,
			'MULOP' => 100,
			'SHIFTOP' => 91,
			'EQOP' => 93,
			'RELOP' => 94
		},
		DEFAULT => -55
	},
	{#State 151
		ACTIONS => {
			'BITANDOP' => 87,
			'ADDOP' => 95,
			'POSTINC' => 96,
			'BITOROP' => 97,
			'POWOP' => 89,
			'MATCHOP' => 90,
			'POSTDEC' => 98,
			'MULOP' => 100,
			'BITXOROP' => 101,
			'SHIFTOP' => 91,
			'ANDAND' => 92,
			'EQOP' => 93,
			'RELOP' => 94
		},
		DEFAULT => -58
	},
	{#State 152
		DEFAULT => -39
	},
	{#State 153
		ACTIONS => {
			'OROP' => 105,
			'ANDOP' => 103
		},
		DEFAULT => -14
	},
	{#State 154
		ACTIONS => {
			'ANDOP' => 103
		},
		DEFAULT => -40
	},
	{#State 155
		ACTIONS => {
			'OROP' => 105,
			'ANDOP' => 103
		},
		DEFAULT => -16
	},
	{#State 156
		ACTIONS => {
			'OROP' => 105,
			'ANDOP' => 103
		},
		DEFAULT => -15
	},
	{#State 157
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		DEFAULT => -28,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 188,
			'texpr' => 186,
			'termbinop' => 19,
			'mtexpr' => 187,
			'argexpr' => 47,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 158
		ACTIONS => {
			'BITANDOP' => 87,
			'ADDOP' => 95,
			'ASSIGNOP' => 88,
			'POSTINC' => 96,
			'BITOROP' => 97,
			'POWOP' => 89,
			'MATCHOP' => 90,
			'POSTDEC' => 98,
			'DOTDOT' => 99,
			'MULOP' => 100,
			'BITXOROP' => 101,
			'SHIFTOP' => 91,
			'OROR' => 102,
			'ANDAND' => 92,
			'EQOP' => 93,
			'RELOP' => 94
		},
		DEFAULT => -43
	},
	{#State 159
		DEFAULT => -45
	},
	{#State 160
		ACTIONS => {
			"}" => 189,
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
			'IF' => 18,
			"\$" => 17,
			'LOOPEX' => 42,
			'WHILE' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'SUB' => 26,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
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
			'arylen' => 44,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'argexpr' => 47
		}
	},
	{#State 161
		DEFAULT => -101
	},
	{#State 162
		DEFAULT => -79
	},
	{#State 163
		ACTIONS => {
			"}" => 190
		}
	},
	{#State 164
		ACTIONS => {
			")" => 191
		}
	},
	{#State 165
		ACTIONS => {
			'OROP' => 105,
			'ANDOP' => 103
		},
		DEFAULT => -30
	},
	{#State 166
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 192,
			'ary' => 13,
			'termbinop' => 19,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 167
		DEFAULT => -92
	},
	{#State 168
		DEFAULT => -34
	},
	{#State 169
		DEFAULT => -38
	},
	{#State 170
		DEFAULT => -37
	},
	{#State 171
		DEFAULT => -83
	},
	{#State 172
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 193,
			'termbinop' => 19,
			'argexpr' => 47,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 173
		ACTIONS => {
			'OROP' => 105,
			"]" => 194,
			'ANDOP' => 103
		}
	},
	{#State 174
		DEFAULT => -91
	},
	{#State 175
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 195,
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 165,
			'termbinop' => 19,
			'argexpr' => 47,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 176
		DEFAULT => -111
	},
	{#State 177
		ACTIONS => {
			"(" => 196
		}
	},
	{#State 178
		ACTIONS => {
			")" => 197
		}
	},
	{#State 179
		ACTIONS => {
			";" => 198
		}
	},
	{#State 180
		DEFAULT => -27
	},
	{#State 181
		ACTIONS => {
			'FOR' => 106,
			'OROP' => 105,
			'ANDOP' => 103,
			'IF' => 104,
			")" => -30,
			'WHILE' => 107
		},
		DEFAULT => -13
	},
	{#State 182
		DEFAULT => -31
	},
	{#State 183
		ACTIONS => {
			'OROP' => 105,
			")" => 199,
			'ANDOP' => 103
		}
	},
	{#State 184
		DEFAULT => -98
	},
	{#State 185
		DEFAULT => -110
	},
	{#State 186
		DEFAULT => -32
	},
	{#State 187
		ACTIONS => {
			")" => 200
		}
	},
	{#State 188
		ACTIONS => {
			'OROP' => 105,
			'ANDOP' => 103
		},
		DEFAULT => -29
	},
	{#State 189
		DEFAULT => -2
	},
	{#State 190
		DEFAULT => -80
	},
	{#State 191
		ACTIONS => {
			"{" => 201
		},
		GOTOS => {
			'mblock' => 202
		}
	},
	{#State 192
		ACTIONS => {
			'BITANDOP' => 87,
			'ADDOP' => 95,
			'ASSIGNOP' => 88,
			'POSTINC' => 96,
			")" => 203,
			'BITOROP' => 97,
			'POWOP' => 89,
			'MATCHOP' => 90,
			'POSTDEC' => 98,
			'DOTDOT' => 99,
			'MULOP' => 100,
			'BITXOROP' => 101,
			'SHIFTOP' => 91,
			'OROR' => 102,
			'ANDAND' => 92,
			'RELOP' => 94,
			'EQOP' => 93
		}
	},
	{#State 193
		ACTIONS => {
			'OROP' => 105,
			"]" => 204,
			'ANDOP' => 103
		}
	},
	{#State 194
		DEFAULT => -78
	},
	{#State 195
		ACTIONS => {
			")" => 205
		}
	},
	{#State 196
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 206,
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 165,
			'termbinop' => 19,
			'argexpr' => 47,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 197
		ACTIONS => {
			"{" => 201
		},
		GOTOS => {
			'mblock' => 207
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		DEFAULT => -28,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 188,
			'texpr' => 186,
			'termbinop' => 19,
			'mtexpr' => 208,
			'argexpr' => 47,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 199
		DEFAULT => -96
	},
	{#State 200
		ACTIONS => {
			"{" => 201
		},
		GOTOS => {
			'mblock' => 209
		}
	},
	{#State 201
		DEFAULT => -5,
		GOTOS => {
			'mremember' => 210
		}
	},
	{#State 202
		ACTIONS => {
			'ELSE' => 211,
			'ELSIF' => 213
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 212
		}
	},
	{#State 203
		DEFAULT => -93
	},
	{#State 204
		DEFAULT => -77
	},
	{#State 205
		ACTIONS => {
			"{" => 201
		},
		GOTOS => {
			'mblock' => 214
		}
	},
	{#State 206
		ACTIONS => {
			")" => 215
		}
	},
	{#State 207
		DEFAULT => -24
	},
	{#State 208
		ACTIONS => {
			";" => 216
		}
	},
	{#State 209
		DEFAULT => -21
	},
	{#State 210
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 217
		}
	},
	{#State 211
		ACTIONS => {
			"{" => 201
		},
		GOTOS => {
			'mblock' => 218
		}
	},
	{#State 212
		DEFAULT => -20
	},
	{#State 213
		ACTIONS => {
			"(" => 219
		}
	},
	{#State 214
		DEFAULT => -23
	},
	{#State 215
		ACTIONS => {
			"{" => 201
		},
		GOTOS => {
			'mblock' => 220
		}
	},
	{#State 216
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		DEFAULT => -26,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 44,
			'sideff' => 180,
			'mnexpr' => 221,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 41,
			'nexpr' => 182,
			'termbinop' => 19,
			'argexpr' => 47,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 217
		ACTIONS => {
			"}" => 222,
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
			'IF' => 18,
			"\$" => 17,
			'LOOPEX' => 42,
			'WHILE' => 43,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'SUB' => 26,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
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
			'arylen' => 44,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'argexpr' => 47
		}
	},
	{#State 218
		DEFAULT => -18
	},
	{#State 219
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
			"\$" => 17,
			'LOOPEX' => 42,
			'PMFUNC' => 23,
			'NOTOP' => 24,
			'UNIOP' => 46,
			"&" => 45,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 223,
			'scalar' => 6,
			'arylen' => 44,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 39,
			'ary' => 13,
			'expr' => 165,
			'termbinop' => 19,
			'argexpr' => 47,
			'hsh' => 20,
			'termunop' => 21
		}
	},
	{#State 220
		DEFAULT => -22
	},
	{#State 221
		ACTIONS => {
			")" => 224
		}
	},
	{#State 222
		DEFAULT => -4
	},
	{#State 223
		ACTIONS => {
			")" => 225
		}
	},
	{#State 224
		ACTIONS => {
			"{" => 201
		},
		GOTOS => {
			'mblock' => 226
		}
	},
	{#State 225
		ACTIONS => {
			"{" => 201
		},
		GOTOS => {
			'mblock' => 227
		}
	},
	{#State 226
		DEFAULT => -25
	},
	{#State 227
		ACTIONS => {
			'ELSE' => 211,
			'ELSIF' => 213
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 228
		}
	},
	{#State 228
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
#line 210 "plpy.yp"
{
                printer(\@_, "prog", "lineseq");
                return "$_[1]";
            }
	],
	[#Rule 2
		 'block', 4,
sub
#line 218 "plpy.yp"
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
#line 228 "plpy.yp"
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
#line 240 "plpy.yp"
{
                printer(\@_, qw( lineseq lineseq decl )); 
                return "$_[1]$_[2]";
            }
	],
	[#Rule 8
		 'lineseq', 2,
sub
#line 245 "plpy.yp"
{
                printer(\@_, "lineseq", "lineseq", "line");
                return "$_[1]$_[2]";
            }
	],
	[#Rule 9
		 'line', 1,
sub
#line 253 "plpy.yp"
{
                printer(\@_, qw( line cond )); 
                return $_[1];
            }
	],
	[#Rule 10
		 'line', 1,
sub
#line 259 "plpy.yp"
{
                printer(\@_, qw( line loop )); 
                return $_[1];
            }
	],
	[#Rule 11
		 'line', 2,
sub
#line 265 "plpy.yp"
{
                printer(\@_, "line", "sideff", "';'");
                return "$_[1]\n";
            }
	],
	[#Rule 12
		 'line', 1,
sub
#line 270 "plpy.yp"
{
                printer(\@_, "line", "COMMENT");
                return "$_[1]\n";
            }
	],
	[#Rule 13
		 'sideff', 1,
sub
#line 279 "plpy.yp"
{
                printer(\@_, "sideff", "expr");
                return $_[1];
            }
	],
	[#Rule 14
		 'sideff', 3,
sub
#line 285 "plpy.yp"
{
                printer(\@_, qw( sideff expr IF expr ));
                return "$_[1] if $_[3]";
            }
	],
	[#Rule 15
		 'sideff', 3,
sub
#line 290 "plpy.yp"
{
                printer(\@_, qw( sideff expr WHILE expr ));
                return "$_[1] while $_[3]";
            }
	],
	[#Rule 16
		 'sideff', 3,
sub
#line 295 "plpy.yp"
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
#line 304 "plpy.yp"
{
                printer (\@_, qw( else ELSE mblock ));
                return "else: $_[2]";
            }
	],
	[#Rule 19
		 'else', 6,
sub
#line 309 "plpy.yp"
{
                printer (\@_, qw( else ELSIF '(' mexpr ')' mblock else)); 
                return "elif $_[3]:$_[5]$_[6]";
            }
	],
	[#Rule 20
		 'cond', 7,
sub
#line 317 "plpy.yp"
{
                printer (\@_, qw( IF '(' remember mexpr ')' mblock else));
                return "if $_[4]:$_[6]$_[7]";
                
            }
	],
	[#Rule 21
		 'loop', 6,
sub
#line 326 "plpy.yp"
{
                 printer (\@_, qw(WHILE '(' remember mtexpr ')' mblock cont)); 
                 return "while $_[4]:$_[6]$_[7]";
            }
	],
	[#Rule 22
		 'loop', 8,
sub
#line 331 "plpy.yp"
{
                printer (\@_, qw(loop FOR MY remember my_scalar '(' mexpr ')' mblock cont)); 
                return "for $_[4] in $_[6]:$_[8]";
            }
	],
	[#Rule 23
		 'loop', 7,
sub
#line 336 "plpy.yp"
{
                printer (\@_, qw(loop FOR scalar '(' mexpr ')' mblock cont)); 
                return "for $_[2] in $_[5]:$_[7]";
            }
	],
	[#Rule 24
		 'loop', 6,
sub
#line 341 "plpy.yp"
{}
	],
	[#Rule 25
		 'loop', 10,
sub
#line 343 "plpy.yp"
{
                printer (\@_, qw(loop FOR '(' remember mnexpr ';' mtexpr ';' mnexpr ')' mblock)); 
                return "$_[4]\nwhile $_[6]:$_[10] hi   $_[8]\n";
            }
	],
	[#Rule 26
		 'nexpr', 0,
sub
#line 351 "plpy.yp"
{}
	],
	[#Rule 27
		 'nexpr', 1, undef
	],
	[#Rule 28
		 'texpr', 0,
sub
#line 357 "plpy.yp"
{}
	],
	[#Rule 29
		 'texpr', 1, undef
	],
	[#Rule 30
		 'mexpr', 1,
sub
#line 363 "plpy.yp"
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
#line 377 "plpy.yp"
{}
	],
	[#Rule 34
		 'subrout', 4,
sub
#line 382 "plpy.yp"
{}
	],
	[#Rule 35
		 'startsub', 0,
sub
#line 386 "plpy.yp"
{}
	],
	[#Rule 36
		 'subname', 1,
sub
#line 390 "plpy.yp"
{}
	],
	[#Rule 37
		 'subbody', 1,
sub
#line 394 "plpy.yp"
{}
	],
	[#Rule 38
		 'subbody', 1,
sub
#line 395 "plpy.yp"
{}
	],
	[#Rule 39
		 'expr', 3,
sub
#line 401 "plpy.yp"
{
                printer (\@_, qw(expr expr ANDOP expr)); 
                return "$_[1] and $_[3]";
            }
	],
	[#Rule 40
		 'expr', 3,
sub
#line 406 "plpy.yp"
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
#line 415 "plpy.yp"
{
                printer (\@_, "argexpr", "','");
                return "$_[1], ";
            }
	],
	[#Rule 43
		 'argexpr', 3,
sub
#line 420 "plpy.yp"
{
                printer (\@_, "argexpr", "','", "term");
                return "$_[1], $_[3]";
            }
	],
	[#Rule 44
		 'argexpr', 1,
sub
#line 425 "plpy.yp"
{
                printer (\@_, "argexpr", "term");
                return $_[1];
            }
	],
	[#Rule 45
		 'subscripted', 4,
sub
#line 435 "plpy.yp"
{}
	],
	[#Rule 46
		 'termbinop', 3,
sub
#line 440 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "ASSIGNOP", "term");
                if ($_[2] eq '.=') {$_[2] = '+='}
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 47
		 'termbinop', 3,
sub
#line 446 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "POWOP", "term");
                return "int($_[1]) $_[2] int($_[3])";
            }
	],
	[#Rule 48
		 'termbinop', 3,
sub
#line 451 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "MULOP", "term");
                return "int($_[1]) $_[2] int($_[3])";
            }
	],
	[#Rule 49
		 'termbinop', 3,
sub
#line 456 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "ADDOP", "term");
                return "int($_[1]) $_[2] int($_[3])";
            }
	],
	[#Rule 50
		 'termbinop', 3,
sub
#line 461 "plpy.yp"
{
                printer (\@_, qw(term SHIFTOP term)); 
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 51
		 'termbinop', 3,
sub
#line 466 "plpy.yp"
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
#line 478 "plpy.yp"
{
                printer (\@_, qw(termbinop term EQOP term)); 
                if ($_[2] eq 'eq') {$_[2] = '=='}
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 53
		 'termbinop', 3,
sub
#line 484 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITANDOP term)); 
                return "$_[1] & $_[2]";
            }
	],
	[#Rule 54
		 'termbinop', 3,
sub
#line 489 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITOROP term)); 
                return "$_[1] | $_[2]";
            }
	],
	[#Rule 55
		 'termbinop', 3,
sub
#line 494 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITXOROP term)); 
                return "$_[1] ^ $_[2]";
            }
	],
	[#Rule 56
		 'termbinop', 3,
sub
#line 499 "plpy.yp"
{}
	],
	[#Rule 57
		 'termbinop', 3,
sub
#line 501 "plpy.yp"
{
                printer (\@_, qw(termbinop term ANDAND term)); 
                return "$_[1] and $_[3]";
            }
	],
	[#Rule 58
		 'termbinop', 3,
sub
#line 506 "plpy.yp"
{
                printer (\@_, qw(termbinop term OROR term)); 
                return "$_[1] or $_[3]";
            }
	],
	[#Rule 59
		 'termbinop', 3,
sub
#line 511 "plpy.yp"
{}
	],
	[#Rule 60
		 'termunop', 2,
sub
#line 516 "plpy.yp"
{}
	],
	[#Rule 61
		 'termunop', 2,
sub
#line 518 "plpy.yp"
{}
	],
	[#Rule 62
		 'termunop', 2,
sub
#line 520 "plpy.yp"
{
                printer (\@_, qw(termunop '!' term)); 
                return "not $_[2]";
            }
	],
	[#Rule 63
		 'termunop', 2,
sub
#line 525 "plpy.yp"
{
                printer (\@_, qw(termunop '~' term)); 
                return "~$_[2]";
            }
	],
	[#Rule 64
		 'termunop', 2,
sub
#line 530 "plpy.yp"
{
                printer (\@_, qw(termunop term POSTINC)); 
                return "$_[1] += 1";
            }
	],
	[#Rule 65
		 'termunop', 2,
sub
#line 535 "plpy.yp"
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
#line 544 "plpy.yp"
{
                printer (\@_, "term", "STRING");
                $_[1] =~ s/^"\$(\w+)"/$1/;
                return $_[1];
            }
	],
	[#Rule 69
		 'term', 1,
sub
#line 551 "plpy.yp"
{}
	],
	[#Rule 70
		 'term', 3,
sub
#line 553 "plpy.yp"
{}
	],
	[#Rule 71
		 'term', 2,
sub
#line 555 "plpy.yp"
{}
	],
	[#Rule 72
		 'term', 1,
sub
#line 557 "plpy.yp"
{
                printer (\@_, "term", "scalar");
                return $_[1];
            }
	],
	[#Rule 73
		 'term', 1,
sub
#line 562 "plpy.yp"
{}
	],
	[#Rule 74
		 'term', 1,
sub
#line 564 "plpy.yp"
{}
	],
	[#Rule 75
		 'term', 1,
sub
#line 566 "plpy.yp"
{}
	],
	[#Rule 76
		 'term', 1,
sub
#line 568 "plpy.yp"
{}
	],
	[#Rule 77
		 'term', 6,
sub
#line 570 "plpy.yp"
{}
	],
	[#Rule 78
		 'term', 5,
sub
#line 572 "plpy.yp"
{}
	],
	[#Rule 79
		 'term', 4,
sub
#line 574 "plpy.yp"
{}
	],
	[#Rule 80
		 'term', 5,
sub
#line 576 "plpy.yp"
{}
	],
	[#Rule 81
		 'term', 1,
sub
#line 578 "plpy.yp"
{}
	],
	[#Rule 82
		 'term', 3,
sub
#line 580 "plpy.yp"
{}
	],
	[#Rule 83
		 'term', 4,
sub
#line 582 "plpy.yp"
{}
	],
	[#Rule 84
		 'term', 3,
sub
#line 584 "plpy.yp"
{
                printer (\@_, qw(term NOAMP WORD listexpr)); 
            }
	],
	[#Rule 85
		 'term', 1, undef
	],
	[#Rule 86
		 'term', 2,
sub
#line 589 "plpy.yp"
{
                printer (\@_, qw(term NOTOP argexpr)); 
                return "not $_[2]";
            }
	],
	[#Rule 87
		 'term', 1,
sub
#line 594 "plpy.yp"
{}
	],
	[#Rule 88
		 'term', 2,
sub
#line 596 "plpy.yp"
{}
	],
	[#Rule 89
		 'term', 2,
sub
#line 598 "plpy.yp"
{}
	],
	[#Rule 90
		 'term', 3,
sub
#line 600 "plpy.yp"
{}
	],
	[#Rule 91
		 'term', 4,
sub
#line 602 "plpy.yp"
{}
	],
	[#Rule 92
		 'term', 4,
sub
#line 604 "plpy.yp"
{}
	],
	[#Rule 93
		 'term', 6,
sub
#line 606 "plpy.yp"
{}
	],
	[#Rule 94
		 'term', 1, undef
	],
	[#Rule 95
		 'term', 3,
sub
#line 611 "plpy.yp"
{
                printer (\@_, "term", "LSTOP", "indirob", "argexpr");
            }
	],
	[#Rule 96
		 'term', 5,
sub
#line 615 "plpy.yp"
{}
	],
	[#Rule 97
		 'term', 2,
sub
#line 617 "plpy.yp"
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
	[#Rule 98
		 'term', 4,
sub
#line 641 "plpy.yp"
{}
	],
	[#Rule 99
		 'myattrterm', 3,
sub
#line 646 "plpy.yp"
{}
	],
	[#Rule 100
		 'myattrterm', 2,
sub
#line 648 "plpy.yp"
{}
	],
	[#Rule 101
		 'myterm', 3,
sub
#line 653 "plpy.yp"
{}
	],
	[#Rule 102
		 'myterm', 2,
sub
#line 655 "plpy.yp"
{}
	],
	[#Rule 103
		 'myterm', 1,
sub
#line 657 "plpy.yp"
{}
	],
	[#Rule 104
		 'myterm', 1,
sub
#line 659 "plpy.yp"
{}
	],
	[#Rule 105
		 'myterm', 1,
sub
#line 661 "plpy.yp"
{}
	],
	[#Rule 106
		 'listexpr', 0,
sub
#line 667 "plpy.yp"
{print "empty listexpr\n";}
	],
	[#Rule 107
		 'listexpr', 1,
sub
#line 669 "plpy.yp"
{
                printer (\@_, "listexpr", "argexpr");
                return $_[1];
            }
	],
	[#Rule 108
		 'listexprcom', 0,
sub
#line 677 "plpy.yp"
{}
	],
	[#Rule 109
		 'listexprcom', 1,
sub
#line 679 "plpy.yp"
{}
	],
	[#Rule 110
		 'listexprcom', 2,
sub
#line 681 "plpy.yp"
{}
	],
	[#Rule 111
		 'my_scalar', 1,
sub
#line 687 "plpy.yp"
{}
	],
	[#Rule 112
		 'amper', 2,
sub
#line 691 "plpy.yp"
{}
	],
	[#Rule 113
		 'scalar', 2,
sub
#line 695 "plpy.yp"
{
                printer (\@_, "scalar", "'\$'", "indirob"); 
                return "$_[2]";
            }
	],
	[#Rule 114
		 'ary', 2,
sub
#line 702 "plpy.yp"
{}
	],
	[#Rule 115
		 'hsh', 2,
sub
#line 706 "plpy.yp"
{}
	],
	[#Rule 116
		 'arylen', 2,
sub
#line 710 "plpy.yp"
{}
	],
	[#Rule 117
		 'indirob', 1,
sub
#line 715 "plpy.yp"
{
                printer (\@_, "indirob", "WORD");
                return $_[1];
            }
	],
	[#Rule 118
		 'indirob', 1,
sub
#line 720 "plpy.yp"
{}
	],
	[#Rule 119
		 'indirob', 1,
sub
#line 722 "plpy.yp"
{}
	]
],
                                  @_);
    bless($self,$class);
}

#line 725 "plpy.yp"


1;
