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
			'IF' => 20,
			"\$" => 19,
			'RESUB' => 22,
			'NOTOP' => 27,
			'PMFUNC' => 26,
			'SUB' => 30,
			'ARGV' => 29,
			"(" => 34,
			'FUNC1' => 35,
			'FOR' => 39,
			"+" => 40,
			'NOAMP' => 41,
			'DOLSHARP' => 42,
			'FUNC' => 43,
			'STRING' => 45,
			'LOOPEX' => 47,
			'WHILE' => 48,
			"&" => 50,
			'UNIOP' => 51
		},
		DEFAULT => -1,
		GOTOS => {
			'scalar' => 6,
			'subrout' => 36,
			'sideff' => 38,
			'function' => 37,
			'term' => 44,
			'loop' => 15,
			'ary' => 14,
			'expr' => 46,
			'decl' => 18,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24,
			'line' => 25,
			'cond' => 28,
			'arylen' => 49,
			'amper' => 31,
			'myattrterm' => 32,
			'subscripted' => 33,
			'argexpr' => 52
		}
	},
	{#State 3
		DEFAULT => 0
	},
	{#State 4
		DEFAULT => -83
	},
	{#State 5
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 53,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 6
		ACTIONS => {
			"[" => 54,
			"{" => 55
		},
		DEFAULT => -71
	},
	{#State 7
		ACTIONS => {
			'WORD' => 57,
			'ARGV' => 59,
			"\$" => 19,
			"{" => 60
		},
		GOTOS => {
			'scalar' => 56,
			'indirob' => 58,
			'block' => 61
		}
	},
	{#State 8
		DEFAULT => -64
	},
	{#State 9
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 62,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 10
		ACTIONS => {
			'WORD' => 57,
			'ARGV' => 59,
			"\$" => 19,
			"{" => 60
		},
		GOTOS => {
			'scalar' => 56,
			'indirob' => 63,
			'block' => 61
		}
	},
	{#State 11
		ACTIONS => {
			"(" => 67,
			"\@" => 7,
			"\$" => 19,
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
		DEFAULT => -8
	},
	{#State 13
		ACTIONS => {
			"-" => 5,
			'WORD' => 69,
			'REMATCH' => 8,
			"\@" => 7,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'LSTOP' => 13,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 72,
			"(" => 34,
			'FUNC1' => 35,
			"+" => 40,
			'NOAMP' => 41,
			'DOLSHARP' => 42,
			'FUNC' => 43,
			'STRING' => 45,
			'LOOPEX' => 47,
			"&" => 50,
			'UNIOP' => 51,
			"{" => 60
		},
		DEFAULT => -102,
		GOTOS => {
			'scalar' => 70,
			'arylen' => 49,
			'indirob' => 71,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'termbinop' => 21,
			'block' => 61,
			'argexpr' => 74,
			'listexpr' => 73,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 14
		ACTIONS => {
			"[" => 75
		},
		DEFAULT => -73
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
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 76,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 17
		DEFAULT => -63
	},
	{#State 18
		DEFAULT => -3
	},
	{#State 19
		ACTIONS => {
			'WORD' => 57,
			'ARGV' => 59,
			"\$" => 19,
			"{" => 60
		},
		GOTOS => {
			'scalar' => 56,
			'indirob' => 77,
			'block' => 61
		}
	},
	{#State 20
		ACTIONS => {
			"(" => 78
		}
	},
	{#State 21
		DEFAULT => -61
	},
	{#State 22
		DEFAULT => -65
	},
	{#State 23
		DEFAULT => -72
	},
	{#State 24
		DEFAULT => -62
	},
	{#State 25
		DEFAULT => -4
	},
	{#State 26
		ACTIONS => {
			"(" => 79
		}
	},
	{#State 27
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'termbinop' => 21,
			'argexpr' => 80,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 28
		DEFAULT => -5
	},
	{#State 29
		DEFAULT => -66
	},
	{#State 30
		ACTIONS => {
			'WORD' => 81
		},
		GOTOS => {
			'subname' => 82
		}
	},
	{#State 31
		ACTIONS => {
			"(" => 83
		},
		DEFAULT => -77
	},
	{#State 32
		DEFAULT => -68
	},
	{#State 33
		ACTIONS => {
			"[" => 84,
			"{" => 85
		},
		DEFAULT => -75
	},
	{#State 34
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			")" => 87,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 86,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 35
		ACTIONS => {
			"(" => 88
		}
	},
	{#State 36
		DEFAULT => -26
	},
	{#State 37
		DEFAULT => -84
	},
	{#State 38
		ACTIONS => {
			";" => 89
		}
	},
	{#State 39
		ACTIONS => {
			"(" => 92,
			"\$" => 19,
			'MY' => 91
		},
		GOTOS => {
			'scalar' => 90
		}
	},
	{#State 40
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 93,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 41
		ACTIONS => {
			'WORD' => 94
		}
	},
	{#State 42
		ACTIONS => {
			'WORD' => 57,
			'ARGV' => 59,
			"\$" => 19,
			"{" => 60
		},
		GOTOS => {
			'scalar' => 56,
			'indirob' => 95,
			'block' => 61
		}
	},
	{#State 43
		ACTIONS => {
			"(" => 96
		}
	},
	{#State 44
		ACTIONS => {
			'BITANDOP' => 97,
			'ADDOP' => 105,
			'ASSIGNOP' => 98,
			'POSTINC' => 106,
			'BITOROP' => 107,
			'POWOP' => 99,
			'MATCHOP' => 100,
			'POSTDEC' => 108,
			'DOTDOT' => 109,
			'MULOP' => 110,
			'BITXOROP' => 111,
			'SHIFTOP' => 101,
			'OROR' => 112,
			'ANDAND' => 102,
			'EQOP' => 103,
			'RELOP' => 104
		},
		DEFAULT => -36
	},
	{#State 45
		DEFAULT => -67
	},
	{#State 46
		ACTIONS => {
			'FOR' => 115,
			'OROP' => 114,
			'ANDOP' => 113,
			'WHILE' => 116
		},
		DEFAULT => -10
	},
	{#State 47
		DEFAULT => -81
	},
	{#State 48
		ACTIONS => {
			"(" => 117
		}
	},
	{#State 49
		DEFAULT => -74
	},
	{#State 50
		ACTIONS => {
			'WORD' => 57,
			'ARGV' => 59,
			"\$" => 19,
			"{" => 60
		},
		GOTOS => {
			'scalar' => 56,
			'indirob' => 118,
			'block' => 61
		}
	},
	{#State 51
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
			"\$" => 19,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			"(" => 34,
			'FUNC1' => 35,
			"+" => 40,
			'NOAMP' => 41,
			'DOLSHARP' => 42,
			'FUNC' => 43,
			'STRING' => 45,
			'LOOPEX' => 47,
			"&" => 50,
			'UNIOP' => 51,
			"{" => 60
		},
		DEFAULT => -85,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 119,
			'ary' => 14,
			'termbinop' => 21,
			'block' => 120,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 52
		ACTIONS => {
			"," => 121
		},
		DEFAULT => -33
	},
	{#State 53
		ACTIONS => {
			'POSTINC' => 106,
			'POWOP' => 99,
			'POSTDEC' => 108
		},
		DEFAULT => -55
	},
	{#State 54
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 122,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 55
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 123,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 56
		DEFAULT => -114
	},
	{#State 57
		DEFAULT => -112
	},
	{#State 58
		DEFAULT => -109
	},
	{#State 59
		DEFAULT => -113
	},
	{#State 60
		DEFAULT => -2,
		GOTOS => {
			'lineseq' => 124
		}
	},
	{#State 61
		DEFAULT => -115
	},
	{#State 62
		ACTIONS => {
			'POSTINC' => 106,
			'POWOP' => 99,
			'POSTDEC' => 108
		},
		DEFAULT => -58
	},
	{#State 63
		DEFAULT => -110
	},
	{#State 64
		DEFAULT => -99
	},
	{#State 65
		DEFAULT => -101
	},
	{#State 66
		DEFAULT => -100
	},
	{#State 67
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			")" => 126,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 125,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 68
		DEFAULT => -96
	},
	{#State 69
		ACTIONS => {
			'BITANDOP' => -83,
			'ANDOP' => -83,
			'ASSIGNOP' => -83,
			"]" => -83,
			'POWOP' => -83,
			'MATCHOP' => -83,
			'OROP' => -83,
			'SHIFTOP' => -83,
			'ANDAND' => -83,
			'RELOP' => -83,
			'EQOP' => -83,
			";" => -83,
			'FOR' => -83,
			'ADDOP' => -83,
			"," => -83,
			'POSTINC' => -83,
			'BITOROP' => -83,
			")" => -83,
			'WHILE' => -83,
			'POSTDEC' => -83,
			'DOTDOT' => -83,
			'MULOP' => -83,
			'BITXOROP' => -83,
			'OROR' => -83
		},
		DEFAULT => -112
	},
	{#State 70
		ACTIONS => {
			'BITANDOP' => -71,
			'ANDOP' => -71,
			'ASSIGNOP' => -71,
			"[" => 54,
			"]" => -71,
			'POWOP' => -71,
			'MATCHOP' => -71,
			'OROP' => -71,
			'SHIFTOP' => -71,
			'ANDAND' => -71,
			'RELOP' => -71,
			'EQOP' => -71,
			";" => -71,
			'FOR' => -71,
			'ADDOP' => -71,
			"," => -71,
			'POSTINC' => -71,
			'BITOROP' => -71,
			")" => -71,
			'WHILE' => -71,
			'POSTDEC' => -71,
			"{" => 55,
			'DOTDOT' => -71,
			'MULOP' => -71,
			'BITXOROP' => -71,
			'OROR' => -71
		},
		DEFAULT => -114
	},
	{#State 71
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'termbinop' => 21,
			'argexpr' => 127,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 72
		ACTIONS => {
			'BITANDOP' => -66,
			'ANDOP' => -66,
			'ASSIGNOP' => -66,
			"]" => -66,
			'POWOP' => -66,
			'MATCHOP' => -66,
			'OROP' => -66,
			'SHIFTOP' => -66,
			'ANDAND' => -66,
			'RELOP' => -66,
			'EQOP' => -66,
			";" => -66,
			'FOR' => -66,
			'ADDOP' => -66,
			"," => -66,
			'POSTINC' => -66,
			'BITOROP' => -66,
			")" => -66,
			'WHILE' => -66,
			'POSTDEC' => -66,
			'DOTDOT' => -66,
			'MULOP' => -66,
			'BITXOROP' => -66,
			'OROR' => -66
		},
		DEFAULT => -113
	},
	{#State 73
		DEFAULT => -94
	},
	{#State 74
		ACTIONS => {
			"," => 121
		},
		DEFAULT => -103
	},
	{#State 75
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 128,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 76
		ACTIONS => {
			'POSTINC' => 106,
			'POWOP' => 99,
			'POSTDEC' => 108
		},
		DEFAULT => -57
	},
	{#State 77
		DEFAULT => -108
	},
	{#State 78
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 129,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 79
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 130,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 80
		ACTIONS => {
			"," => 121
		},
		DEFAULT => -82
	},
	{#State 81
		DEFAULT => -28
	},
	{#State 82
		ACTIONS => {
			";" => 132,
			"{" => 60
		},
		GOTOS => {
			'block' => 133,
			'subbody' => 131
		}
	},
	{#State 83
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			")" => 135,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 134,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 84
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 136,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 85
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 137,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 86
		ACTIONS => {
			'OROP' => 114,
			")" => 138,
			'ANDOP' => 113
		}
	},
	{#State 87
		DEFAULT => -70
	},
	{#State 88
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			")" => 140,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 139,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 89
		DEFAULT => -7
	},
	{#State 90
		ACTIONS => {
			"(" => 141
		}
	},
	{#State 91
		ACTIONS => {
			"\$" => 19
		},
		GOTOS => {
			'scalar' => 142
		}
	},
	{#State 92
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		DEFAULT => -22,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'sideff' => 143,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 144,
			'nexpr' => 145,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 93
		ACTIONS => {
			'POSTINC' => 106,
			'POWOP' => 99,
			'POSTDEC' => 108
		},
		DEFAULT => -56
	},
	{#State 94
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
			"\$" => 19,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			"(" => 34,
			'FUNC1' => 35,
			"+" => 40,
			'NOAMP' => 41,
			'DOLSHARP' => 42,
			'FUNC' => 43,
			'STRING' => 45,
			'LOOPEX' => 47,
			"&" => 50,
			'UNIOP' => 51
		},
		DEFAULT => -102,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'termbinop' => 21,
			'argexpr' => 74,
			'listexpr' => 146,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 95
		DEFAULT => -111
	},
	{#State 96
		ACTIONS => {
			"-" => 5,
			'WORD' => 69,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 72,
			"{" => 60,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		DEFAULT => -104,
		GOTOS => {
			'scalar' => 70,
			'indirob' => 147,
			'function' => 37,
			'term' => 44,
			'ary' => 14,
			'expr' => 149,
			'termbinop' => 21,
			'listexprcom' => 148,
			'hsh' => 23,
			'termunop' => 24,
			'arylen' => 49,
			'amper' => 31,
			'myattrterm' => 32,
			'subscripted' => 33,
			'block' => 61,
			'argexpr' => 52
		}
	},
	{#State 97
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 150,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 98
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 151,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 99
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 152,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 100
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 153,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 101
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 154,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 102
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 155,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 103
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 156,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 104
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 157,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 105
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 158,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 106
		DEFAULT => -59
	},
	{#State 107
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 159,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 108
		DEFAULT => -60
	},
	{#State 109
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 160,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 110
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 161,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 111
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 162,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 112
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 163,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 113
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 164,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 114
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 165,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 115
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 166,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 116
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 167,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 117
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		DEFAULT => -24,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 169,
			'texpr' => 168,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 118
		DEFAULT => -107
	},
	{#State 119
		ACTIONS => {
			'ADDOP' => 105,
			'POSTINC' => 106,
			'POWOP' => 99,
			'MATCHOP' => 100,
			'POSTDEC' => 108,
			'MULOP' => 110,
			'SHIFTOP' => 101
		},
		DEFAULT => -87
	},
	{#State 120
		DEFAULT => -86
	},
	{#State 121
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
			"\$" => 19,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			"(" => 34,
			'FUNC1' => 35,
			"+" => 40,
			'NOAMP' => 41,
			'DOLSHARP' => 42,
			'FUNC' => 43,
			'STRING' => 45,
			'LOOPEX' => 47,
			"&" => 50,
			'UNIOP' => 51
		},
		DEFAULT => -34,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 170,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 122
		ACTIONS => {
			'OROP' => 114,
			"]" => 171,
			'ANDOP' => 113
		}
	},
	{#State 123
		ACTIONS => {
			";" => 172,
			'OROP' => 114,
			'ANDOP' => 113
		}
	},
	{#State 124
		ACTIONS => {
			"}" => 173,
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			'FOR' => 39,
			"+" => 40,
			"~" => 9,
			'COMMENT' => 12,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			'IF' => 20,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'WHILE' => 48,
			'NOTOP' => 27,
			'PMFUNC' => 26,
			'SUB' => 30,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 36,
			'sideff' => 38,
			'function' => 37,
			'term' => 44,
			'loop' => 15,
			'ary' => 14,
			'expr' => 46,
			'decl' => 18,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24,
			'line' => 25,
			'cond' => 28,
			'arylen' => 49,
			'amper' => 31,
			'myattrterm' => 32,
			'subscripted' => 33,
			'argexpr' => 52
		}
	},
	{#State 125
		ACTIONS => {
			'OROP' => 114,
			")" => 174,
			'ANDOP' => 113
		}
	},
	{#State 126
		DEFAULT => -98
	},
	{#State 127
		ACTIONS => {
			"," => 121
		},
		DEFAULT => -92
	},
	{#State 128
		ACTIONS => {
			'OROP' => 114,
			"]" => 175,
			'ANDOP' => 113
		}
	},
	{#State 129
		ACTIONS => {
			'OROP' => 114,
			")" => 176,
			'ANDOP' => 113
		}
	},
	{#State 130
		ACTIONS => {
			'BITANDOP' => 97,
			'ADDOP' => 105,
			"," => 177,
			'ASSIGNOP' => 98,
			'POSTINC' => 106,
			")" => 178,
			'BITOROP' => 107,
			'POWOP' => 99,
			'MATCHOP' => 100,
			'POSTDEC' => 108,
			'DOTDOT' => 109,
			'MULOP' => 110,
			'BITXOROP' => 111,
			'SHIFTOP' => 101,
			'OROR' => 112,
			'ANDAND' => 102,
			'RELOP' => 104,
			'EQOP' => 103
		}
	},
	{#State 131
		DEFAULT => -27
	},
	{#State 132
		DEFAULT => -30
	},
	{#State 133
		DEFAULT => -29
	},
	{#State 134
		ACTIONS => {
			'OROP' => 114,
			")" => 179,
			'ANDOP' => 113
		}
	},
	{#State 135
		DEFAULT => -78
	},
	{#State 136
		ACTIONS => {
			'OROP' => 114,
			"]" => 180,
			'ANDOP' => 113
		}
	},
	{#State 137
		ACTIONS => {
			";" => 181,
			'OROP' => 114,
			'ANDOP' => 113
		}
	},
	{#State 138
		DEFAULT => -69
	},
	{#State 139
		ACTIONS => {
			'OROP' => 114,
			")" => 182,
			'ANDOP' => 113
		}
	},
	{#State 140
		DEFAULT => -88
	},
	{#State 141
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 183,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 142
		ACTIONS => {
			"(" => 184
		}
	},
	{#State 143
		DEFAULT => -23
	},
	{#State 144
		ACTIONS => {
			'FOR' => 115,
			'OROP' => 114,
			")" => 185,
			'ANDOP' => 113,
			'WHILE' => 116
		},
		DEFAULT => -10
	},
	{#State 145
		ACTIONS => {
			";" => 186
		}
	},
	{#State 146
		DEFAULT => -80
	},
	{#State 147
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 187,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 148
		ACTIONS => {
			")" => 188
		}
	},
	{#State 149
		ACTIONS => {
			'OROP' => 114,
			"," => 189,
			'ANDOP' => 113
		},
		DEFAULT => -105
	},
	{#State 150
		ACTIONS => {
			'ADDOP' => 105,
			'POSTINC' => 106,
			'POWOP' => 99,
			'MATCHOP' => 100,
			'POSTDEC' => 108,
			'MULOP' => 110,
			'SHIFTOP' => 101,
			'EQOP' => 103,
			'RELOP' => 104
		},
		DEFAULT => -48
	},
	{#State 151
		ACTIONS => {
			'BITANDOP' => 97,
			'ADDOP' => 105,
			'ASSIGNOP' => 98,
			'POSTINC' => 106,
			'BITOROP' => 107,
			'POWOP' => 99,
			'MATCHOP' => 100,
			'POSTDEC' => 108,
			'DOTDOT' => 109,
			'MULOP' => 110,
			'BITXOROP' => 111,
			'SHIFTOP' => 101,
			'OROR' => 112,
			'ANDAND' => 102,
			'EQOP' => 103,
			'RELOP' => 104
		},
		DEFAULT => -41
	},
	{#State 152
		ACTIONS => {
			'POSTINC' => 106,
			'POWOP' => 99,
			'POSTDEC' => 108
		},
		DEFAULT => -42
	},
	{#State 153
		ACTIONS => {
			'POSTINC' => 106,
			'POWOP' => 99,
			'POSTDEC' => 108
		},
		DEFAULT => -54
	},
	{#State 154
		ACTIONS => {
			'ADDOP' => 105,
			'POSTINC' => 106,
			'POWOP' => 99,
			'MATCHOP' => 100,
			'POSTDEC' => 108,
			'MULOP' => 110
		},
		DEFAULT => -45
	},
	{#State 155
		ACTIONS => {
			'BITANDOP' => 97,
			'ADDOP' => 105,
			'POSTINC' => 106,
			'BITOROP' => 107,
			'POWOP' => 99,
			'MATCHOP' => 100,
			'POSTDEC' => 108,
			'MULOP' => 110,
			'BITXOROP' => 111,
			'SHIFTOP' => 101,
			'EQOP' => 103,
			'RELOP' => 104
		},
		DEFAULT => -52
	},
	{#State 156
		ACTIONS => {
			'ADDOP' => 105,
			'POSTINC' => 106,
			'POWOP' => 99,
			'MATCHOP' => 100,
			'POSTDEC' => 108,
			'MULOP' => 110,
			'SHIFTOP' => 101,
			'EQOP' => undef,
			'RELOP' => 104
		},
		DEFAULT => -47
	},
	{#State 157
		ACTIONS => {
			'ADDOP' => 105,
			'POSTINC' => 106,
			'POWOP' => 99,
			'MATCHOP' => 100,
			'POSTDEC' => 108,
			'MULOP' => 110,
			'SHIFTOP' => 101,
			'RELOP' => undef
		},
		DEFAULT => -46
	},
	{#State 158
		ACTIONS => {
			'POSTINC' => 106,
			'POWOP' => 99,
			'MATCHOP' => 100,
			'POSTDEC' => 108,
			'MULOP' => 110
		},
		DEFAULT => -44
	},
	{#State 159
		ACTIONS => {
			'BITANDOP' => 97,
			'ADDOP' => 105,
			'POSTINC' => 106,
			'POWOP' => 99,
			'MATCHOP' => 100,
			'POSTDEC' => 108,
			'MULOP' => 110,
			'SHIFTOP' => 101,
			'EQOP' => 103,
			'RELOP' => 104
		},
		DEFAULT => -49
	},
	{#State 160
		ACTIONS => {
			'BITANDOP' => 97,
			'ADDOP' => 105,
			'POSTINC' => 106,
			'BITOROP' => 107,
			'POWOP' => 99,
			'MATCHOP' => 100,
			'POSTDEC' => 108,
			'DOTDOT' => undef,
			'MULOP' => 110,
			'BITXOROP' => 111,
			'SHIFTOP' => 101,
			'OROR' => 112,
			'ANDAND' => 102,
			'EQOP' => 103,
			'RELOP' => 104
		},
		DEFAULT => -51
	},
	{#State 161
		ACTIONS => {
			'POSTINC' => 106,
			'POWOP' => 99,
			'MATCHOP' => 100,
			'POSTDEC' => 108
		},
		DEFAULT => -43
	},
	{#State 162
		ACTIONS => {
			'BITANDOP' => 97,
			'ADDOP' => 105,
			'POSTINC' => 106,
			'POWOP' => 99,
			'MATCHOP' => 100,
			'POSTDEC' => 108,
			'MULOP' => 110,
			'SHIFTOP' => 101,
			'EQOP' => 103,
			'RELOP' => 104
		},
		DEFAULT => -50
	},
	{#State 163
		ACTIONS => {
			'BITANDOP' => 97,
			'ADDOP' => 105,
			'POSTINC' => 106,
			'BITOROP' => 107,
			'POWOP' => 99,
			'MATCHOP' => 100,
			'POSTDEC' => 108,
			'MULOP' => 110,
			'BITXOROP' => 111,
			'SHIFTOP' => 101,
			'ANDAND' => 102,
			'EQOP' => 103,
			'RELOP' => 104
		},
		DEFAULT => -53
	},
	{#State 164
		DEFAULT => -31
	},
	{#State 165
		ACTIONS => {
			'ANDOP' => 113
		},
		DEFAULT => -32
	},
	{#State 166
		ACTIONS => {
			'OROP' => 114,
			'ANDOP' => 113
		},
		DEFAULT => -12
	},
	{#State 167
		ACTIONS => {
			'OROP' => 114,
			'ANDOP' => 113
		},
		DEFAULT => -11
	},
	{#State 168
		ACTIONS => {
			")" => 190
		}
	},
	{#State 169
		ACTIONS => {
			'OROP' => 114,
			'ANDOP' => 113
		},
		DEFAULT => -25
	},
	{#State 170
		ACTIONS => {
			'BITANDOP' => 97,
			'ADDOP' => 105,
			'ASSIGNOP' => 98,
			'POSTINC' => 106,
			'BITOROP' => 107,
			'POWOP' => 99,
			'MATCHOP' => 100,
			'POSTDEC' => 108,
			'DOTDOT' => 109,
			'MULOP' => 110,
			'BITXOROP' => 111,
			'SHIFTOP' => 101,
			'OROR' => 112,
			'ANDAND' => 102,
			'EQOP' => 103,
			'RELOP' => 104
		},
		DEFAULT => -35
	},
	{#State 171
		DEFAULT => -37
	},
	{#State 172
		ACTIONS => {
			"}" => 191
		}
	},
	{#State 173
		DEFAULT => -9
	},
	{#State 174
		DEFAULT => -97
	},
	{#State 175
		DEFAULT => -76
	},
	{#State 176
		ACTIONS => {
			"{" => 60
		},
		GOTOS => {
			'block' => 192
		}
	},
	{#State 177
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 193,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 178
		DEFAULT => -90
	},
	{#State 179
		DEFAULT => -79
	},
	{#State 180
		DEFAULT => -38
	},
	{#State 181
		ACTIONS => {
			"}" => 194
		}
	},
	{#State 182
		DEFAULT => -89
	},
	{#State 183
		ACTIONS => {
			'OROP' => 114,
			")" => 195,
			'ANDOP' => 113
		}
	},
	{#State 184
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 196,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 185
		ACTIONS => {
			"{" => 60
		},
		GOTOS => {
			'block' => 197
		}
	},
	{#State 186
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		DEFAULT => -24,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 169,
			'texpr' => 198,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 187
		ACTIONS => {
			'OROP' => 114,
			")" => 199,
			'ANDOP' => 113
		}
	},
	{#State 188
		DEFAULT => -95
	},
	{#State 189
		DEFAULT => -106
	},
	{#State 190
		ACTIONS => {
			"{" => 60
		},
		GOTOS => {
			'block' => 200
		}
	},
	{#State 191
		DEFAULT => -39
	},
	{#State 192
		ACTIONS => {
			'ELSE' => 201,
			'ELSIF' => 203
		},
		DEFAULT => -13,
		GOTOS => {
			'else' => 202
		}
	},
	{#State 193
		ACTIONS => {
			'BITANDOP' => 97,
			'ADDOP' => 105,
			'ASSIGNOP' => 98,
			'POSTINC' => 106,
			")" => 204,
			'BITOROP' => 107,
			'POWOP' => 99,
			'MATCHOP' => 100,
			'POSTDEC' => 108,
			'DOTDOT' => 109,
			'MULOP' => 110,
			'BITXOROP' => 111,
			'SHIFTOP' => 101,
			'OROR' => 112,
			'ANDAND' => 102,
			'RELOP' => 104,
			'EQOP' => 103
		}
	},
	{#State 194
		DEFAULT => -40
	},
	{#State 195
		ACTIONS => {
			"{" => 60
		},
		GOTOS => {
			'block' => 205
		}
	},
	{#State 196
		ACTIONS => {
			'OROP' => 114,
			")" => 206,
			'ANDOP' => 113
		}
	},
	{#State 197
		DEFAULT => -20
	},
	{#State 198
		ACTIONS => {
			";" => 207
		}
	},
	{#State 199
		DEFAULT => -93
	},
	{#State 200
		DEFAULT => -17
	},
	{#State 201
		ACTIONS => {
			"{" => 60
		},
		GOTOS => {
			'block' => 208
		}
	},
	{#State 202
		DEFAULT => -16
	},
	{#State 203
		ACTIONS => {
			"(" => 209
		}
	},
	{#State 204
		DEFAULT => -91
	},
	{#State 205
		DEFAULT => -19
	},
	{#State 206
		ACTIONS => {
			"{" => 60
		},
		GOTOS => {
			'block' => 210
		}
	},
	{#State 207
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		DEFAULT => -22,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'sideff' => 143,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 46,
			'nexpr' => 211,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 208
		DEFAULT => -14
	},
	{#State 209
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 40,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 41,
			'LSTOP' => 13,
			'STRING' => 45,
			'FUNC' => 43,
			'DOLSHARP' => 42,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 47,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 51,
			"&" => 50,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 49,
			'function' => 37,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 44,
			'ary' => 14,
			'expr' => 212,
			'termbinop' => 21,
			'argexpr' => 52,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 210
		DEFAULT => -18
	},
	{#State 211
		ACTIONS => {
			")" => 213
		}
	},
	{#State 212
		ACTIONS => {
			'OROP' => 114,
			")" => 214,
			'ANDOP' => 113
		}
	},
	{#State 213
		ACTIONS => {
			"{" => 60
		},
		GOTOS => {
			'block' => 215
		}
	},
	{#State 214
		ACTIONS => {
			"{" => 60
		},
		GOTOS => {
			'block' => 216
		}
	},
	{#State 215
		DEFAULT => -21
	},
	{#State 216
		ACTIONS => {
			'ELSE' => 201,
			'ELSIF' => 203
		},
		DEFAULT => -13,
		GOTOS => {
			'else' => 217
		}
	},
	{#State 217
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
#line 217 "plpy.yp"
{
                    printer(\@_, qw( lineseq lineseq decl )); 
                    return "$_[1]$_[2]";
                }
	],
	[#Rule 4
		 'lineseq', 2,
sub
#line 222 "plpy.yp"
{
                    printer(\@_, "lineseq", "lineseq", "line");
                    return "$_[1]$_[2]";
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
		 'line', 1,
sub
#line 233 "plpy.yp"
{
                    printer(\@_, "line", "COMMENT")
                }
	],
	[#Rule 9
		 'block', 3,
sub
#line 240 "plpy.yp"
{
                    printer(\@_, qw( block '{' lineseq '}' )); 
                    # adds indentation
                    $_[3] =~ s/^/    /gm;   #"/
                    return "\n$_[3]\n";
                }
	],
	[#Rule 10
		 'sideff', 1,
sub
#line 250 "plpy.yp"
{
                    printer(\@_, "sideff", "expr");
                    return $_[1];
                }
	],
	[#Rule 11
		 'sideff', 3,
sub
#line 255 "plpy.yp"
{
                    printer(\@_, qw( sideff expr WHILE expr ));
                    return "while $_[3]: $_[1]";
                }
	],
	[#Rule 12
		 'sideff', 3,
sub
#line 260 "plpy.yp"
{
                    printer (\@_, qw(sideff expr FOR expr));
                    return "for $_[3]: $_[1]";
                }
	],
	[#Rule 13
		 'else', 0, undef
	],
	[#Rule 14
		 'else', 2,
sub
#line 269 "plpy.yp"
{
                    printer (\@_, qw( else ELSE block ));
                    return "else:$_[2]";
                }
	],
	[#Rule 15
		 'else', 6,
sub
#line 274 "plpy.yp"
{
                    printer (\@_, qw( else ELSIF '(' expr ')' block else)); 
                    return "elif $_[3]:$_[5]$_[6]";
                }
	],
	[#Rule 16
		 'cond', 6,
sub
#line 282 "plpy.yp"
{
                    printer (\@_, qw( IF '(' expr ')' block else));
                    return "if $_[4]:$_[6]$_[7]";
                    
                }
	],
	[#Rule 17
		 'loop', 5,
sub
#line 291 "plpy.yp"
{
                     printer (\@_, qw(WHILE '(' texpr ')' block cont)); 
                     if ($_[4] =~ /(\w+)\s*=\s*(.*)\s*/) {
                        return "for $1 in $2:$_[6]$_[7]";
                     }
                     else {
                        return "while $_[4]:$_[6]$_[7]";
                     }
                }
	],
	[#Rule 18
		 'loop', 7,
sub
#line 301 "plpy.yp"
{
                    printer (\@_, qw(loop FOR MY scalar '(' expr ')' block cont)); 
                    return "for $_[4] in $_[6]:$_[8]";
                }
	],
	[#Rule 19
		 'loop', 6,
sub
#line 306 "plpy.yp"
{
                    printer (\@_, qw(loop FOR scalar '(' expr ')' block cont)); 
                    return "for $_[2] in $_[5]:$_[7]";
                }
	],
	[#Rule 20
		 'loop', 5,
sub
#line 311 "plpy.yp"
{
                    return "for _ in $_[4]:$_[6]";
                }
	],
	[#Rule 21
		 'loop', 9,
sub
#line 315 "plpy.yp"
{
                    printer (\@_, qw(loop FOR '(' nexpr ';' texpr ';' nexpr ')' block)); 
                    return "$_[4]\nwhile $_[6]:$_[10]$_[8]\n";
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
#line 327 "plpy.yp"
{return "True";}
	],
	[#Rule 25
		 'texpr', 1, undef
	],
	[#Rule 26
		 'decl', 1, undef
	],
	[#Rule 27
		 'subrout', 3, undef
	],
	[#Rule 28
		 'subname', 1, undef
	],
	[#Rule 29
		 'subbody', 1, undef
	],
	[#Rule 30
		 'subbody', 1, undef
	],
	[#Rule 31
		 'expr', 3,
sub
#line 350 "plpy.yp"
{
                    printer (\@_, qw(expr expr ANDOP expr)); 
                    return "$_[1] and $_[3]";
                }
	],
	[#Rule 32
		 'expr', 3,
sub
#line 355 "plpy.yp"
{
                    printer (\@_, qw(expr expr OROP expr)); 
                    return "$_[1] or $_[3]";
                }
	],
	[#Rule 33
		 'expr', 1,
sub
#line 360 "plpy.yp"
{
                    printer(\@_, qw(expr argexpr));
                    return $_[1];
                }
	],
	[#Rule 34
		 'argexpr', 2,
sub
#line 368 "plpy.yp"
{
                    printer (\@_, "argexpr", "','");
                    return "$_[1], ";
                }
	],
	[#Rule 35
		 'argexpr', 3,
sub
#line 373 "plpy.yp"
{
                    printer (\@_, "argexpr", "','", "term");
                    return "$_[1], $_[3]";
                }
	],
	[#Rule 36
		 'argexpr', 1,
sub
#line 378 "plpy.yp"
{
                    printer (\@_, "argexpr", "term");
                    return $_[1];
                }
	],
	[#Rule 37
		 'subscripted', 4,
sub
#line 386 "plpy.yp"
{
                    return "$_[1]$_[2]$_[3]$_[4]"; 
                }
	],
	[#Rule 38
		 'subscripted', 4,
sub
#line 390 "plpy.yp"
{
                    return "$_[1]$_[2]$_[3]$_[4]"; 
                }
	],
	[#Rule 39
		 'subscripted', 5,
sub
#line 394 "plpy.yp"
{
                    $_[0]->yydata->{"PRELUDE"}{"$_[1] = {}"} = 1; 
                    return "$_[1]\[$_[3]\]"; 
                }
	],
	[#Rule 40
		 'subscripted', 5,
sub
#line 399 "plpy.yp"
{
                    return "$_[1]\[$_[3]\]"; 
                }
	],
	[#Rule 41
		 'termbinop', 3,
sub
#line 406 "plpy.yp"
{
                    printer (\@_, "termbinop", "term", "ASSIGNOP", "term");
                    if ($_[2] eq '.=') {$_[2] = '+='}
                    return "$_[1] $_[2] $_[3]";
                }
	],
	[#Rule 42
		 'termbinop', 3,
sub
#line 412 "plpy.yp"
{
                    printer (\@_, "termbinop", "term", "POWOP", "term");
                    return "eval(str($_[1])) $_[2] eval(str($_[3]))";
                }
	],
	[#Rule 43
		 'termbinop', 3,
sub
#line 417 "plpy.yp"
{
                    printer (\@_, "termbinop", "term", "MULOP", "term");
                    return "eval(str($_[1])) $_[2] eval(str($_[3]))";
                }
	],
	[#Rule 44
		 'termbinop', 3,
sub
#line 422 "plpy.yp"
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
	[#Rule 45
		 'termbinop', 3,
sub
#line 432 "plpy.yp"
{
                    printer (\@_, qw(term SHIFTOP term)); 
                    return "$_[1] $_[2] $_[3]";
                }
	],
	[#Rule 46
		 'termbinop', 3,
sub
#line 437 "plpy.yp"
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
	[#Rule 47
		 'termbinop', 3,
sub
#line 449 "plpy.yp"
{
                    printer (\@_, qw(termbinop term EQOP term)); 
                    if ($_[2] eq 'eq') {$_[2] = '=='}
                    if ($_[2] eq '<=>') {
                        return "((a > b) - (a < b))";
                    }
                    return "$_[1] $_[2] $_[3]";
                }
	],
	[#Rule 48
		 'termbinop', 3,
sub
#line 458 "plpy.yp"
{
                    printer (\@_, qw(termbinop term BITANDOP term)); 
                    return "$_[1] & $_[2]";
                }
	],
	[#Rule 49
		 'termbinop', 3,
sub
#line 463 "plpy.yp"
{
                    printer (\@_, qw(termbinop term BITOROP term)); 
                    return "$_[1] | $_[2]";
                }
	],
	[#Rule 50
		 'termbinop', 3,
sub
#line 468 "plpy.yp"
{
                    printer (\@_, qw(termbinop term BITXOROP term)); 
                    return "$_[1] ^ $_[2]";
                }
	],
	[#Rule 51
		 'termbinop', 3,
sub
#line 473 "plpy.yp"
{
                    return "list(range($_[1], $_[3] + 1))";
                }
	],
	[#Rule 52
		 'termbinop', 3,
sub
#line 477 "plpy.yp"
{
                    printer (\@_, qw(termbinop term andand term)); 
                    return "$_[1] and $_[3]";
                }
	],
	[#Rule 53
		 'termbinop', 3,
sub
#line 482 "plpy.yp"
{
                    printer (\@_, qw(termbinop term OROR term)); 
                    return "$_[1] or $_[3]";
                }
	],
	[#Rule 54
		 'termbinop', 3,
sub
#line 487 "plpy.yp"
{
                    $_[0]->yydata->{"IMPORTS"}{"import re"} = 1; 

                    if ($_[3] =~ /^s/) {
                        $_[3] =~ /s\/((?<!\\)(?:\\\\)*.*)\/((?<!\\)(?:\\\\)*.*?)\/([msixpodualngcer]?)/;
                        my $re = $1;
                        my $repl = $2;
                        my $flags = $3;

                        my @flags;
                        if ($flags =~ /i/){push(@flags, "re.i")}
                        if ($flags =~ /m/){push(@flags, "re.m")}
                        if ($flags =~ /s/){push(@flags, "re.s")}
                        $flags = join('| ', @flags);

                        $repl =~ s/(?<!\\)(?:\\\\)*\k\\(\d)/\\$1/;
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
                        $_[3] =~ /\/((?<!\\)(?:\\\\)*.*)\/([imnsxadlup]?)/;
                        my $re = $1;
                        my $flags = $2;

                        my @flags;
                        if ($flags =~ /i/){push(@flags, "re.I")}
                        if ($flags =~ /m/){push(@flags, "re.M")}
                        if ($flags =~ /s/){push(@flags, "re.S")}
                        $flags = join('| ', @flags);

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
	[#Rule 55
		 'termunop', 2,
sub
#line 538 "plpy.yp"
{"-$_[2]"}
	],
	[#Rule 56
		 'termunop', 2,
sub
#line 539 "plpy.yp"
{$_[2]}
	],
	[#Rule 57
		 'termunop', 2,
sub
#line 540 "plpy.yp"
{"not $_[2]"}
	],
	[#Rule 58
		 'termunop', 2,
sub
#line 541 "plpy.yp"
{"~$_[2]"}
	],
	[#Rule 59
		 'termunop', 2,
sub
#line 542 "plpy.yp"
{"$_[1] += 1"}
	],
	[#Rule 60
		 'termunop', 2,
sub
#line 543 "plpy.yp"
{"$_[1] -= 1"}
	],
	[#Rule 61
		 'term', 1, undef
	],
	[#Rule 62
		 'term', 1, undef
	],
	[#Rule 63
		 'term', 1,
sub
#line 549 "plpy.yp"
{
                    if ($_[1] eq "<STDIN>"){
                        $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                        return "sys.stdin.readline()";
                    }
                    elsif ($_[1] eq "<\@STDIN>"){
                        $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                        return "sys.stdin.readlines()";

                    }
                    elsif ($_[1] eq "<>"){
                        $_[0]->YYData->{"IMPORTS"}{"import fileinput"} = 1; 
                        return "fileinput.input()";
                    }
                    else {
                        $_[1] =~ s/<(.*?)>/$1/;
                        return $_[1];
                    }
                    
                }
	],
	[#Rule 64
		 'term', 1, undef
	],
	[#Rule 65
		 'term', 1, undef
	],
	[#Rule 66
		 'term', 1,
sub
#line 572 "plpy.yp"
{
                    $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                    $_[0]->YYData->{"PRELUDE"}{"sys.argv = sys.argv[1:]"} = 1; 
                    return "sys.argv";
                }
	],
	[#Rule 67
		 'term', 1,
sub
#line 578 "plpy.yp"
{
                    printer (\@_, "term", "STRING");
                    $_[1] =~ s/^"\$(\w+)"/$1/;
                    return $_[1];
                }
	],
	[#Rule 68
		 'term', 1, undef
	],
	[#Rule 69
		 'term', 3,
sub
#line 584 "plpy.yp"
{$_[2]}
	],
	[#Rule 70
		 'term', 2,
sub
#line 585 "plpy.yp"
{"$_[1]$_[2]"}
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
		 'term', 1, undef
	],
	[#Rule 76
		 'term', 4,
sub
#line 592 "plpy.yp"
{
                    return "$_[1]$_[2]$_[3]$_[4]"; 
                }
	],
	[#Rule 77
		 'term', 1, undef
	],
	[#Rule 78
		 'term', 3, undef
	],
	[#Rule 79
		 'term', 4, undef
	],
	[#Rule 80
		 'term', 3,
sub
#line 599 "plpy.yp"
{
                    printer (\@_, qw(term NOAMP WORD listexpr)); 
                }
	],
	[#Rule 81
		 'term', 1,
sub
#line 603 "plpy.yp"
{
                    if ($_[1] eq "last")    {return "break"}
                    elsif ($_[1] eq "next") {return "continue"}
                }
	],
	[#Rule 82
		 'term', 2,
sub
#line 607 "plpy.yp"
{"not $_[2]"}
	],
	[#Rule 83
		 'term', 1, undef
	],
	[#Rule 84
		 'term', 1, undef
	],
	[#Rule 85
		 'function', 1,
sub
#line 613 "plpy.yp"
{
                    printer (\@_, qw(term UNIOP)); 
                    if ($_[1] eq "exit"){
                       return "exit()";
                    }
                }
	],
	[#Rule 86
		 'function', 2, undef
	],
	[#Rule 87
		 'function', 2,
sub
#line 621 "plpy.yp"
{
                    printer (\@_, qw(term UNIOP term)); 
                    if ($_[1] eq "chomp"){
                       return "$_[2] = $_[2].strip()";
                    }
                    elsif ($_[1] eq "pop"){
                        return "$_[2].pop()";
                    }
                    elsif ($_[1] eq "shift"){
                        return "$_[2].pop(0)";
                    }
                    elsif ($_[1] eq "close"){
                        return "$_[2].close()";
                    }
                    elsif ($_[1] eq "keys"){
                        return "$_[2].keys()";
                    }
                }
	],
	[#Rule 88
		 'function', 3,
sub
#line 640 "plpy.yp"
{
                    if ($_[1] eq "exit"){
                       return "exit()";
                    }
                }
	],
	[#Rule 89
		 'function', 4,
sub
#line 646 "plpy.yp"
{
                    if ($_[1] eq "exit"){
                       return "exit($_[3])";
                    }
                    elsif ($_[1] eq "chomp"){
                       return "$_[3] = $_[3].strip()";
                    }
                    elsif ($_[1] eq "pop"){
                        return "$_[3].pop()";
                    }
                    elsif ($_[1] eq "shift"){
                        return "$_[3].pop(0)";
                    }
                    elsif ($_[1] eq "close"){
                        return "$_[3].close()";
                    }
                    elsif ($_[1] eq "keys"){
                        return "$_[3].keys()";
                    }
                }
	],
	[#Rule 90
		 'function', 4, undef
	],
	[#Rule 91
		 'function', 6,
sub
#line 668 "plpy.yp"
{
                    $_[3] =~ s/\/(.*)\//$1/;
                    $_[3] =~ s/([\Q{}[]()^$.|*+?\\E\w\s]*)/$1/g;
                    return "split($_[3], $_[5])";
                }
	],
	[#Rule 92
		 'function', 3, undef
	],
	[#Rule 93
		 'function', 5, undef
	],
	[#Rule 94
		 'function', 2,
sub
#line 676 "plpy.yp"
{
                    printer (\@_, "term", "LSTOP", "listexpr");

                    if ($_[1] eq "printf"){
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
                        if ($string =~ s/^.*\K(?:,\s*"\\n"$)|(?:(?<!\\)\\n(?=\s*"$))//){ #"
                            return "print($string % ($list))";
                        }
                        else {
                            return "print($string % ($list), end='')";
                        }
                    }
                    elsif ($_[1] eq "print"){

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
                    elsif ($_[1] eq "split") {
                        return "split($_[2])";
                    }
                    elsif ($_[1] eq "join") {
                        printer (\@_, "term", "LSTOP", "listexpr");
                        my @list = split(', ', $_[2]);
                        my $delim = shift @list;
                        return "'$delim'.join(@list)";
                    }
                    elsif ($_[1] eq "push") {
                        my @list = split(', ', $_[2]);
                        my $array = shift @list;
                        return "$array.append(@list)";
                    }
                    elsif ($_[1] eq "unshift") {
                        my @list = split(', ', $_[2]);
                        my $array = shift @list;
                        return "$array.insert(0, @list)";
                    }
                    elsif ($_[1] eq "reverse") {
                        return "reversed($_[2])";
                    }
                    elsif ($_[1] eq "open") {
                        my @list = split(', ', $_[2]);
                        my $handle = shift @list;
                        my $file = shift @list;
                        $file =~ s/^"(<|>>|>)//; #"
                        my $mode;
                        if ($1 eq '<'){
                            $mode = 'r';
                        }
                        elsif ($1 eq '>>'){
                            $mode = 'w';
                        }
                        elsif ($1 eq '>'){
                            $mode = 'w';
                        }
                        return "$handle = open(\"$file, \'$mode\')";
                    }
                    elsif ($_[1] eq "sort") {
                        my @list = split(', ', $_[2]);
                        #TODO
                        my $handle = shift @list;
                        my $mode = shift @list;
                        #return "$handle = open($array.insert(0, @list)";
                    }
                }
	],
	[#Rule 95
		 'function', 4,
sub
#line 794 "plpy.yp"
{
                    if ($_[1] eq "printf"){
                        my @list;
                        my ($string, @args) =
                        split(/"(?:\\"|""|\\\\|[^"])*"\K,\s*/, $_[3]);

                        my $re = qr/(?<!\\)(?:\\\\)*\K\$\w+(\[(?<!\\)(?:\\\\)*\$\w+\])?/;
                        my @matches = $string =~ /${re}|%[csduoxefgXEGi]/g;
                        $string =~ s/(\$\w+){(.*?);?}/$1\[$2\]/g;
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

                        my $list = join(', ', @list);
                        if ($string =~ s/^.*\K(?:,\s*"\\n"$)|(?:(?<!\\)\\n(?=\s*"$))//){ #"
                            return "print($string % ($list))";
                        }
                        else{
                            return "print($string % ($list), end='')";
                        }
                    }
                    elsif ($_[1] eq "print"){

                        my $new_line = 0;
                        if ($_[3] =~ s/^.*\K(?:,\s*"\\n"$)|(?:(?<!\\)\\n(?=\s*"$))//){
                            $new_line = 1; #"
                        }

                        my @printf; 
                        foreach my $string ( split(/"(?:\\"|""|\\\\|[^"])*"\K,\s*/, $_[3])){
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
                            else{
                                push(@printf, $string);
                            }
                        }

                        my $final = join(', ', @printf);
                        # remove final newline
                        if ($new_line){
                            return "print($final)";
                        }
                        else{
                            return "print($final, end='')";
                        }
                    }
                }
	],
	[#Rule 96
		 'myattrterm', 2,
sub
#line 865 "plpy.yp"
{$_[2]}
	],
	[#Rule 97
		 'myterm', 3,
sub
#line 869 "plpy.yp"
{$_[2]}
	],
	[#Rule 98
		 'myterm', 2, undef
	],
	[#Rule 99
		 'myterm', 1, undef
	],
	[#Rule 100
		 'myterm', 1, undef
	],
	[#Rule 101
		 'myterm', 1, undef
	],
	[#Rule 102
		 'listexpr', 0, undef
	],
	[#Rule 103
		 'listexpr', 1, undef
	],
	[#Rule 104
		 'listexprcom', 0, undef
	],
	[#Rule 105
		 'listexprcom', 1, undef
	],
	[#Rule 106
		 'listexprcom', 2,
sub
#line 885 "plpy.yp"
{"$_[1], "}
	],
	[#Rule 107
		 'amper', 2,
sub
#line 890 "plpy.yp"
{$_[2]}
	],
	[#Rule 108
		 'scalar', 2,
sub
#line 893 "plpy.yp"
{$_[2]}
	],
	[#Rule 109
		 'ary', 2,
sub
#line 896 "plpy.yp"
{$_[2]}
	],
	[#Rule 110
		 'hsh', 2,
sub
#line 899 "plpy.yp"
{$_[2]}
	],
	[#Rule 111
		 'arylen', 2,
sub
#line 902 "plpy.yp"
{return "len($_[2]) - 1";}
	],
	[#Rule 112
		 'indirob', 1, undef
	],
	[#Rule 113
		 'indirob', 1,
sub
#line 908 "plpy.yp"
{
                    $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                    $_[0]->YYData->{"PRELUDE"}{"sys.argv = sys.argv[1:]"} = 1; 
                    return "sys.argv";
                }
	],
	[#Rule 114
		 'indirob', 1, undef
	],
	[#Rule 115
		 'indirob', 1, undef
	]
],
                                  @_);
    bless($self,$class);
}

#line 917 "plpy.yp"


1;
