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
    my $lop = "print|printf|join|split|push|unshift|reverse|open|sort";
    my @tokens = (
        # matches a string with double or escaped quotes 
        #["STRING", qr/"(?:\\"|""|\\\\|[^"])*"/],
        ["STRING", qr/^"(?:[^"\\]|\\.|"")*"/],
        # matches until first ', avoiding \'
        ["STRING", qr/'.*?(?<!\\)'/],
        # matches matching functions split (/foo/, $bar)
        ["PMFUNC", qr/split(?=\s*\(\s*\/)/],
        ["RESUB", qr/s\/(?:(?<!\\)(?:\\\\)*.*?\/){2}[msixpodualngcer]?/],
        ["REMATCH", qr/m?\/(?<!\\)(?:\\\\)*.*?\/[imnsxadlup]?/],
        #matches all functions with brackets
        ["FUNC1", qr/(?:${uni})(?=\s*\()/],
        ["UNIOP", qr/(?:${uni})(?!\s*\()/],
        ["FUNC", qr/(?:${lop})(?=\s*\()/],
        ["LSTOP", qr/(?:${lop})(?!\s*\()/],
        ["FHANDLE", qr/<.*?>/],
        ["ARGV", qr/ARGV/],
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
		DEFAULT => -94
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
			"[" => 53
		},
		DEFAULT => -75
	},
	{#State 7
		ACTIONS => {
			'WORD' => 55,
			'ARGV' => 57,
			"\$" => 19,
			"{" => 58
		},
		GOTOS => {
			'scalar' => 54,
			'indirob' => 56,
			'block' => 59
		}
	},
	{#State 8
		DEFAULT => -68
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
			'term' => 60,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 10
		ACTIONS => {
			'WORD' => 55,
			'ARGV' => 57,
			"\$" => 19,
			"{" => 58
		},
		GOTOS => {
			'scalar' => 54,
			'indirob' => 61,
			'block' => 59
		}
	},
	{#State 11
		ACTIONS => {
			"(" => 65,
			"\@" => 7,
			"\$" => 19,
			"%" => 10
		},
		GOTOS => {
			'scalar' => 62,
			'myterm' => 66,
			'hsh' => 64,
			'ary' => 63
		}
	},
	{#State 12
		DEFAULT => -12
	},
	{#State 13
		ACTIONS => {
			"-" => 5,
			'WORD' => 67,
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
			'ARGV' => 70,
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
			"{" => 58
		},
		DEFAULT => -105,
		GOTOS => {
			'scalar' => 68,
			'arylen' => 48,
			'indirob' => 69,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'termbinop' => 21,
			'block' => 59,
			'argexpr' => 72,
			'listexpr' => 71,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 14
		ACTIONS => {
			"[" => 73
		},
		DEFAULT => -77
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
			'term' => 74,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 17
		DEFAULT => -67
	},
	{#State 18
		DEFAULT => -7
	},
	{#State 19
		ACTIONS => {
			'WORD' => 55,
			'ARGV' => 57,
			"\$" => 19,
			"{" => 58
		},
		GOTOS => {
			'scalar' => 54,
			'indirob' => 75,
			'block' => 59
		}
	},
	{#State 20
		ACTIONS => {
			"(" => 76
		}
	},
	{#State 21
		DEFAULT => -65
	},
	{#State 22
		DEFAULT => -69
	},
	{#State 23
		DEFAULT => -76
	},
	{#State 24
		DEFAULT => -66
	},
	{#State 25
		DEFAULT => -8
	},
	{#State 26
		ACTIONS => {
			"(" => 77
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
			'argexpr' => 78,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 28
		DEFAULT => -9
	},
	{#State 29
		DEFAULT => -70
	},
	{#State 30
		DEFAULT => -34,
		GOTOS => {
			'startsub' => 79
		}
	},
	{#State 31
		ACTIONS => {
			"(" => 80
		},
		DEFAULT => -81
	},
	{#State 32
		DEFAULT => -72
	},
	{#State 33
		DEFAULT => -79
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
			")" => 82,
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
			'expr' => 81,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 35
		ACTIONS => {
			"(" => 83
		}
	},
	{#State 36
		DEFAULT => -32
	},
	{#State 37
		ACTIONS => {
			";" => 84
		}
	},
	{#State 38
		ACTIONS => {
			"(" => 87,
			"\$" => 19,
			'MY' => 86
		},
		GOTOS => {
			'scalar' => 85
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
			'term' => 88,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 40
		ACTIONS => {
			'WORD' => 89
		}
	},
	{#State 41
		ACTIONS => {
			'WORD' => 55,
			'ARGV' => 57,
			"\$" => 19,
			"{" => 58
		},
		GOTOS => {
			'scalar' => 54,
			'indirob' => 90,
			'block' => 59
		}
	},
	{#State 42
		ACTIONS => {
			"(" => 91
		}
	},
	{#State 43
		ACTIONS => {
			'BITANDOP' => 92,
			'ADDOP' => 100,
			'ASSIGNOP' => 93,
			'POSTINC' => 101,
			'BITOROP' => 102,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103,
			'DOTDOT' => 104,
			'MULOP' => 105,
			'BITXOROP' => 106,
			'SHIFTOP' => 96,
			'OROR' => 107,
			'ANDAND' => 97,
			'EQOP' => 98,
			'RELOP' => 99
		},
		DEFAULT => -43
	},
	{#State 44
		DEFAULT => -71
	},
	{#State 45
		ACTIONS => {
			'FOR' => 110,
			'OROP' => 109,
			'ANDOP' => 108,
			'WHILE' => 111
		},
		DEFAULT => -13
	},
	{#State 46
		DEFAULT => -85
	},
	{#State 47
		ACTIONS => {
			"(" => 112
		}
	},
	{#State 48
		DEFAULT => -78
	},
	{#State 49
		ACTIONS => {
			'WORD' => 55,
			'ARGV' => 57,
			"\$" => 19,
			"{" => 58
		},
		GOTOS => {
			'scalar' => 54,
			'indirob' => 113,
			'block' => 59
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
			"{" => 58
		},
		DEFAULT => -87,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 114,
			'ary' => 14,
			'termbinop' => 21,
			'block' => 115,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 51
		ACTIONS => {
			"," => 116
		},
		DEFAULT => -40
	},
	{#State 52
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 94,
			'POSTDEC' => 103
		},
		DEFAULT => -59
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
			'expr' => 117,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 54
		DEFAULT => -118
	},
	{#State 55
		DEFAULT => -116
	},
	{#State 56
		DEFAULT => -113
	},
	{#State 57
		DEFAULT => -117
	},
	{#State 58
		DEFAULT => -3,
		GOTOS => {
			'remember' => 118
		}
	},
	{#State 59
		DEFAULT => -119
	},
	{#State 60
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 94,
			'POSTDEC' => 103
		},
		DEFAULT => -62
	},
	{#State 61
		DEFAULT => -114
	},
	{#State 62
		DEFAULT => -102
	},
	{#State 63
		DEFAULT => -104
	},
	{#State 64
		DEFAULT => -103
	},
	{#State 65
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
			")" => 120,
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
			'expr' => 119,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 66
		DEFAULT => -99
	},
	{#State 67
		ACTIONS => {
			'BITANDOP' => -94,
			'ANDOP' => -94,
			'ASSIGNOP' => -94,
			"]" => -94,
			'POWOP' => -94,
			'MATCHOP' => -94,
			'OROP' => -94,
			'SHIFTOP' => -94,
			'ANDAND' => -94,
			'RELOP' => -94,
			'EQOP' => -94,
			";" => -94,
			'FOR' => -94,
			'ADDOP' => -94,
			"," => -94,
			'POSTINC' => -94,
			'BITOROP' => -94,
			")" => -94,
			'WHILE' => -94,
			'POSTDEC' => -94,
			'DOTDOT' => -94,
			'MULOP' => -94,
			'BITXOROP' => -94,
			'OROR' => -94
		},
		DEFAULT => -116
	},
	{#State 68
		ACTIONS => {
			'BITANDOP' => -75,
			'ANDOP' => -75,
			'ASSIGNOP' => -75,
			"[" => 53,
			"]" => -75,
			'POWOP' => -75,
			'MATCHOP' => -75,
			'OROP' => -75,
			'SHIFTOP' => -75,
			'ANDAND' => -75,
			'RELOP' => -75,
			'EQOP' => -75,
			";" => -75,
			'FOR' => -75,
			'ADDOP' => -75,
			"," => -75,
			'POSTINC' => -75,
			'BITOROP' => -75,
			")" => -75,
			'WHILE' => -75,
			'POSTDEC' => -75,
			'DOTDOT' => -75,
			'MULOP' => -75,
			'BITXOROP' => -75,
			'OROR' => -75
		},
		DEFAULT => -118
	},
	{#State 69
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
			'argexpr' => 121,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 70
		ACTIONS => {
			'BITANDOP' => -70,
			'ANDOP' => -70,
			'ASSIGNOP' => -70,
			"]" => -70,
			'POWOP' => -70,
			'MATCHOP' => -70,
			'OROP' => -70,
			'SHIFTOP' => -70,
			'ANDAND' => -70,
			'RELOP' => -70,
			'EQOP' => -70,
			";" => -70,
			'FOR' => -70,
			'ADDOP' => -70,
			"," => -70,
			'POSTINC' => -70,
			'BITOROP' => -70,
			")" => -70,
			'WHILE' => -70,
			'POSTDEC' => -70,
			'DOTDOT' => -70,
			'MULOP' => -70,
			'BITXOROP' => -70,
			'OROR' => -70
		},
		DEFAULT => -117
	},
	{#State 71
		DEFAULT => -97
	},
	{#State 72
		ACTIONS => {
			"," => 116
		},
		DEFAULT => -106
	},
	{#State 73
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
			'expr' => 122,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 74
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 94,
			'POSTDEC' => 103
		},
		DEFAULT => -61
	},
	{#State 75
		DEFAULT => -112
	},
	{#State 76
		DEFAULT => -3,
		GOTOS => {
			'remember' => 123
		}
	},
	{#State 77
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
			'term' => 124,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 78
		ACTIONS => {
			"," => 116
		},
		DEFAULT => -86
	},
	{#State 79
		ACTIONS => {
			'WORD' => 125
		},
		GOTOS => {
			'subname' => 126
		}
	},
	{#State 80
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
			")" => 128,
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
			'expr' => 127,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 81
		ACTIONS => {
			'OROP' => 109,
			")" => 129,
			'ANDOP' => 108
		}
	},
	{#State 82
		DEFAULT => -74
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
			")" => 131,
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
			'expr' => 130,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 84
		DEFAULT => -11
	},
	{#State 85
		ACTIONS => {
			"(" => 132
		}
	},
	{#State 86
		DEFAULT => -3,
		GOTOS => {
			'remember' => 133
		}
	},
	{#State 87
		DEFAULT => -3,
		GOTOS => {
			'remember' => 134
		}
	},
	{#State 88
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 94,
			'POSTDEC' => 103
		},
		DEFAULT => -60
	},
	{#State 89
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
		DEFAULT => -105,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'termbinop' => 21,
			'argexpr' => 72,
			'listexpr' => 135,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 90
		DEFAULT => -115
	},
	{#State 91
		ACTIONS => {
			"-" => 5,
			'WORD' => 67,
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
			'ARGV' => 70,
			"{" => 58,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		DEFAULT => -107,
		GOTOS => {
			'scalar' => 68,
			'arylen' => 48,
			'indirob' => 136,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 138,
			'termbinop' => 21,
			'listexprcom' => 137,
			'block' => 59,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 92
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
			'term' => 139,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 93
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
			'term' => 140,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 94
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
			'term' => 141,
			'ary' => 14,
			'termbinop' => 21,
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
			'term' => 142,
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
			'term' => 143,
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
			'term' => 144,
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
			'term' => 145,
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
			'term' => 146,
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
			'term' => 147,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 101
		DEFAULT => -63
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
			'term' => 148,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 103
		DEFAULT => -64
	},
	{#State 104
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
			'term' => 150,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 106
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
			'term' => 152,
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
			'term' => 43,
			'ary' => 14,
			'expr' => 153,
			'termbinop' => 21,
			'argexpr' => 51,
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
			'term' => 43,
			'ary' => 14,
			'expr' => 154,
			'termbinop' => 21,
			'argexpr' => 51,
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
			'term' => 43,
			'ary' => 14,
			'expr' => 155,
			'termbinop' => 21,
			'argexpr' => 51,
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
			'expr' => 156,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 112
		DEFAULT => -3,
		GOTOS => {
			'remember' => 157
		}
	},
	{#State 113
		DEFAULT => -111
	},
	{#State 114
		ACTIONS => {
			'ADDOP' => 100,
			'POSTINC' => 101,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103,
			'MULOP' => 105,
			'SHIFTOP' => 96
		},
		DEFAULT => -89
	},
	{#State 115
		DEFAULT => -88
	},
	{#State 116
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
			'term' => 158,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 117
		ACTIONS => {
			'OROP' => 109,
			"]" => 159,
			'ANDOP' => 108
		}
	},
	{#State 118
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 160
		}
	},
	{#State 119
		ACTIONS => {
			'OROP' => 109,
			")" => 161,
			'ANDOP' => 108
		}
	},
	{#State 120
		DEFAULT => -101
	},
	{#State 121
		ACTIONS => {
			"," => 116
		},
		DEFAULT => -95
	},
	{#State 122
		ACTIONS => {
			'OROP' => 109,
			"]" => 162,
			'ANDOP' => 108
		}
	},
	{#State 123
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
			'mexpr' => 163,
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 164,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 124
		ACTIONS => {
			'BITANDOP' => 92,
			'ADDOP' => 100,
			"," => 165,
			'ASSIGNOP' => 93,
			'POSTINC' => 101,
			")" => 166,
			'BITOROP' => 102,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103,
			'DOTDOT' => 104,
			'MULOP' => 105,
			'BITXOROP' => 106,
			'SHIFTOP' => 96,
			'OROR' => 107,
			'ANDAND' => 97,
			'RELOP' => 99,
			'EQOP' => 98
		}
	},
	{#State 125
		DEFAULT => -35
	},
	{#State 126
		ACTIONS => {
			";" => 168,
			"{" => 58
		},
		GOTOS => {
			'block' => 169,
			'subbody' => 167
		}
	},
	{#State 127
		ACTIONS => {
			'OROP' => 109,
			")" => 170,
			'ANDOP' => 108
		}
	},
	{#State 128
		DEFAULT => -82
	},
	{#State 129
		DEFAULT => -73
	},
	{#State 130
		ACTIONS => {
			'OROP' => 109,
			")" => 171,
			'ANDOP' => 108
		}
	},
	{#State 131
		DEFAULT => -90
	},
	{#State 132
		DEFAULT => -3,
		GOTOS => {
			'remember' => 172
		}
	},
	{#State 133
		ACTIONS => {
			"\$" => 19
		},
		GOTOS => {
			'scalar' => 173,
			'my_scalar' => 174
		}
	},
	{#State 134
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
			'mexpr' => 175,
			'scalar' => 6,
			'sideff' => 177,
			'term' => 43,
			'ary' => 14,
			'expr' => 178,
			'nexpr' => 179,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24,
			'arylen' => 48,
			'mnexpr' => 176,
			'amper' => 31,
			'myattrterm' => 32,
			'subscripted' => 33,
			'argexpr' => 51
		}
	},
	{#State 135
		DEFAULT => -84
	},
	{#State 136
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
			'expr' => 180,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 137
		ACTIONS => {
			")" => 181
		}
	},
	{#State 138
		ACTIONS => {
			'OROP' => 109,
			"," => 182,
			'ANDOP' => 108
		},
		DEFAULT => -108
	},
	{#State 139
		ACTIONS => {
			'ADDOP' => 100,
			'POSTINC' => 101,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103,
			'MULOP' => 105,
			'SHIFTOP' => 96,
			'EQOP' => 98,
			'RELOP' => 99
		},
		DEFAULT => -52
	},
	{#State 140
		ACTIONS => {
			'BITANDOP' => 92,
			'ADDOP' => 100,
			'ASSIGNOP' => 93,
			'POSTINC' => 101,
			'BITOROP' => 102,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103,
			'DOTDOT' => 104,
			'MULOP' => 105,
			'BITXOROP' => 106,
			'SHIFTOP' => 96,
			'OROR' => 107,
			'ANDAND' => 97,
			'EQOP' => 98,
			'RELOP' => 99
		},
		DEFAULT => -45
	},
	{#State 141
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 94,
			'POSTDEC' => 103
		},
		DEFAULT => -46
	},
	{#State 142
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 94,
			'POSTDEC' => 103
		},
		DEFAULT => -58
	},
	{#State 143
		ACTIONS => {
			'ADDOP' => 100,
			'POSTINC' => 101,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103,
			'MULOP' => 105
		},
		DEFAULT => -49
	},
	{#State 144
		ACTIONS => {
			'BITANDOP' => 92,
			'ADDOP' => 100,
			'POSTINC' => 101,
			'BITOROP' => 102,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103,
			'MULOP' => 105,
			'BITXOROP' => 106,
			'SHIFTOP' => 96,
			'EQOP' => 98,
			'RELOP' => 99
		},
		DEFAULT => -56
	},
	{#State 145
		ACTIONS => {
			'ADDOP' => 100,
			'POSTINC' => 101,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103,
			'MULOP' => 105,
			'SHIFTOP' => 96,
			'EQOP' => undef,
			'RELOP' => 99
		},
		DEFAULT => -51
	},
	{#State 146
		ACTIONS => {
			'ADDOP' => 100,
			'POSTINC' => 101,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103,
			'MULOP' => 105,
			'SHIFTOP' => 96,
			'RELOP' => undef
		},
		DEFAULT => -50
	},
	{#State 147
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103,
			'MULOP' => 105
		},
		DEFAULT => -48
	},
	{#State 148
		ACTIONS => {
			'BITANDOP' => 92,
			'ADDOP' => 100,
			'POSTINC' => 101,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103,
			'MULOP' => 105,
			'SHIFTOP' => 96,
			'EQOP' => 98,
			'RELOP' => 99
		},
		DEFAULT => -53
	},
	{#State 149
		ACTIONS => {
			'BITANDOP' => 92,
			'ADDOP' => 100,
			'POSTINC' => 101,
			'BITOROP' => 102,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103,
			'DOTDOT' => undef,
			'MULOP' => 105,
			'BITXOROP' => 106,
			'SHIFTOP' => 96,
			'OROR' => 107,
			'ANDAND' => 97,
			'EQOP' => 98,
			'RELOP' => 99
		},
		DEFAULT => -55
	},
	{#State 150
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103
		},
		DEFAULT => -47
	},
	{#State 151
		ACTIONS => {
			'BITANDOP' => 92,
			'ADDOP' => 100,
			'POSTINC' => 101,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103,
			'MULOP' => 105,
			'SHIFTOP' => 96,
			'EQOP' => 98,
			'RELOP' => 99
		},
		DEFAULT => -54
	},
	{#State 152
		ACTIONS => {
			'BITANDOP' => 92,
			'ADDOP' => 100,
			'POSTINC' => 101,
			'BITOROP' => 102,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103,
			'MULOP' => 105,
			'BITXOROP' => 106,
			'SHIFTOP' => 96,
			'ANDAND' => 97,
			'EQOP' => 98,
			'RELOP' => 99
		},
		DEFAULT => -57
	},
	{#State 153
		DEFAULT => -38
	},
	{#State 154
		ACTIONS => {
			'ANDOP' => 108
		},
		DEFAULT => -39
	},
	{#State 155
		ACTIONS => {
			'OROP' => 109,
			'ANDOP' => 108
		},
		DEFAULT => -15
	},
	{#State 156
		ACTIONS => {
			'OROP' => 109,
			'ANDOP' => 108
		},
		DEFAULT => -14
	},
	{#State 157
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
			'expr' => 185,
			'texpr' => 183,
			'termbinop' => 21,
			'mtexpr' => 184,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 158
		ACTIONS => {
			'BITANDOP' => 92,
			'ADDOP' => 100,
			'ASSIGNOP' => 93,
			'POSTINC' => 101,
			'BITOROP' => 102,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103,
			'DOTDOT' => 104,
			'MULOP' => 105,
			'BITXOROP' => 106,
			'SHIFTOP' => 96,
			'OROR' => 107,
			'ANDAND' => 97,
			'EQOP' => 98,
			'RELOP' => 99
		},
		DEFAULT => -42
	},
	{#State 159
		DEFAULT => -44
	},
	{#State 160
		ACTIONS => {
			"}" => 186,
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
	{#State 161
		DEFAULT => -100
	},
	{#State 162
		DEFAULT => -80
	},
	{#State 163
		ACTIONS => {
			")" => 187
		}
	},
	{#State 164
		ACTIONS => {
			'OROP' => 109,
			'ANDOP' => 108
		},
		DEFAULT => -29
	},
	{#State 165
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
			'term' => 188,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 166
		DEFAULT => -92
	},
	{#State 167
		DEFAULT => -33
	},
	{#State 168
		DEFAULT => -37
	},
	{#State 169
		DEFAULT => -36
	},
	{#State 170
		DEFAULT => -83
	},
	{#State 171
		DEFAULT => -91
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
			'mexpr' => 189,
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 164,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 173
		DEFAULT => -110
	},
	{#State 174
		ACTIONS => {
			"(" => 190
		}
	},
	{#State 175
		ACTIONS => {
			")" => 191
		}
	},
	{#State 176
		ACTIONS => {
			";" => 192
		}
	},
	{#State 177
		DEFAULT => -26
	},
	{#State 178
		ACTIONS => {
			'FOR' => 110,
			'OROP' => 109,
			")" => -29,
			'ANDOP' => 108,
			'WHILE' => 111
		},
		DEFAULT => -13
	},
	{#State 179
		DEFAULT => -30
	},
	{#State 180
		ACTIONS => {
			'OROP' => 109,
			")" => 193,
			'ANDOP' => 108
		}
	},
	{#State 181
		DEFAULT => -98
	},
	{#State 182
		DEFAULT => -109
	},
	{#State 183
		DEFAULT => -31
	},
	{#State 184
		ACTIONS => {
			")" => 194
		}
	},
	{#State 185
		ACTIONS => {
			'OROP' => 109,
			'ANDOP' => 108
		},
		DEFAULT => -28
	},
	{#State 186
		DEFAULT => -2
	},
	{#State 187
		ACTIONS => {
			"{" => 195
		},
		GOTOS => {
			'mblock' => 196
		}
	},
	{#State 188
		ACTIONS => {
			'BITANDOP' => 92,
			'ADDOP' => 100,
			'ASSIGNOP' => 93,
			'POSTINC' => 101,
			")" => 197,
			'BITOROP' => 102,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103,
			'DOTDOT' => 104,
			'MULOP' => 105,
			'BITXOROP' => 106,
			'SHIFTOP' => 96,
			'OROR' => 107,
			'ANDAND' => 97,
			'RELOP' => 99,
			'EQOP' => 98
		}
	},
	{#State 189
		ACTIONS => {
			")" => 198
		}
	},
	{#State 190
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
			'mexpr' => 199,
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 164,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 191
		ACTIONS => {
			"{" => 195
		},
		GOTOS => {
			'mblock' => 200
		}
	},
	{#State 192
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
			'expr' => 185,
			'texpr' => 183,
			'termbinop' => 21,
			'mtexpr' => 201,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 193
		DEFAULT => -96
	},
	{#State 194
		ACTIONS => {
			"{" => 195
		},
		GOTOS => {
			'mblock' => 202
		}
	},
	{#State 195
		DEFAULT => -5,
		GOTOS => {
			'mremember' => 203
		}
	},
	{#State 196
		ACTIONS => {
			'ELSE' => 204,
			'ELSIF' => 206
		},
		DEFAULT => -16,
		GOTOS => {
			'else' => 205
		}
	},
	{#State 197
		DEFAULT => -93
	},
	{#State 198
		ACTIONS => {
			"{" => 195
		},
		GOTOS => {
			'mblock' => 207
		}
	},
	{#State 199
		ACTIONS => {
			")" => 208
		}
	},
	{#State 200
		DEFAULT => -23
	},
	{#State 201
		ACTIONS => {
			";" => 209
		}
	},
	{#State 202
		DEFAULT => -20
	},
	{#State 203
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 210
		}
	},
	{#State 204
		ACTIONS => {
			"{" => 195
		},
		GOTOS => {
			'mblock' => 211
		}
	},
	{#State 205
		DEFAULT => -19
	},
	{#State 206
		ACTIONS => {
			"(" => 212
		}
	},
	{#State 207
		DEFAULT => -22
	},
	{#State 208
		ACTIONS => {
			"{" => 195
		},
		GOTOS => {
			'mblock' => 213
		}
	},
	{#State 209
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
			'sideff' => 177,
			'mnexpr' => 214,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 45,
			'nexpr' => 179,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 210
		ACTIONS => {
			"}" => 215,
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
	{#State 211
		DEFAULT => -17
	},
	{#State 212
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
			'mexpr' => 216,
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 164,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 213
		DEFAULT => -21
	},
	{#State 214
		ACTIONS => {
			")" => 217
		}
	},
	{#State 215
		DEFAULT => -4
	},
	{#State 216
		ACTIONS => {
			")" => 218
		}
	},
	{#State 217
		ACTIONS => {
			"{" => 195
		},
		GOTOS => {
			'mblock' => 219
		}
	},
	{#State 218
		ACTIONS => {
			"{" => 195
		},
		GOTOS => {
			'mblock' => 220
		}
	},
	{#State 219
		DEFAULT => -24
	},
	{#State 220
		ACTIONS => {
			'ELSE' => 204,
			'ELSIF' => 206
		},
		DEFAULT => -16,
		GOTOS => {
			'else' => 221
		}
	},
	{#State 221
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
#line 213 "plpy.yp"
{
                printer(\@_, "prog", "lineseq");
                return "$_[1]";
            }
	],
	[#Rule 2
		 'block', 4,
sub
#line 221 "plpy.yp"
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
#line 233 "plpy.yp"
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
#line 256 "plpy.yp"
{
                printer(\@_, qw( lineseq lineseq decl )); 
                return "$_[1]$_[2]";
            }
	],
	[#Rule 8
		 'lineseq', 2,
sub
#line 261 "plpy.yp"
{
                printer(\@_, "lineseq", "lineseq", "line");
                return "$_[1]$_[2]";
            }
	],
	[#Rule 9
		 'line', 1,
sub
#line 269 "plpy.yp"
{
                printer(\@_, qw( line cond )); 
                return $_[1];
            }
	],
	[#Rule 10
		 'line', 1,
sub
#line 275 "plpy.yp"
{
                printer(\@_, qw( line loop )); 
                return $_[1];
            }
	],
	[#Rule 11
		 'line', 2,
sub
#line 281 "plpy.yp"
{
                printer(\@_, "line", "sideff", "';'");
                return "$_[1]\n";
            }
	],
	[#Rule 12
		 'line', 1,
sub
#line 286 "plpy.yp"
{
                printer(\@_, "line", "COMMENT");
                return "$_[1]\n";
            }
	],
	[#Rule 13
		 'sideff', 1,
sub
#line 295 "plpy.yp"
{
                printer(\@_, "sideff", "expr");
                return $_[1];
            }
	],
	[#Rule 14
		 'sideff', 3,
sub
#line 300 "plpy.yp"
{
                printer(\@_, qw( sideff expr WHILE expr ));
                return "while $_[3]: $_[1]";
            }
	],
	[#Rule 15
		 'sideff', 3,
sub
#line 305 "plpy.yp"
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
#line 314 "plpy.yp"
{
                printer (\@_, qw( else ELSE mblock ));
                return "else:$_[2]";
            }
	],
	[#Rule 18
		 'else', 6,
sub
#line 319 "plpy.yp"
{
                printer (\@_, qw( else ELSIF '(' mexpr ')' mblock else)); 
                return "elif $_[3]:$_[5]$_[6]";
            }
	],
	[#Rule 19
		 'cond', 7,
sub
#line 327 "plpy.yp"
{
                printer (\@_, qw( IF '(' remember mexpr ')' mblock else));
                return "if $_[4]:$_[6]$_[7]";
                
            }
	],
	[#Rule 20
		 'loop', 6,
sub
#line 336 "plpy.yp"
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
#line 346 "plpy.yp"
{
                printer (\@_, qw(loop FOR MY remember my_scalar '(' mexpr ')' mblock cont)); 
                return "for $_[4] in $_[6]:$_[8]";
            }
	],
	[#Rule 22
		 'loop', 7,
sub
#line 351 "plpy.yp"
{
                printer (\@_, qw(loop FOR scalar '(' mexpr ')' mblock cont)); 
                return "for $_[2] in $_[5]:$_[7]";
            }
	],
	[#Rule 23
		 'loop', 6,
sub
#line 356 "plpy.yp"
{
                return "for _ in $_[4]:$_[6]";
            }
	],
	[#Rule 24
		 'loop', 10,
sub
#line 360 "plpy.yp"
{
                printer (\@_, qw(loop FOR '(' remember mnexpr ';' mtexpr ';' mnexpr ')' mblock)); 
                return "$_[4]\nwhile $_[6]:$_[10] hi   $_[8]\n";
            }
	],
	[#Rule 25
		 'nexpr', 0,
sub
#line 368 "plpy.yp"
{}
	],
	[#Rule 26
		 'nexpr', 1, undef
	],
	[#Rule 27
		 'texpr', 0,
sub
#line 374 "plpy.yp"
{}
	],
	[#Rule 28
		 'texpr', 1, undef
	],
	[#Rule 29
		 'mexpr', 1,
sub
#line 380 "plpy.yp"
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
#line 394 "plpy.yp"
{}
	],
	[#Rule 33
		 'subrout', 4,
sub
#line 399 "plpy.yp"
{
            }
	],
	[#Rule 34
		 'startsub', 0,
sub
#line 404 "plpy.yp"
{}
	],
	[#Rule 35
		 'subname', 1,
sub
#line 408 "plpy.yp"
{}
	],
	[#Rule 36
		 'subbody', 1,
sub
#line 412 "plpy.yp"
{}
	],
	[#Rule 37
		 'subbody', 1,
sub
#line 413 "plpy.yp"
{}
	],
	[#Rule 38
		 'expr', 3,
sub
#line 419 "plpy.yp"
{
                printer (\@_, qw(expr expr ANDOP expr)); 
                return "$_[1] and $_[3]";
            }
	],
	[#Rule 39
		 'expr', 3,
sub
#line 424 "plpy.yp"
{
                printer (\@_, qw(expr expr OROP expr)); 
                return "$_[1] or $_[3]";
            }
	],
	[#Rule 40
		 'expr', 1,
sub
#line 429 "plpy.yp"
{
                printer(\@_, qw(expr argexpr));
                return $_[1];
            }
	],
	[#Rule 41
		 'argexpr', 2,
sub
#line 437 "plpy.yp"
{
                printer (\@_, "argexpr", "','");
                return "$_[1], ";
            }
	],
	[#Rule 42
		 'argexpr', 3,
sub
#line 442 "plpy.yp"
{
                printer (\@_, "argexpr", "','", "term");
                return "$_[1], $_[3]";
            }
	],
	[#Rule 43
		 'argexpr', 1,
sub
#line 447 "plpy.yp"
{
                printer (\@_, "argexpr", "term");
                return $_[1];
            }
	],
	[#Rule 44
		 'subscripted', 4,
sub
#line 457 "plpy.yp"
{
                return "$_[1]$_[2]$_[3]$_[4]"; 
            }
	],
	[#Rule 45
		 'termbinop', 3,
sub
#line 464 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "ASSIGNOP", "term");
                if ($_[2] eq '.=') {$_[2] = '+='}
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 46
		 'termbinop', 3,
sub
#line 470 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "POWOP", "term");
                return "eval(str($_[1])) $_[2] eval(str($_[3]))";
            }
	],
	[#Rule 47
		 'termbinop', 3,
sub
#line 475 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "MULOP", "term");
                return "eval(str($_[1])) $_[2] eval(str($_[3]))";
            }
	],
	[#Rule 48
		 'termbinop', 3,
sub
#line 480 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "ADDOP", "term");
                if ($_[2] eq '.'){
                    return "$_[1] + $_[2]";
                }
                else{
                    return "eval(str($_[1])) $_[2] eval(str($_[3]))";
                }
            }
	],
	[#Rule 49
		 'termbinop', 3,
sub
#line 490 "plpy.yp"
{
                printer (\@_, qw(term SHIFTOP term)); 
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 50
		 'termbinop', 3,
sub
#line 495 "plpy.yp"
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
	[#Rule 51
		 'termbinop', 3,
sub
#line 507 "plpy.yp"
{
                printer (\@_, qw(termbinop term EQOP term)); 
                if ($_[2] eq 'eq') {$_[2] = '=='}
                if ($_[2] eq '<=>') {
                    return "((a > b) - (a < b))";
                }
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 52
		 'termbinop', 3,
sub
#line 516 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITANDOP term)); 
                return "$_[1] & $_[2]";
            }
	],
	[#Rule 53
		 'termbinop', 3,
sub
#line 521 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITOROP term)); 
                return "$_[1] | $_[2]";
            }
	],
	[#Rule 54
		 'termbinop', 3,
sub
#line 526 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITXOROP term)); 
                return "$_[1] ^ $_[2]";
            }
	],
	[#Rule 55
		 'termbinop', 3,
sub
#line 531 "plpy.yp"
{
                return "list(range($_[1], $_[3] + 1))";
            }
	],
	[#Rule 56
		 'termbinop', 3,
sub
#line 535 "plpy.yp"
{
                printer (\@_, qw(termbinop term ANDAND term)); 
                return "$_[1] and $_[3]";
            }
	],
	[#Rule 57
		 'termbinop', 3,
sub
#line 540 "plpy.yp"
{
                printer (\@_, qw(termbinop term OROR term)); 
                return "$_[1] or $_[3]";
            }
	],
	[#Rule 58
		 'termbinop', 3,
sub
#line 545 "plpy.yp"
{
                $_[0]->YYData->{"IMPORTS"}{"import re"} = 1; 
                if ($_[3] =~ /^s/){
                    $_[3] =~ /s\/((?<!\\)(?:\\\\)*.*?)\/((?<!\\)(?:\\\\)*.*?)\/([msixpodualngcer]?)/;
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
                    $_[3] =~ /s\/((?<!\\)(?:\\\\)*.*?)\/([imnsxadlup]?)/;
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
	[#Rule 59
		 'termunop', 2,
sub
#line 591 "plpy.yp"
{
                return "-$_[2]"; 
            }
	],
	[#Rule 60
		 'termunop', 2,
sub
#line 595 "plpy.yp"
{
                return $_[2]; 
            }
	],
	[#Rule 61
		 'termunop', 2,
sub
#line 599 "plpy.yp"
{
                printer (\@_, qw(termunop '!' term)); 
                return "not $_[2]";
            }
	],
	[#Rule 62
		 'termunop', 2,
sub
#line 604 "plpy.yp"
{
                printer (\@_, qw(termunop '~' term)); 
                return "~$_[2]";
            }
	],
	[#Rule 63
		 'termunop', 2,
sub
#line 609 "plpy.yp"
{
                printer (\@_, qw(termunop term POSTINC)); 
                return "$_[1] += 1";
            }
	],
	[#Rule 64
		 'termunop', 2,
sub
#line 614 "plpy.yp"
{
                printer (\@_, qw(termunop term POSTDEC)); 
                return "$_[1] -= 1";
            }
	],
	[#Rule 65
		 'term', 1, undef
	],
	[#Rule 66
		 'term', 1, undef
	],
	[#Rule 67
		 'term', 1,
sub
#line 623 "plpy.yp"
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
	[#Rule 68
		 'term', 1, undef
	],
	[#Rule 69
		 'term', 1, undef
	],
	[#Rule 70
		 'term', 1,
sub
#line 646 "plpy.yp"
{
                $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                $_[0]->YYData->{"PRELUDE"}{"sys.argv = sys.argv[1:]"} = 1; 
                return "sys.argv";
            }
	],
	[#Rule 71
		 'term', 1,
sub
#line 652 "plpy.yp"
{
                printer (\@_, "term", "STRING");
                $_[1] =~ s/^"\$(\w+)"/$1/;
                return $_[1];
            }
	],
	[#Rule 72
		 'term', 1,
sub
#line 659 "plpy.yp"
{}
	],
	[#Rule 73
		 'term', 3,
sub
#line 661 "plpy.yp"
{
                return $_[2];    
            }
	],
	[#Rule 74
		 'term', 2,
sub
#line 665 "plpy.yp"
{}
	],
	[#Rule 75
		 'term', 1,
sub
#line 667 "plpy.yp"
{
                printer (\@_, "term", "scalar");
                return $_[1];
            }
	],
	[#Rule 76
		 'term', 1,
sub
#line 672 "plpy.yp"
{}
	],
	[#Rule 77
		 'term', 1,
sub
#line 674 "plpy.yp"
{
                printer (\@_, qw(term ary)); 
                return $_[1];
            }
	],
	[#Rule 78
		 'term', 1, undef
	],
	[#Rule 79
		 'term', 1, undef
	],
	[#Rule 80
		 'term', 4,
sub
#line 681 "plpy.yp"
{
                return "$_[1]$_[2]$_[3]$_[4]"; 
            }
	],
	[#Rule 81
		 'term', 1,
sub
#line 685 "plpy.yp"
{}
	],
	[#Rule 82
		 'term', 3,
sub
#line 687 "plpy.yp"
{}
	],
	[#Rule 83
		 'term', 4,
sub
#line 689 "plpy.yp"
{}
	],
	[#Rule 84
		 'term', 3,
sub
#line 691 "plpy.yp"
{
                printer (\@_, qw(term NOAMP WORD listexpr)); 
            }
	],
	[#Rule 85
		 'term', 1,
sub
#line 695 "plpy.yp"
{
                if ($_[1] eq "last"){
                    return "break";
                }
                elsif ($_[1] eq "next"){
                    return "continue";
                }

            }
	],
	[#Rule 86
		 'term', 2,
sub
#line 705 "plpy.yp"
{
                printer (\@_, qw(term NOTOP argexpr)); 
                return "not $_[2]";
            }
	],
	[#Rule 87
		 'term', 1,
sub
#line 710 "plpy.yp"
{
                printer (\@_, qw(term UNIOP)); 
                if ($_[1] eq "exit"){
                   return "exit()";
                }
            }
	],
	[#Rule 88
		 'term', 2,
sub
#line 717 "plpy.yp"
{}
	],
	[#Rule 89
		 'term', 2,
sub
#line 719 "plpy.yp"
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
	[#Rule 90
		 'term', 3,
sub
#line 739 "plpy.yp"
{
                if ($_[1] eq "exit"){
                   return "exit()";
                }
            }
	],
	[#Rule 91
		 'term', 4,
sub
#line 745 "plpy.yp"
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
	[#Rule 92
		 'term', 4,
sub
#line 766 "plpy.yp"
{}
	],
	[#Rule 93
		 'term', 6,
sub
#line 768 "plpy.yp"
{
                $_[3] =~ s/\/(.*)\//$1/;
                #$_[3] =~ s/\\([\{\}\[\]\(\)\^\$\.\|\*\+\?\\])/$1/g;
                $_[3] =~ s/\\([\Q{}[]()^$.|*+?\\E])/$1/g;
                return "split($_[3], $_[5])";
            }
	],
	[#Rule 94
		 'term', 1, undef
	],
	[#Rule 95
		 'term', 3,
sub
#line 778 "plpy.yp"
{
                #sort goes here
                printer (\@_, "term", "LSTOP", "indirob", "argexpr");
            }
	],
	[#Rule 96
		 'term', 5,
sub
#line 783 "plpy.yp"
{
                #sort goes here
            }
	],
	[#Rule 97
		 'term', 2,
sub
#line 787 "plpy.yp"
{
                printer (\@_, "term", "LSTOP", "listexpr");

                if ($_[1] eq "printf"){
                    my @list;
                    my ($string, @args) = split(/"(?:\\"|""|\\\\|[^"])*"\K,\s*/, $_[2]);

                    my @matches = $string =~ /(?<!\\)(?:\\\\)*\K\$\w+|%[csduoxefgXEGi]/g;
                    foreach my $match (@matches){
                        if ($match =~ /\$\w+/){
                            $string =~ s/(?<!\\)(?:\\\\)*\K\$\w+/%s/;
                            my $var = $&;
                            $var =~ s/^[\$\@]//;
                            push(@list, $var);
                        }
                        elsif ($match =~ /%[csduoxefgXEGi]/){
                            push(@list, shift(@args));
                        }
                    }

                    # remove final newline
                    if ($string =~ s/^.*\K(?:,\s*"\\n"$)|(?:(?<!\\)\\n(?=\s*"$))//){ #"
                        return "print($string % (", join(', ', @list), "))";
                    }
                    else{
                        return "print($string % (", join(', ', @list), "), end='')";
                    }
                }
                elsif ($_[1] eq "print"){

                    my $new_line = 0;
                    if ($_[2] =~ s/^.*\K(?:,\s*"\\n"$)|(?:(?<!\\)\\n(?=\s*"$))//){
                        $new_line = 1; #"
                    }

                    my @printf; 
                    foreach my $string ( split(/"(?:\\"|""|\\\\|[^"])*"\K,\s*/, $_[2])){
                        if ($string =~ /(?<!\\)(?:\\\\)*\K\$\w+/){
                            my @list;
                            my @matches = $string =~ /(?<!\\)(?:\\\\)*\K\$\w+/g;
                            foreach my $match (@matches){
                                $string =~ s/(?<!\\)(?:\\\\)*\K\$\w+/%s/;
                                my $var = $&;
                                $var =~ s/^[\$\@]//;
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
                    #TODO
                    my $handle = shift @list;
                    my $mode = shift @list;
                    #return "$handle = open($array.insert(0, @list)";
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
	[#Rule 98
		 'term', 4,
sub
#line 888 "plpy.yp"
{
                if ($_[1] eq "printf"){
                    my @list;
                    my ($string, @args) = split(/"(?:\\"|""|\\\\|[^"])*"\K,\s*/, $_[2]);

                    my @matches = $string =~ /(?<!\\)(?:\\\\)*\K\$\w+|%[csduoxefgXEGi]/g;
                    foreach my $match (@matches){
                        if ($match =~ /\$\w+/){
                            $string =~ s/(?<!\\)(?:\\\\)*\K\$\w+/%s/;
                            my $var = $&;
                            $var =~ s/^[\$\@]//;
                            push(@list, $var);
                        }
                        elsif ($match =~ /%[csduoxefgXEGi]/){
                            push(@list, shift(@args));
                        }
                    }

                    # remove final newline
                    if ($string =~ s/^.*\K(?:,\s*"\\n"$)|(?:(?<!\\)\\n(?=\s*"$))//) #"
                    {
                        return "print($string % (", join(', ', @list), "))";
                    }
                    else{
                        return "print($string % (", join(', ', @list), "), end='')";
                    }
                }
                elsif ($_[1] eq "print"){

                    my $new_line = 0;
                    if ($_[2] =~ s/^.*\K(?:,\s*"\\n"$)|(?:(?<!\\)\\n(?=\s*"$))//) #"
                    {
                        $new_line = 1; 
                    }

                    my @printf; 
                    foreach my $string ( split(/"(?:\\"|""|\\\\|[^"])*"\K,\s*/, $_[2])){
                        if ($string =~ /(?<!\\)(?:\\\\)*\K\$\w+/){
                            my @list;
                            my @matches = $string =~ /(?<!\\)(?:\\\\)*\K\$\w+/g;
                            foreach my $match (@matches){
                                $string =~ s/(?<!\\)(?:\\\\)*\K\$\w+/%s/;
                                my $var = $&;
                                $var =~ s/^[\$\@]//;
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
                elsif ($_[1] eq "join") {
                    printer (\@_, "term", "LSTOP", "listexpr");
                    my @list = split(', ', $_[3]);
                    my $delim = shift @list;
                    return "$delim.join(@list)";
                }
            }
	],
	[#Rule 99
		 'myattrterm', 2,
sub
#line 963 "plpy.yp"
{
                return $_[2];
            }
	],
	[#Rule 100
		 'myterm', 3,
sub
#line 970 "plpy.yp"
{
                    return $_[2];
                }
	],
	[#Rule 101
		 'myterm', 2, undef
	],
	[#Rule 102
		 'myterm', 1, undef
	],
	[#Rule 103
		 'myterm', 1, undef
	],
	[#Rule 104
		 'myterm', 1, undef
	],
	[#Rule 105
		 'listexpr', 0,
sub
#line 982 "plpy.yp"
{print "empty listexpr\n";}
	],
	[#Rule 106
		 'listexpr', 1,
sub
#line 984 "plpy.yp"
{
                printer (\@_, "listexpr", "argexpr");
                return $_[1];
            }
	],
	[#Rule 107
		 'listexprcom', 0, undef
	],
	[#Rule 108
		 'listexprcom', 1,
sub
#line 993 "plpy.yp"
{
                printer (\@_, "listexprcom", "expr");
                return "$_[1]";
            }
	],
	[#Rule 109
		 'listexprcom', 2,
sub
#line 998 "plpy.yp"
{
                printer (\@_, "listexprcom", "expr", "','");
                return "$_[1], ";
            }
	],
	[#Rule 110
		 'my_scalar', 1, undef
	],
	[#Rule 111
		 'amper', 2, undef
	],
	[#Rule 112
		 'scalar', 2,
sub
#line 1014 "plpy.yp"
{
                printer (\@_, "scalar", "'\$'", "indirob"); 
                return "$_[2]";
            }
	],
	[#Rule 113
		 'ary', 2,
sub
#line 1021 "plpy.yp"
{
                printer (\@_, "scalar", "'\@'", "indirob"); 
                return $_[2];
            }
	],
	[#Rule 114
		 'hsh', 2,
sub
#line 1027 "plpy.yp"
{return $_[2];}
	],
	[#Rule 115
		 'arylen', 2,
sub
#line 1030 "plpy.yp"
{return "len($_[2]) - 1";}
	],
	[#Rule 116
		 'indirob', 1,
sub
#line 1035 "plpy.yp"
{
                printer (\@_, "indirob", "WORD");
                return $_[1];
            }
	],
	[#Rule 117
		 'indirob', 1,
sub
#line 1040 "plpy.yp"
{
                $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                $_[0]->YYData->{"PRELUDE"}{"sys.argv = sys.argv[1:]"} = 1; 
                return "sys.argv";
            }
	],
	[#Rule 118
		 'indirob', 1, undef
	],
	[#Rule 119
		 'indirob', 1,
sub
#line 1047 "plpy.yp"
{printer (\@_, qw(indirob indexblock));}
	]
],
                                  @_);
    bless($self,$class);
}

#line 1050 "plpy.yp"


1;
