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
			'FOR' => 38,
			"+" => 39,
			'NOAMP' => 40,
			'DOLSHARP' => 41,
			'FUNC' => 42,
			'STRING' => 44,
			'LOOPEX' => 46,
			'WHILE' => 47,
			"&" => 49,
			'UNIOP' => 50
		},
		DEFAULT => -1,
		GOTOS => {
			'scalar' => 6,
			'subrout' => 36,
			'sideff' => 37,
			'term' => 43,
			'loop' => 15,
			'ary' => 14,
			'expr' => 45,
			'decl' => 18,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24,
			'line' => 25,
			'cond' => 28,
			'arylen' => 48,
			'amper' => 31,
			'myattrterm' => 32,
			'subscripted' => 33,
			'argexpr' => 51
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
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 52,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 6
		ACTIONS => {
			"[" => 53,
			"{" => 54
		},
		DEFAULT => -78
	},
	{#State 7
		ACTIONS => {
			'WORD' => 56,
			'ARGV' => 58,
			"\$" => 19,
			"{" => 59
		},
		GOTOS => {
			'scalar' => 55,
			'indirob' => 57,
			'block' => 60
		}
	},
	{#State 8
		DEFAULT => -71
	},
	{#State 9
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 61,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 10
		ACTIONS => {
			'WORD' => 56,
			'ARGV' => 58,
			"\$" => 19,
			"{" => 59
		},
		GOTOS => {
			'scalar' => 55,
			'indirob' => 62,
			'block' => 60
		}
	},
	{#State 11
		ACTIONS => {
			"(" => 66,
			"\@" => 7,
			"\$" => 19,
			"%" => 10
		},
		GOTOS => {
			'scalar' => 63,
			'myterm' => 67,
			'hsh' => 65,
			'ary' => 64
		}
	},
	{#State 12
		DEFAULT => -12
	},
	{#State 13
		ACTIONS => {
			"-" => 5,
			'WORD' => 68,
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
			'ARGV' => 71,
			"(" => 34,
			'FUNC1' => 35,
			"+" => 39,
			'NOAMP' => 40,
			'DOLSHARP' => 41,
			'FUNC' => 42,
			'STRING' => 44,
			'LOOPEX' => 46,
			"&" => 49,
			'UNIOP' => 50,
			"{" => 59
		},
		DEFAULT => -108,
		GOTOS => {
			'scalar' => 69,
			'arylen' => 48,
			'indirob' => 70,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'termbinop' => 21,
			'block' => 60,
			'argexpr' => 73,
			'listexpr' => 72,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 14
		ACTIONS => {
			"[" => 74
		},
		DEFAULT => -80
	},
	{#State 15
		DEFAULT => -10
	},
	{#State 16
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 75,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 17
		DEFAULT => -70
	},
	{#State 18
		DEFAULT => -7
	},
	{#State 19
		ACTIONS => {
			'WORD' => 56,
			'ARGV' => 58,
			"\$" => 19,
			"{" => 59
		},
		GOTOS => {
			'scalar' => 55,
			'indirob' => 76,
			'block' => 60
		}
	},
	{#State 20
		ACTIONS => {
			"(" => 77
		}
	},
	{#State 21
		DEFAULT => -68
	},
	{#State 22
		DEFAULT => -72
	},
	{#State 23
		DEFAULT => -79
	},
	{#State 24
		DEFAULT => -69
	},
	{#State 25
		DEFAULT => -8
	},
	{#State 26
		ACTIONS => {
			"(" => 78
		}
	},
	{#State 27
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'termbinop' => 21,
			'argexpr' => 79,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 28
		DEFAULT => -9
	},
	{#State 29
		DEFAULT => -73
	},
	{#State 30
		DEFAULT => -34,
		GOTOS => {
			'startsub' => 80
		}
	},
	{#State 31
		ACTIONS => {
			"(" => 81
		},
		DEFAULT => -84
	},
	{#State 32
		DEFAULT => -75
	},
	{#State 33
		ACTIONS => {
			"[" => 82,
			"{" => 83
		},
		DEFAULT => -82
	},
	{#State 34
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			")" => 85,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 84,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 35
		ACTIONS => {
			"(" => 86
		}
	},
	{#State 36
		DEFAULT => -32
	},
	{#State 37
		ACTIONS => {
			";" => 87
		}
	},
	{#State 38
		ACTIONS => {
			"(" => 90,
			"\$" => 19,
			'MY' => 89
		},
		GOTOS => {
			'scalar' => 88
		}
	},
	{#State 39
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 91,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 40
		ACTIONS => {
			'WORD' => 92
		}
	},
	{#State 41
		ACTIONS => {
			'WORD' => 56,
			'ARGV' => 58,
			"\$" => 19,
			"{" => 59
		},
		GOTOS => {
			'scalar' => 55,
			'indirob' => 93,
			'block' => 60
		}
	},
	{#State 42
		ACTIONS => {
			"(" => 94
		}
	},
	{#State 43
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
		DEFAULT => -43
	},
	{#State 44
		DEFAULT => -74
	},
	{#State 45
		ACTIONS => {
			'FOR' => 113,
			'OROP' => 112,
			'ANDOP' => 111,
			'WHILE' => 114
		},
		DEFAULT => -13
	},
	{#State 46
		DEFAULT => -88
	},
	{#State 47
		ACTIONS => {
			"(" => 115
		}
	},
	{#State 48
		DEFAULT => -81
	},
	{#State 49
		ACTIONS => {
			'WORD' => 56,
			'ARGV' => 58,
			"\$" => 19,
			"{" => 59
		},
		GOTOS => {
			'scalar' => 55,
			'indirob' => 116,
			'block' => 60
		}
	},
	{#State 50
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
			"+" => 39,
			'NOAMP' => 40,
			'DOLSHARP' => 41,
			'FUNC' => 42,
			'STRING' => 44,
			'LOOPEX' => 46,
			"&" => 49,
			'UNIOP' => 50,
			"{" => 59
		},
		DEFAULT => -90,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 117,
			'ary' => 14,
			'termbinop' => 21,
			'block' => 118,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 51
		ACTIONS => {
			"," => 119
		},
		DEFAULT => -40
	},
	{#State 52
		ACTIONS => {
			'POSTINC' => 104,
			'POWOP' => 97,
			'POSTDEC' => 106
		},
		DEFAULT => -62
	},
	{#State 53
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 120,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 54
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 121,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 55
		DEFAULT => -121
	},
	{#State 56
		DEFAULT => -119
	},
	{#State 57
		DEFAULT => -116
	},
	{#State 58
		DEFAULT => -120
	},
	{#State 59
		DEFAULT => -3,
		GOTOS => {
			'remember' => 122
		}
	},
	{#State 60
		DEFAULT => -122
	},
	{#State 61
		ACTIONS => {
			'POSTINC' => 104,
			'POWOP' => 97,
			'POSTDEC' => 106
		},
		DEFAULT => -65
	},
	{#State 62
		DEFAULT => -117
	},
	{#State 63
		DEFAULT => -105
	},
	{#State 64
		DEFAULT => -107
	},
	{#State 65
		DEFAULT => -106
	},
	{#State 66
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			")" => 124,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 123,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 67
		DEFAULT => -102
	},
	{#State 68
		ACTIONS => {
			'BITANDOP' => -97,
			'ANDOP' => -97,
			'ASSIGNOP' => -97,
			"]" => -97,
			'POWOP' => -97,
			'MATCHOP' => -97,
			'OROP' => -97,
			'SHIFTOP' => -97,
			'ANDAND' => -97,
			'RELOP' => -97,
			'EQOP' => -97,
			";" => -97,
			'FOR' => -97,
			'ADDOP' => -97,
			"," => -97,
			'POSTINC' => -97,
			'BITOROP' => -97,
			")" => -97,
			'WHILE' => -97,
			'POSTDEC' => -97,
			'DOTDOT' => -97,
			'MULOP' => -97,
			'BITXOROP' => -97,
			'OROR' => -97
		},
		DEFAULT => -119
	},
	{#State 69
		ACTIONS => {
			'BITANDOP' => -78,
			'ANDOP' => -78,
			'ASSIGNOP' => -78,
			"[" => 53,
			"]" => -78,
			'POWOP' => -78,
			'MATCHOP' => -78,
			'OROP' => -78,
			'SHIFTOP' => -78,
			'ANDAND' => -78,
			'RELOP' => -78,
			'EQOP' => -78,
			";" => -78,
			'FOR' => -78,
			'ADDOP' => -78,
			"," => -78,
			'POSTINC' => -78,
			'BITOROP' => -78,
			")" => -78,
			'WHILE' => -78,
			'POSTDEC' => -78,
			"{" => 54,
			'DOTDOT' => -78,
			'MULOP' => -78,
			'BITXOROP' => -78,
			'OROR' => -78
		},
		DEFAULT => -121
	},
	{#State 70
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'termbinop' => 21,
			'argexpr' => 125,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 71
		ACTIONS => {
			'BITANDOP' => -73,
			'ANDOP' => -73,
			'ASSIGNOP' => -73,
			"]" => -73,
			'POWOP' => -73,
			'MATCHOP' => -73,
			'OROP' => -73,
			'SHIFTOP' => -73,
			'ANDAND' => -73,
			'RELOP' => -73,
			'EQOP' => -73,
			";" => -73,
			'FOR' => -73,
			'ADDOP' => -73,
			"," => -73,
			'POSTINC' => -73,
			'BITOROP' => -73,
			")" => -73,
			'WHILE' => -73,
			'POSTDEC' => -73,
			'DOTDOT' => -73,
			'MULOP' => -73,
			'BITXOROP' => -73,
			'OROR' => -73
		},
		DEFAULT => -120
	},
	{#State 72
		DEFAULT => -100
	},
	{#State 73
		ACTIONS => {
			"," => 119
		},
		DEFAULT => -109
	},
	{#State 74
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 126,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 75
		ACTIONS => {
			'POSTINC' => 104,
			'POWOP' => 97,
			'POSTDEC' => 106
		},
		DEFAULT => -64
	},
	{#State 76
		DEFAULT => -115
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
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 128,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 79
		ACTIONS => {
			"," => 119
		},
		DEFAULT => -89
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
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			")" => 132,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 131,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 82
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 133,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 83
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 134,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 84
		ACTIONS => {
			'OROP' => 112,
			")" => 135,
			'ANDOP' => 111
		}
	},
	{#State 85
		DEFAULT => -77
	},
	{#State 86
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			")" => 137,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 136,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 87
		DEFAULT => -11
	},
	{#State 88
		ACTIONS => {
			"(" => 138
		}
	},
	{#State 89
		DEFAULT => -3,
		GOTOS => {
			'remember' => 139
		}
	},
	{#State 90
		DEFAULT => -3,
		GOTOS => {
			'remember' => 140
		}
	},
	{#State 91
		ACTIONS => {
			'POSTINC' => 104,
			'POWOP' => 97,
			'POSTDEC' => 106
		},
		DEFAULT => -63
	},
	{#State 92
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
			"+" => 39,
			'NOAMP' => 40,
			'DOLSHARP' => 41,
			'FUNC' => 42,
			'STRING' => 44,
			'LOOPEX' => 46,
			"&" => 49,
			'UNIOP' => 50
		},
		DEFAULT => -108,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'termbinop' => 21,
			'argexpr' => 73,
			'listexpr' => 141,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 93
		DEFAULT => -118
	},
	{#State 94
		ACTIONS => {
			"-" => 5,
			'WORD' => 68,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 71,
			"{" => 59,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		DEFAULT => -110,
		GOTOS => {
			'scalar' => 69,
			'arylen' => 48,
			'indirob' => 142,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 144,
			'termbinop' => 21,
			'listexprcom' => 143,
			'block' => 60,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 95
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 145,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 96
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 146,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 97
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 147,
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
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 148,
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
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 149,
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
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
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
	{#State 101
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
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
	{#State 102
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
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
	{#State 103
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
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
	{#State 104
		DEFAULT => -66
	},
	{#State 105
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
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
	{#State 106
		DEFAULT => -67
	},
	{#State 107
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
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
	{#State 108
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
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
	{#State 109
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
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
	{#State 110
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
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
	{#State 111
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 159,
			'termbinop' => 21,
			'argexpr' => 51,
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
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 160,
			'termbinop' => 21,
			'argexpr' => 51,
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
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 161,
			'termbinop' => 21,
			'argexpr' => 51,
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
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 162,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 115
		DEFAULT => -3,
		GOTOS => {
			'remember' => 163
		}
	},
	{#State 116
		DEFAULT => -114
	},
	{#State 117
		ACTIONS => {
			'ADDOP' => 103,
			'POSTINC' => 104,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106,
			'MULOP' => 108,
			'SHIFTOP' => 99
		},
		DEFAULT => -92
	},
	{#State 118
		DEFAULT => -91
	},
	{#State 119
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
			"+" => 39,
			'NOAMP' => 40,
			'DOLSHARP' => 41,
			'FUNC' => 42,
			'STRING' => 44,
			'LOOPEX' => 46,
			"&" => 49,
			'UNIOP' => 50
		},
		DEFAULT => -41,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 164,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 120
		ACTIONS => {
			'OROP' => 112,
			"]" => 165,
			'ANDOP' => 111
		}
	},
	{#State 121
		ACTIONS => {
			";" => 166,
			'OROP' => 112,
			'ANDOP' => 111
		}
	},
	{#State 122
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 167
		}
	},
	{#State 123
		ACTIONS => {
			'OROP' => 112,
			")" => 168,
			'ANDOP' => 111
		}
	},
	{#State 124
		DEFAULT => -104
	},
	{#State 125
		ACTIONS => {
			"," => 119
		},
		DEFAULT => -98
	},
	{#State 126
		ACTIONS => {
			'OROP' => 112,
			"]" => 169,
			'ANDOP' => 111
		}
	},
	{#State 127
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'mexpr' => 170,
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 171,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 128
		ACTIONS => {
			'BITANDOP' => 95,
			'ADDOP' => 103,
			"," => 172,
			'ASSIGNOP' => 96,
			'POSTINC' => 104,
			")" => 173,
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
	{#State 129
		DEFAULT => -35
	},
	{#State 130
		ACTIONS => {
			";" => 175,
			"{" => 59
		},
		GOTOS => {
			'block' => 176,
			'subbody' => 174
		}
	},
	{#State 131
		ACTIONS => {
			'OROP' => 112,
			")" => 177,
			'ANDOP' => 111
		}
	},
	{#State 132
		DEFAULT => -85
	},
	{#State 133
		ACTIONS => {
			'OROP' => 112,
			"]" => 178,
			'ANDOP' => 111
		}
	},
	{#State 134
		ACTIONS => {
			";" => 179,
			'OROP' => 112,
			'ANDOP' => 111
		}
	},
	{#State 135
		DEFAULT => -76
	},
	{#State 136
		ACTIONS => {
			'OROP' => 112,
			")" => 180,
			'ANDOP' => 111
		}
	},
	{#State 137
		DEFAULT => -93
	},
	{#State 138
		DEFAULT => -3,
		GOTOS => {
			'remember' => 181
		}
	},
	{#State 139
		ACTIONS => {
			"\$" => 19
		},
		GOTOS => {
			'scalar' => 182,
			'my_scalar' => 183
		}
	},
	{#State 140
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		DEFAULT => -25,
		GOTOS => {
			'mexpr' => 184,
			'scalar' => 6,
			'sideff' => 186,
			'term' => 43,
			'ary' => 14,
			'expr' => 187,
			'nexpr' => 188,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24,
			'arylen' => 48,
			'mnexpr' => 185,
			'amper' => 31,
			'myattrterm' => 32,
			'subscripted' => 33,
			'argexpr' => 51
		}
	},
	{#State 141
		DEFAULT => -87
	},
	{#State 142
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 189,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 143
		ACTIONS => {
			")" => 190
		}
	},
	{#State 144
		ACTIONS => {
			'OROP' => 112,
			"," => 191,
			'ANDOP' => 111
		},
		DEFAULT => -111
	},
	{#State 145
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
		DEFAULT => -55
	},
	{#State 146
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
		DEFAULT => -48
	},
	{#State 147
		ACTIONS => {
			'POSTINC' => 104,
			'POWOP' => 97,
			'POSTDEC' => 106
		},
		DEFAULT => -49
	},
	{#State 148
		ACTIONS => {
			'POSTINC' => 104,
			'POWOP' => 97,
			'POSTDEC' => 106
		},
		DEFAULT => -61
	},
	{#State 149
		ACTIONS => {
			'ADDOP' => 103,
			'POSTINC' => 104,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106,
			'MULOP' => 108
		},
		DEFAULT => -52
	},
	{#State 150
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
		DEFAULT => -59
	},
	{#State 151
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
		DEFAULT => -54
	},
	{#State 152
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
		DEFAULT => -53
	},
	{#State 153
		ACTIONS => {
			'POSTINC' => 104,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106,
			'MULOP' => 108
		},
		DEFAULT => -51
	},
	{#State 154
		ACTIONS => {
			'BITANDOP' => 95,
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
		DEFAULT => -56
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
			'DOTDOT' => undef,
			'MULOP' => 108,
			'BITXOROP' => 109,
			'SHIFTOP' => 99,
			'OROR' => 110,
			'ANDAND' => 100,
			'EQOP' => 101,
			'RELOP' => 102
		},
		DEFAULT => -58
	},
	{#State 156
		ACTIONS => {
			'POSTINC' => 104,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 106
		},
		DEFAULT => -50
	},
	{#State 157
		ACTIONS => {
			'BITANDOP' => 95,
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
		DEFAULT => -57
	},
	{#State 158
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
		DEFAULT => -60
	},
	{#State 159
		DEFAULT => -38
	},
	{#State 160
		ACTIONS => {
			'ANDOP' => 111
		},
		DEFAULT => -39
	},
	{#State 161
		ACTIONS => {
			'OROP' => 112,
			'ANDOP' => 111
		},
		DEFAULT => -15
	},
	{#State 162
		ACTIONS => {
			'OROP' => 112,
			'ANDOP' => 111
		},
		DEFAULT => -14
	},
	{#State 163
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		DEFAULT => -27,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 194,
			'texpr' => 192,
			'termbinop' => 21,
			'mtexpr' => 193,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 164
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
		DEFAULT => -42
	},
	{#State 165
		DEFAULT => -44
	},
	{#State 166
		ACTIONS => {
			"}" => 195
		}
	},
	{#State 167
		ACTIONS => {
			"}" => 196,
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			'FOR' => 38,
			"+" => 39,
			"~" => 9,
			'COMMENT' => 12,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			'IF' => 20,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'WHILE' => 47,
			'NOTOP' => 27,
			'PMFUNC' => 26,
			'SUB' => 30,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 36,
			'sideff' => 37,
			'term' => 43,
			'loop' => 15,
			'ary' => 14,
			'expr' => 45,
			'decl' => 18,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24,
			'line' => 25,
			'cond' => 28,
			'arylen' => 48,
			'amper' => 31,
			'myattrterm' => 32,
			'subscripted' => 33,
			'argexpr' => 51
		}
	},
	{#State 168
		DEFAULT => -103
	},
	{#State 169
		DEFAULT => -83
	},
	{#State 170
		ACTIONS => {
			")" => 197
		}
	},
	{#State 171
		ACTIONS => {
			'OROP' => 112,
			'ANDOP' => 111
		},
		DEFAULT => -29
	},
	{#State 172
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 198,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 173
		DEFAULT => -95
	},
	{#State 174
		DEFAULT => -33
	},
	{#State 175
		DEFAULT => -37
	},
	{#State 176
		DEFAULT => -36
	},
	{#State 177
		DEFAULT => -86
	},
	{#State 178
		DEFAULT => -45
	},
	{#State 179
		ACTIONS => {
			"}" => 199
		}
	},
	{#State 180
		DEFAULT => -94
	},
	{#State 181
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'mexpr' => 200,
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 171,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 182
		DEFAULT => -113
	},
	{#State 183
		ACTIONS => {
			"(" => 201
		}
	},
	{#State 184
		ACTIONS => {
			")" => 202
		}
	},
	{#State 185
		ACTIONS => {
			";" => 203
		}
	},
	{#State 186
		DEFAULT => -26
	},
	{#State 187
		ACTIONS => {
			'FOR' => 113,
			'OROP' => 112,
			")" => -29,
			'ANDOP' => 111,
			'WHILE' => 114
		},
		DEFAULT => -13
	},
	{#State 188
		DEFAULT => -30
	},
	{#State 189
		ACTIONS => {
			'OROP' => 112,
			")" => 204,
			'ANDOP' => 111
		}
	},
	{#State 190
		DEFAULT => -101
	},
	{#State 191
		DEFAULT => -112
	},
	{#State 192
		DEFAULT => -31
	},
	{#State 193
		ACTIONS => {
			")" => 205
		}
	},
	{#State 194
		ACTIONS => {
			'OROP' => 112,
			'ANDOP' => 111
		},
		DEFAULT => -28
	},
	{#State 195
		DEFAULT => -46
	},
	{#State 196
		DEFAULT => -2
	},
	{#State 197
		ACTIONS => {
			"{" => 206
		},
		GOTOS => {
			'mblock' => 207
		}
	},
	{#State 198
		ACTIONS => {
			'BITANDOP' => 95,
			'ADDOP' => 103,
			'ASSIGNOP' => 96,
			'POSTINC' => 104,
			")" => 208,
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
	{#State 199
		DEFAULT => -47
	},
	{#State 200
		ACTIONS => {
			")" => 209
		}
	},
	{#State 201
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'mexpr' => 210,
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 171,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 202
		ACTIONS => {
			"{" => 206
		},
		GOTOS => {
			'mblock' => 211
		}
	},
	{#State 203
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		DEFAULT => -27,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 194,
			'texpr' => 192,
			'termbinop' => 21,
			'mtexpr' => 212,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 204
		DEFAULT => -99
	},
	{#State 205
		ACTIONS => {
			"{" => 206
		},
		GOTOS => {
			'mblock' => 213
		}
	},
	{#State 206
		DEFAULT => -5,
		GOTOS => {
			'mremember' => 214
		}
	},
	{#State 207
		ACTIONS => {
			'ELSE' => 215,
			'ELSIF' => 217
		},
		DEFAULT => -16,
		GOTOS => {
			'else' => 216
		}
	},
	{#State 208
		DEFAULT => -96
	},
	{#State 209
		ACTIONS => {
			"{" => 206
		},
		GOTOS => {
			'mblock' => 218
		}
	},
	{#State 210
		ACTIONS => {
			")" => 219
		}
	},
	{#State 211
		DEFAULT => -23
	},
	{#State 212
		ACTIONS => {
			";" => 220
		}
	},
	{#State 213
		DEFAULT => -20
	},
	{#State 214
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 221
		}
	},
	{#State 215
		ACTIONS => {
			"{" => 206
		},
		GOTOS => {
			'mblock' => 222
		}
	},
	{#State 216
		DEFAULT => -19
	},
	{#State 217
		ACTIONS => {
			"(" => 223
		}
	},
	{#State 218
		DEFAULT => -22
	},
	{#State 219
		ACTIONS => {
			"{" => 206
		},
		GOTOS => {
			'mblock' => 224
		}
	},
	{#State 220
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		DEFAULT => -25,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'sideff' => 186,
			'mnexpr' => 225,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 45,
			'nexpr' => 188,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 221
		ACTIONS => {
			"}" => 226,
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			'FOR' => 38,
			"+" => 39,
			"~" => 9,
			'COMMENT' => 12,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			'IF' => 20,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'WHILE' => 47,
			'NOTOP' => 27,
			'PMFUNC' => 26,
			'SUB' => 30,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 36,
			'sideff' => 37,
			'term' => 43,
			'loop' => 15,
			'ary' => 14,
			'expr' => 45,
			'decl' => 18,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24,
			'line' => 25,
			'cond' => 28,
			'arylen' => 48,
			'amper' => 31,
			'myattrterm' => 32,
			'subscripted' => 33,
			'argexpr' => 51
		}
	},
	{#State 222
		DEFAULT => -17
	},
	{#State 223
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			'REMATCH' => 8,
			"\@" => 7,
			"+" => 39,
			"~" => 9,
			'MY' => 11,
			"%" => 10,
			'NOAMP' => 40,
			'LSTOP' => 13,
			'STRING' => 44,
			'FUNC' => 42,
			'DOLSHARP' => 41,
			"!" => 16,
			'FHANDLE' => 17,
			"\$" => 19,
			'LOOPEX' => 46,
			'RESUB' => 22,
			'PMFUNC' => 26,
			'NOTOP' => 27,
			'ARGV' => 29,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		GOTOS => {
			'mexpr' => 227,
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 171,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 224
		DEFAULT => -21
	},
	{#State 225
		ACTIONS => {
			")" => 228
		}
	},
	{#State 226
		DEFAULT => -4
	},
	{#State 227
		ACTIONS => {
			")" => 229
		}
	},
	{#State 228
		ACTIONS => {
			"{" => 206
		},
		GOTOS => {
			'mblock' => 230
		}
	},
	{#State 229
		ACTIONS => {
			"{" => 206
		},
		GOTOS => {
			'mblock' => 231
		}
	},
	{#State 230
		DEFAULT => -24
	},
	{#State 231
		ACTIONS => {
			'ELSE' => 215,
			'ELSIF' => 217
		},
		DEFAULT => -16,
		GOTOS => {
			'else' => 232
		}
	},
	{#State 232
		DEFAULT => -18
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
#line 212 "plpy.yp"
{
                printer(\@_, "prog", "lineseq");
                return "$_[1]";
            }
	],
	[#Rule 2
		 'block', 4,
sub
#line 220 "plpy.yp"
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
#line 232 "plpy.yp"
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
#line 255 "plpy.yp"
{
                printer(\@_, qw( lineseq lineseq decl )); 
                return "$_[1]$_[2]";
            }
	],
	[#Rule 8
		 'lineseq', 2,
sub
#line 260 "plpy.yp"
{
                printer(\@_, "lineseq", "lineseq", "line");
                return "$_[1]$_[2]";
            }
	],
	[#Rule 9
		 'line', 1,
sub
#line 268 "plpy.yp"
{
                printer(\@_, qw( line cond )); 
                return $_[1];
            }
	],
	[#Rule 10
		 'line', 1,
sub
#line 274 "plpy.yp"
{
                printer(\@_, qw( line loop )); 
                return $_[1];
            }
	],
	[#Rule 11
		 'line', 2,
sub
#line 280 "plpy.yp"
{
                printer(\@_, "line", "sideff", "';'");
                return "$_[1]\n";
            }
	],
	[#Rule 12
		 'line', 1,
sub
#line 285 "plpy.yp"
{
                printer(\@_, "line", "COMMENT");
                return "$_[1]\n";
            }
	],
	[#Rule 13
		 'sideff', 1,
sub
#line 294 "plpy.yp"
{
                printer(\@_, "sideff", "expr");
                return $_[1];
            }
	],
	[#Rule 14
		 'sideff', 3,
sub
#line 299 "plpy.yp"
{
                printer(\@_, qw( sideff expr WHILE expr ));
                return "while $_[3]: $_[1]";
            }
	],
	[#Rule 15
		 'sideff', 3,
sub
#line 304 "plpy.yp"
{
                printer (\@_, qw(sideff expr FOR expr));
                return "for $_[3]: $_[1]";
            }
	],
	[#Rule 16
		 'else', 0, undef
	],
	[#Rule 17
		 'else', 2,
sub
#line 313 "plpy.yp"
{
                printer (\@_, qw( else ELSE mblock ));
                return "else:$_[2]";
            }
	],
	[#Rule 18
		 'else', 6,
sub
#line 318 "plpy.yp"
{
                printer (\@_, qw( else ELSIF '(' mexpr ')' mblock else)); 
                return "elif $_[3]:$_[5]$_[6]";
            }
	],
	[#Rule 19
		 'cond', 7,
sub
#line 326 "plpy.yp"
{
                printer (\@_, qw( IF '(' remember mexpr ')' mblock else));
                return "if $_[4]:$_[6]$_[7]";
                
            }
	],
	[#Rule 20
		 'loop', 6,
sub
#line 335 "plpy.yp"
{
                 printer (\@_, qw(WHILE '(' remember mtexpr ')' mblock cont)); 
                 if ($_[4] =~ /(\w+)\s*=\s*(.*)\s*/){
                    return "for $1 in $2:$_[6]$_[7]";
                 }
                 else{
                    return "while $_[4]:$_[6]$_[7]";
                 }
            }
	],
	[#Rule 21
		 'loop', 8,
sub
#line 345 "plpy.yp"
{
                printer (\@_, qw(loop FOR MY remember my_scalar '(' mexpr ')' mblock cont)); 
                return "for $_[4] in $_[6]:$_[8]";
            }
	],
	[#Rule 22
		 'loop', 7,
sub
#line 350 "plpy.yp"
{
                printer (\@_, qw(loop FOR scalar '(' mexpr ')' mblock cont)); 
                return "for $_[2] in $_[5]:$_[7]";
            }
	],
	[#Rule 23
		 'loop', 6,
sub
#line 355 "plpy.yp"
{
                return "for _ in $_[4]:$_[6]";
            }
	],
	[#Rule 24
		 'loop', 10,
sub
#line 359 "plpy.yp"
{
                printer (\@_, qw(loop FOR '(' remember mnexpr ';' mtexpr ';' mnexpr ')' mblock)); 
                return "$_[4]\nwhile $_[6]:$_[10]$_[8]\n";
            }
	],
	[#Rule 25
		 'nexpr', 0,
sub
#line 367 "plpy.yp"
{}
	],
	[#Rule 26
		 'nexpr', 1, undef
	],
	[#Rule 27
		 'texpr', 0,
sub
#line 373 "plpy.yp"
{}
	],
	[#Rule 28
		 'texpr', 1, undef
	],
	[#Rule 29
		 'mexpr', 1,
sub
#line 379 "plpy.yp"
{
                printer (\@_, qw(mexpr expr) ); 
                return $_[1];
            }
	],
	[#Rule 30
		 'mnexpr', 1, undef
	],
	[#Rule 31
		 'mtexpr', 1, undef
	],
	[#Rule 32
		 'decl', 1,
sub
#line 393 "plpy.yp"
{}
	],
	[#Rule 33
		 'subrout', 4,
sub
#line 398 "plpy.yp"
{
            }
	],
	[#Rule 34
		 'startsub', 0,
sub
#line 403 "plpy.yp"
{}
	],
	[#Rule 35
		 'subname', 1,
sub
#line 407 "plpy.yp"
{}
	],
	[#Rule 36
		 'subbody', 1,
sub
#line 411 "plpy.yp"
{}
	],
	[#Rule 37
		 'subbody', 1,
sub
#line 412 "plpy.yp"
{}
	],
	[#Rule 38
		 'expr', 3,
sub
#line 418 "plpy.yp"
{
                printer (\@_, qw(expr expr ANDOP expr)); 
                return "$_[1] and $_[3]";
            }
	],
	[#Rule 39
		 'expr', 3,
sub
#line 423 "plpy.yp"
{
                printer (\@_, qw(expr expr OROP expr)); 
                return "$_[1] or $_[3]";
            }
	],
	[#Rule 40
		 'expr', 1,
sub
#line 428 "plpy.yp"
{
                printer(\@_, qw(expr argexpr));
                return $_[1];
            }
	],
	[#Rule 41
		 'argexpr', 2,
sub
#line 436 "plpy.yp"
{
                printer (\@_, "argexpr", "','");
                return "$_[1], ";
            }
	],
	[#Rule 42
		 'argexpr', 3,
sub
#line 441 "plpy.yp"
{
                printer (\@_, "argexpr", "','", "term");
                return "$_[1], $_[3]";
            }
	],
	[#Rule 43
		 'argexpr', 1,
sub
#line 446 "plpy.yp"
{
                printer (\@_, "argexpr", "term");
                return $_[1];
            }
	],
	[#Rule 44
		 'subscripted', 4,
sub
#line 456 "plpy.yp"
{
                return "$_[1]$_[2]$_[3]$_[4]"; 
            }
	],
	[#Rule 45
		 'subscripted', 4,
sub
#line 460 "plpy.yp"
{
                return "$_[1]$_[2]$_[3]$_[4]"; 
            }
	],
	[#Rule 46
		 'subscripted', 5,
sub
#line 464 "plpy.yp"
{
                $_[0]->YYData->{"PRELUDE"}{"$_[1] = {}"} = 1; 
                return "$_[1]\[$_[3]\]"; 
            }
	],
	[#Rule 47
		 'subscripted', 5,
sub
#line 469 "plpy.yp"
{
                return "$_[1]\[$_[3]\]"; 
            }
	],
	[#Rule 48
		 'termbinop', 3,
sub
#line 476 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "ASSIGNOP", "term");
                if ($_[2] eq '.=') {$_[2] = '+='}
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 49
		 'termbinop', 3,
sub
#line 482 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "POWOP", "term");
                return "eval(str($_[1])) $_[2] eval(str($_[3]))";
            }
	],
	[#Rule 50
		 'termbinop', 3,
sub
#line 487 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "MULOP", "term");
                return "eval(str($_[1])) $_[2] eval(str($_[3]))";
            }
	],
	[#Rule 51
		 'termbinop', 3,
sub
#line 492 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "ADDOP", "term");
                if ($_[2] eq '.'){
                    return "$_[1] + $_[3]";
                }
                else{
                    return "eval(str($_[1])) $_[2] eval(str($_[3]))";
                }
            }
	],
	[#Rule 52
		 'termbinop', 3,
sub
#line 502 "plpy.yp"
{
                printer (\@_, qw(term SHIFTOP term)); 
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 53
		 'termbinop', 3,
sub
#line 507 "plpy.yp"
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
	[#Rule 54
		 'termbinop', 3,
sub
#line 519 "plpy.yp"
{
                printer (\@_, qw(termbinop term EQOP term)); 
                if ($_[2] eq 'eq') {$_[2] = '=='}
                if ($_[2] eq '<=>') {
                    return "((a > b) - (a < b))";
                }
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 55
		 'termbinop', 3,
sub
#line 528 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITANDOP term)); 
                return "$_[1] & $_[2]";
            }
	],
	[#Rule 56
		 'termbinop', 3,
sub
#line 533 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITOROP term)); 
                return "$_[1] | $_[2]";
            }
	],
	[#Rule 57
		 'termbinop', 3,
sub
#line 538 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITXOROP term)); 
                return "$_[1] ^ $_[2]";
            }
	],
	[#Rule 58
		 'termbinop', 3,
sub
#line 543 "plpy.yp"
{
                return "list(range($_[1], $_[3] + 1))";
            }
	],
	[#Rule 59
		 'termbinop', 3,
sub
#line 547 "plpy.yp"
{
                printer (\@_, qw(termbinop term ANDAND term)); 
                return "$_[1] and $_[3]";
            }
	],
	[#Rule 60
		 'termbinop', 3,
sub
#line 552 "plpy.yp"
{
                printer (\@_, qw(termbinop term OROR term)); 
                return "$_[1] or $_[3]";
            }
	],
	[#Rule 61
		 'termbinop', 3,
sub
#line 557 "plpy.yp"
{
                $_[0]->YYData->{"IMPORTS"}{"import re"} = 1; 
                if ($_[3] =~ /^s/){
                    $_[3] =~ /s\/((?<!\\)(?:\\\\)*.*)\/((?<!\\)(?:\\\\)*.*?)\/([msixpodualngcer]?)/;
                    my $re = $1;
                    my $repl = $2;
                    my $flags = $3;

                    my @flags;
                    if ($flags =~ /i/){push(@flags, "re.I")}
                    if ($flags =~ /m/){push(@flags, "re.M")}
                    if ($flags =~ /s/){push(@flags, "re.S")}
                    $flags = join('| ', @flags);

                    $repl =~ s/(?<!\\)(?:\\\\)*\K\\(\d)/\\$1/;
                    if ($flags){
                        return "$_[1] = re.sub(r'$re', '$repl', $_[1], $flags)";
                    }
                    else{
                        return "$_[1] = re.sub(r'$re', '$repl', $_[1])";
                    }
                }
                else{
                    $_[3] =~ /\/((?<!\\)(?:\\\\)*.*)\/([imnsxadlup]?)/;
                    my $re = $1;
                    my $flags = $2;

                    my @flags;
                    if ($flags =~ /i/){push(@flags, "re.I")}
                    if ($flags =~ /m/){push(@flags, "re.M")}
                    if ($flags =~ /s/){push(@flags, "re.S")}
                    $flags = join('| ', @flags);

                    if ($flags){
                        return "__MATCH__ = re.search(r'$re', $_[1], $flags)";
                    }
                    else{
                        return "__MATCH__ = re.search(r'$re', $_[1])";
                    }
                    
                }
            }
	],
	[#Rule 62
		 'termunop', 2,
sub
#line 603 "plpy.yp"
{
                return "-$_[2]"; 
            }
	],
	[#Rule 63
		 'termunop', 2,
sub
#line 607 "plpy.yp"
{
                return $_[2]; 
            }
	],
	[#Rule 64
		 'termunop', 2,
sub
#line 611 "plpy.yp"
{
                printer (\@_, qw(termunop '!' term)); 
                return "not $_[2]";
            }
	],
	[#Rule 65
		 'termunop', 2,
sub
#line 616 "plpy.yp"
{
                printer (\@_, qw(termunop '~' term)); 
                return "~$_[2]";
            }
	],
	[#Rule 66
		 'termunop', 2,
sub
#line 621 "plpy.yp"
{
                printer (\@_, qw(termunop term POSTINC)); 
                return "$_[1] += 1";
            }
	],
	[#Rule 67
		 'termunop', 2,
sub
#line 626 "plpy.yp"
{
                printer (\@_, qw(termunop term POSTDEC)); 
                return "$_[1] -= 1";
            }
	],
	[#Rule 68
		 'term', 1, undef
	],
	[#Rule 69
		 'term', 1, undef
	],
	[#Rule 70
		 'term', 1,
sub
#line 635 "plpy.yp"
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
                else{
                    $_[1] =~ s/<(.*?)>/$1/;
                    return $_[1];
                }
                
            }
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
#line 658 "plpy.yp"
{
                $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                $_[0]->YYData->{"PRELUDE"}{"sys.argv = sys.argv[1:]"} = 1; 
                return "sys.argv";
            }
	],
	[#Rule 74
		 'term', 1,
sub
#line 664 "plpy.yp"
{
                printer (\@_, "term", "STRING");
                $_[1] =~ s/^"\$(\w+)"/$1/;
                return $_[1];
            }
	],
	[#Rule 75
		 'term', 1,
sub
#line 671 "plpy.yp"
{}
	],
	[#Rule 76
		 'term', 3,
sub
#line 673 "plpy.yp"
{
                return $_[2];    
            }
	],
	[#Rule 77
		 'term', 2,
sub
#line 677 "plpy.yp"
{}
	],
	[#Rule 78
		 'term', 1,
sub
#line 679 "plpy.yp"
{
                printer (\@_, "term", "scalar");
                return $_[1];
            }
	],
	[#Rule 79
		 'term', 1,
sub
#line 684 "plpy.yp"
{}
	],
	[#Rule 80
		 'term', 1,
sub
#line 686 "plpy.yp"
{
                printer (\@_, qw(term ary)); 
                return $_[1];
            }
	],
	[#Rule 81
		 'term', 1, undef
	],
	[#Rule 82
		 'term', 1, undef
	],
	[#Rule 83
		 'term', 4,
sub
#line 693 "plpy.yp"
{
                return "$_[1]$_[2]$_[3]$_[4]"; 
            }
	],
	[#Rule 84
		 'term', 1,
sub
#line 697 "plpy.yp"
{}
	],
	[#Rule 85
		 'term', 3,
sub
#line 699 "plpy.yp"
{}
	],
	[#Rule 86
		 'term', 4,
sub
#line 701 "plpy.yp"
{}
	],
	[#Rule 87
		 'term', 3,
sub
#line 703 "plpy.yp"
{
                printer (\@_, qw(term NOAMP WORD listexpr)); 
            }
	],
	[#Rule 88
		 'term', 1,
sub
#line 707 "plpy.yp"
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
#line 717 "plpy.yp"
{
                printer (\@_, qw(term NOTOP argexpr)); 
                return "not $_[2]";
            }
	],
	[#Rule 90
		 'term', 1,
sub
#line 722 "plpy.yp"
{
                printer (\@_, qw(term UNIOP)); 
                if ($_[1] eq "exit"){
                   return "exit()";
                }
            }
	],
	[#Rule 91
		 'term', 2,
sub
#line 729 "plpy.yp"
{}
	],
	[#Rule 92
		 'term', 2,
sub
#line 731 "plpy.yp"
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
	[#Rule 93
		 'term', 3,
sub
#line 751 "plpy.yp"
{
                if ($_[1] eq "exit"){
                   return "exit()";
                }
            }
	],
	[#Rule 94
		 'term', 4,
sub
#line 757 "plpy.yp"
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
	[#Rule 95
		 'term', 4,
sub
#line 778 "plpy.yp"
{}
	],
	[#Rule 96
		 'term', 6,
sub
#line 780 "plpy.yp"
{
                $_[3] =~ s/\/(.*)\//$1/;
                #$_[3] =~ s/\\([\{\}\[\]\(\)\^\$\.\|\*\+\?\\])/$1/g;
                $_[3] =~ s/\\([\Q{}[]()^$.|*+?\\E])/$1/g;
                return "split($_[3], $_[5])";
            }
	],
	[#Rule 97
		 'term', 1, undef
	],
	[#Rule 98
		 'term', 3,
sub
#line 790 "plpy.yp"
{
                #sort goes here
                printer (\@_, "term", "LSTOP", "indirob", "argexpr");
            }
	],
	[#Rule 99
		 'term', 5,
sub
#line 795 "plpy.yp"
{
                #sort goes here
            }
	],
	[#Rule 100
		 'term', 2,
sub
#line 799 "plpy.yp"
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
                    else{
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
                        $mode = 'r';
                    }
                    elsif ($1 eq '>'){
                        $mode = 'r';
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
	[#Rule 101
		 'term', 4,
sub
#line 917 "plpy.yp"
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
	[#Rule 102
		 'myattrterm', 2,
sub
#line 990 "plpy.yp"
{
                return $_[2];
            }
	],
	[#Rule 103
		 'myterm', 3,
sub
#line 997 "plpy.yp"
{
                    return $_[2];
                }
	],
	[#Rule 104
		 'myterm', 2, undef
	],
	[#Rule 105
		 'myterm', 1, undef
	],
	[#Rule 106
		 'myterm', 1, undef
	],
	[#Rule 107
		 'myterm', 1, undef
	],
	[#Rule 108
		 'listexpr', 0,
sub
#line 1009 "plpy.yp"
{print "empty listexpr\n";}
	],
	[#Rule 109
		 'listexpr', 1,
sub
#line 1011 "plpy.yp"
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
#line 1020 "plpy.yp"
{
                printer (\@_, "listexprcom", "expr");
                return "$_[1]";
            }
	],
	[#Rule 112
		 'listexprcom', 2,
sub
#line 1025 "plpy.yp"
{
                printer (\@_, "listexprcom", "expr", "','");
                return "$_[1], ";
            }
	],
	[#Rule 113
		 'my_scalar', 1, undef
	],
	[#Rule 114
		 'amper', 2, undef
	],
	[#Rule 115
		 'scalar', 2,
sub
#line 1041 "plpy.yp"
{
                printer (\@_, "scalar", "'\$'", "indirob"); 
                return "$_[2]";
            }
	],
	[#Rule 116
		 'ary', 2,
sub
#line 1048 "plpy.yp"
{
                printer (\@_, "scalar", "'\@'", "indirob"); 
                return $_[2];
            }
	],
	[#Rule 117
		 'hsh', 2,
sub
#line 1054 "plpy.yp"
{
            return $_[2];
            }
	],
	[#Rule 118
		 'arylen', 2,
sub
#line 1059 "plpy.yp"
{return "len($_[2]) - 1";}
	],
	[#Rule 119
		 'indirob', 1,
sub
#line 1064 "plpy.yp"
{
                printer (\@_, "indirob", "WORD");
                return $_[1];
            }
	],
	[#Rule 120
		 'indirob', 1,
sub
#line 1069 "plpy.yp"
{
                $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                $_[0]->YYData->{"PRELUDE"}{"sys.argv = sys.argv[1:]"} = 1; 
                return "sys.argv";
            }
	],
	[#Rule 121
		 'indirob', 1, undef
	],
	[#Rule 122
		 'indirob', 1,
sub
#line 1076 "plpy.yp"
{printer (\@_, qw(indirob indexblock));}
	]
],
                                  @_);
    bless($self,$class);
}

#line 1079 "plpy.yp"


1;
