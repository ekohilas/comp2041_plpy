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
        ["RESUB", qr/s\/(?:(?:[^\/\\]|\\.|\\\\)*\/){2}[msixpodualngcer]?/],
        ["REMATCH", qr/m?\/(?:[^\/\\]|\\.|\\\\)*\/[imnsxadlup]?/],
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
    my $word_string = shift(@words)." => ";
    $word_string .= join(" -> ", @words);
    my $token_string = "$words[0]"." => ";
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
		DEFAULT => -7,
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
		DEFAULT => -96
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
		DEFAULT => -77
	},
	{#State 7
		ACTIONS => {
			'WORD' => 55,
			'ARGV' => 57,
			"\$" => 19,
			"{" => 59
		},
		GOTOS => {
			'scalar' => 54,
			'indexblock' => 58,
			'indirob' => 56
		}
	},
	{#State 8
		DEFAULT => -70
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
			"{" => 59
		},
		GOTOS => {
			'scalar' => 54,
			'indexblock' => 58,
			'indirob' => 61
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
		DEFAULT => -13
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
			"{" => 59
		},
		DEFAULT => -107,
		GOTOS => {
			'scalar' => 68,
			'arylen' => 48,
			'indirob' => 69,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'indexblock' => 58,
			'termbinop' => 21,
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
		DEFAULT => -79
	},
	{#State 15
		DEFAULT => -11
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
		DEFAULT => -69
	},
	{#State 18
		DEFAULT => -8
	},
	{#State 19
		ACTIONS => {
			'WORD' => 55,
			'ARGV' => 57,
			"\$" => 19,
			"{" => 59
		},
		GOTOS => {
			'scalar' => 54,
			'indexblock' => 58,
			'indirob' => 75
		}
	},
	{#State 20
		ACTIONS => {
			"(" => 76
		}
	},
	{#State 21
		DEFAULT => -67
	},
	{#State 22
		DEFAULT => -71
	},
	{#State 23
		DEFAULT => -78
	},
	{#State 24
		DEFAULT => -68
	},
	{#State 25
		DEFAULT => -9
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
		DEFAULT => -10
	},
	{#State 29
		DEFAULT => -72
	},
	{#State 30
		DEFAULT => -36,
		GOTOS => {
			'startsub' => 79
		}
	},
	{#State 31
		ACTIONS => {
			"(" => 80
		},
		DEFAULT => -83
	},
	{#State 32
		DEFAULT => -74
	},
	{#State 33
		DEFAULT => -81
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
		DEFAULT => -34
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
			"{" => 59
		},
		GOTOS => {
			'scalar' => 54,
			'indexblock' => 58,
			'indirob' => 90
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
		DEFAULT => -45
	},
	{#State 44
		DEFAULT => -73
	},
	{#State 45
		ACTIONS => {
			'FOR' => 111,
			'OROP' => 110,
			'ANDOP' => 108,
			'IF' => 109,
			'WHILE' => 112
		},
		DEFAULT => -14
	},
	{#State 46
		DEFAULT => -87
	},
	{#State 47
		ACTIONS => {
			"(" => 113
		}
	},
	{#State 48
		DEFAULT => -80
	},
	{#State 49
		ACTIONS => {
			'WORD' => 55,
			'ARGV' => 57,
			"\$" => 19,
			"{" => 59
		},
		GOTOS => {
			'scalar' => 54,
			'indexblock' => 58,
			'indirob' => 114
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
			"{" => 116
		},
		DEFAULT => -89,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 115,
			'ary' => 14,
			'termbinop' => 21,
			'block' => 117,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 51
		ACTIONS => {
			"," => 118
		},
		DEFAULT => -42
	},
	{#State 52
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 94,
			'POSTDEC' => 103
		},
		DEFAULT => -61
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
			'expr' => 119,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 54
		DEFAULT => -120
	},
	{#State 55
		DEFAULT => -118
	},
	{#State 56
		DEFAULT => -115
	},
	{#State 57
		DEFAULT => -119
	},
	{#State 58
		DEFAULT => -121
	},
	{#State 59
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
			'sideff' => 120,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 45,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 60
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 94,
			'POSTDEC' => 103
		},
		DEFAULT => -64
	},
	{#State 61
		DEFAULT => -116
	},
	{#State 62
		DEFAULT => -104
	},
	{#State 63
		DEFAULT => -106
	},
	{#State 64
		DEFAULT => -105
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
			")" => 122,
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
	{#State 66
		DEFAULT => -101
	},
	{#State 67
		ACTIONS => {
			"-" => -118,
			'WORD' => -118,
			"\@" => -118,
			'REMATCH' => -118,
			"~" => -118,
			"%" => -118,
			'MY' => -118,
			'LSTOP' => -118,
			"!" => -118,
			'FHANDLE' => -118,
			"\$" => -118,
			'RESUB' => -118,
			'PMFUNC' => -118,
			'NOTOP' => -118,
			'ARGV' => -118,
			"(" => -118,
			'FUNC1' => -118,
			"+" => -118,
			'NOAMP' => -118,
			'DOLSHARP' => -118,
			'STRING' => -118,
			'FUNC' => -118,
			'LOOPEX' => -118,
			'UNIOP' => -118,
			"&" => -118
		},
		DEFAULT => -96
	},
	{#State 68
		ACTIONS => {
			"-" => -120,
			'WORD' => -120,
			"\@" => -120,
			'REMATCH' => -120,
			"~" => -120,
			"%" => -120,
			'MY' => -120,
			'LSTOP' => -120,
			"!" => -120,
			'FHANDLE' => -120,
			"\$" => -120,
			'RESUB' => -120,
			"[" => 53,
			'PMFUNC' => -120,
			'NOTOP' => -120,
			'ARGV' => -120,
			"(" => -120,
			'FUNC1' => -120,
			"+" => -120,
			'NOAMP' => -120,
			'DOLSHARP' => -120,
			'STRING' => -120,
			'FUNC' => -120,
			'LOOPEX' => -120,
			'UNIOP' => -120,
			"&" => -120
		},
		DEFAULT => -77
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
			'argexpr' => 123,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 70
		ACTIONS => {
			"-" => -119,
			'WORD' => -119,
			"\@" => -119,
			'REMATCH' => -119,
			"~" => -119,
			"%" => -119,
			'MY' => -119,
			'LSTOP' => -119,
			"!" => -119,
			'FHANDLE' => -119,
			"\$" => -119,
			'RESUB' => -119,
			'PMFUNC' => -119,
			'NOTOP' => -119,
			'ARGV' => -119,
			"(" => -119,
			'FUNC1' => -119,
			"+" => -119,
			'NOAMP' => -119,
			'DOLSHARP' => -119,
			'STRING' => -119,
			'FUNC' => -119,
			'LOOPEX' => -119,
			'UNIOP' => -119,
			"&" => -119
		},
		DEFAULT => -72
	},
	{#State 71
		DEFAULT => -99
	},
	{#State 72
		ACTIONS => {
			"," => 118
		},
		DEFAULT => -108
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
			'expr' => 124,
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
		DEFAULT => -63
	},
	{#State 75
		DEFAULT => -114
	},
	{#State 76
		DEFAULT => -3,
		GOTOS => {
			'remember' => 125
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
			'term' => 126,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 78
		ACTIONS => {
			"," => 118
		},
		DEFAULT => -88
	},
	{#State 79
		ACTIONS => {
			'WORD' => 127
		},
		GOTOS => {
			'subname' => 128
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
			")" => 130,
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
			'expr' => 129,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 81
		ACTIONS => {
			'OROP' => 110,
			")" => 131,
			'ANDOP' => 108
		}
	},
	{#State 82
		DEFAULT => -76
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
			")" => 133,
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
			'expr' => 132,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 84
		DEFAULT => -12
	},
	{#State 85
		ACTIONS => {
			"(" => 134
		}
	},
	{#State 86
		DEFAULT => -3,
		GOTOS => {
			'remember' => 135
		}
	},
	{#State 87
		DEFAULT => -3,
		GOTOS => {
			'remember' => 136
		}
	},
	{#State 88
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 94,
			'POSTDEC' => 103
		},
		DEFAULT => -62
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
		DEFAULT => -107,
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
			'listexpr' => 137,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 90
		DEFAULT => -117
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
			"{" => 59,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 34,
			'FUNC1' => 35
		},
		DEFAULT => -109,
		GOTOS => {
			'scalar' => 68,
			'arylen' => 48,
			'indirob' => 138,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'indexblock' => 58,
			'expr' => 140,
			'termbinop' => 21,
			'listexprcom' => 139,
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
			'term' => 141,
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
			'term' => 142,
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
			'term' => 143,
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
			'term' => 144,
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
			'term' => 145,
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
			'term' => 146,
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
			'term' => 147,
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
			'term' => 148,
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
			'term' => 149,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 101
		DEFAULT => -65
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
			'term' => 150,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 103
		DEFAULT => -66
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
			'term' => 151,
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
			'term' => 152,
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
			'term' => 153,
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
			'term' => 154,
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
			'expr' => 155,
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
			'expr' => 156,
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
			'expr' => 157,
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
			'expr' => 158,
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
			'expr' => 159,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 113
		DEFAULT => -3,
		GOTOS => {
			'remember' => 160
		}
	},
	{#State 114
		DEFAULT => -113
	},
	{#State 115
		ACTIONS => {
			'ADDOP' => 100,
			'POSTINC' => 101,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103,
			'MULOP' => 105,
			'SHIFTOP' => 96
		},
		DEFAULT => -91
	},
	{#State 116
		DEFAULT => -3,
		GOTOS => {
			'remember' => 161
		}
	},
	{#State 117
		DEFAULT => -90
	},
	{#State 118
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
		DEFAULT => -43,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
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
	{#State 119
		ACTIONS => {
			'OROP' => 110,
			"]" => 163,
			'ANDOP' => 108
		}
	},
	{#State 120
		ACTIONS => {
			"}" => 164
		}
	},
	{#State 121
		ACTIONS => {
			'OROP' => 110,
			")" => 165,
			'ANDOP' => 108
		}
	},
	{#State 122
		DEFAULT => -103
	},
	{#State 123
		ACTIONS => {
			"," => 118
		},
		DEFAULT => -97
	},
	{#State 124
		ACTIONS => {
			'OROP' => 110,
			"]" => 166,
			'ANDOP' => 108
		}
	},
	{#State 125
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
			'mexpr' => 167,
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 168,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 126
		ACTIONS => {
			'BITANDOP' => 92,
			'ADDOP' => 100,
			"," => 169,
			'ASSIGNOP' => 93,
			'POSTINC' => 101,
			")" => 170,
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
	{#State 127
		DEFAULT => -37
	},
	{#State 128
		ACTIONS => {
			";" => 172,
			"{" => 116
		},
		GOTOS => {
			'block' => 173,
			'subbody' => 171
		}
	},
	{#State 129
		ACTIONS => {
			'OROP' => 110,
			")" => 174,
			'ANDOP' => 108
		}
	},
	{#State 130
		DEFAULT => -84
	},
	{#State 131
		DEFAULT => -75
	},
	{#State 132
		ACTIONS => {
			'OROP' => 110,
			")" => 175,
			'ANDOP' => 108
		}
	},
	{#State 133
		DEFAULT => -92
	},
	{#State 134
		DEFAULT => -3,
		GOTOS => {
			'remember' => 176
		}
	},
	{#State 135
		ACTIONS => {
			"\$" => 19
		},
		GOTOS => {
			'scalar' => 177,
			'my_scalar' => 178
		}
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
		DEFAULT => -27,
		GOTOS => {
			'mexpr' => 179,
			'scalar' => 6,
			'sideff' => 181,
			'term' => 43,
			'ary' => 14,
			'expr' => 182,
			'nexpr' => 183,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24,
			'arylen' => 48,
			'mnexpr' => 180,
			'amper' => 31,
			'myattrterm' => 32,
			'subscripted' => 33,
			'argexpr' => 51
		}
	},
	{#State 137
		DEFAULT => -86
	},
	{#State 138
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
			'expr' => 184,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 139
		ACTIONS => {
			")" => 185
		}
	},
	{#State 140
		ACTIONS => {
			'OROP' => 110,
			"," => 186,
			'ANDOP' => 108
		},
		DEFAULT => -110
	},
	{#State 141
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
		DEFAULT => -54
	},
	{#State 142
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
		DEFAULT => -47
	},
	{#State 143
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 94,
			'POSTDEC' => 103
		},
		DEFAULT => -48
	},
	{#State 144
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 94,
			'POSTDEC' => 103
		},
		DEFAULT => -60
	},
	{#State 145
		ACTIONS => {
			'ADDOP' => 100,
			'POSTINC' => 101,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103,
			'MULOP' => 105
		},
		DEFAULT => -51
	},
	{#State 146
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
		DEFAULT => -58
	},
	{#State 147
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
		DEFAULT => -53
	},
	{#State 148
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
		DEFAULT => -52
	},
	{#State 149
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103,
			'MULOP' => 105
		},
		DEFAULT => -50
	},
	{#State 150
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
		DEFAULT => -55
	},
	{#State 151
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
		DEFAULT => -57
	},
	{#State 152
		ACTIONS => {
			'POSTINC' => 101,
			'POWOP' => 94,
			'MATCHOP' => 95,
			'POSTDEC' => 103
		},
		DEFAULT => -49
	},
	{#State 153
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
		DEFAULT => -56
	},
	{#State 154
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
		DEFAULT => -59
	},
	{#State 155
		DEFAULT => -40
	},
	{#State 156
		ACTIONS => {
			'OROP' => 110,
			'ANDOP' => 108
		},
		DEFAULT => -15
	},
	{#State 157
		ACTIONS => {
			'ANDOP' => 108
		},
		DEFAULT => -41
	},
	{#State 158
		ACTIONS => {
			'OROP' => 110,
			'ANDOP' => 108
		},
		DEFAULT => -17
	},
	{#State 159
		ACTIONS => {
			'OROP' => 110,
			'ANDOP' => 108
		},
		DEFAULT => -16
	},
	{#State 160
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
		DEFAULT => -29,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 189,
			'texpr' => 187,
			'termbinop' => 21,
			'mtexpr' => 188,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 161
		DEFAULT => -7,
		GOTOS => {
			'lineseq' => 190
		}
	},
	{#State 162
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
		DEFAULT => -44
	},
	{#State 163
		DEFAULT => -46
	},
	{#State 164
		DEFAULT => -6
	},
	{#State 165
		DEFAULT => -102
	},
	{#State 166
		DEFAULT => -82
	},
	{#State 167
		ACTIONS => {
			")" => 191
		}
	},
	{#State 168
		ACTIONS => {
			'OROP' => 110,
			'ANDOP' => 108
		},
		DEFAULT => -31
	},
	{#State 169
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
			'term' => 192,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 170
		DEFAULT => -94
	},
	{#State 171
		DEFAULT => -35
	},
	{#State 172
		DEFAULT => -39
	},
	{#State 173
		DEFAULT => -38
	},
	{#State 174
		DEFAULT => -85
	},
	{#State 175
		DEFAULT => -93
	},
	{#State 176
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
			'mexpr' => 193,
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 168,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 177
		DEFAULT => -112
	},
	{#State 178
		ACTIONS => {
			"(" => 194
		}
	},
	{#State 179
		ACTIONS => {
			")" => 195
		}
	},
	{#State 180
		ACTIONS => {
			";" => 196
		}
	},
	{#State 181
		DEFAULT => -28
	},
	{#State 182
		ACTIONS => {
			'FOR' => 111,
			'OROP' => 110,
			'ANDOP' => 108,
			'IF' => 109,
			")" => -31,
			'WHILE' => 112
		},
		DEFAULT => -14
	},
	{#State 183
		DEFAULT => -32
	},
	{#State 184
		ACTIONS => {
			'OROP' => 110,
			")" => 197,
			'ANDOP' => 108
		}
	},
	{#State 185
		DEFAULT => -100
	},
	{#State 186
		DEFAULT => -111
	},
	{#State 187
		DEFAULT => -33
	},
	{#State 188
		ACTIONS => {
			")" => 198
		}
	},
	{#State 189
		ACTIONS => {
			'OROP' => 110,
			'ANDOP' => 108
		},
		DEFAULT => -30
	},
	{#State 190
		ACTIONS => {
			"}" => 199,
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
	{#State 191
		ACTIONS => {
			"{" => 200
		},
		GOTOS => {
			'mblock' => 201
		}
	},
	{#State 192
		ACTIONS => {
			'BITANDOP' => 92,
			'ADDOP' => 100,
			'ASSIGNOP' => 93,
			'POSTINC' => 101,
			")" => 202,
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
	{#State 193
		ACTIONS => {
			")" => 203
		}
	},
	{#State 194
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
			'mexpr' => 204,
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 168,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 195
		ACTIONS => {
			"{" => 200
		},
		GOTOS => {
			'mblock' => 205
		}
	},
	{#State 196
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
		DEFAULT => -29,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 189,
			'texpr' => 187,
			'termbinop' => 21,
			'mtexpr' => 206,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 197
		DEFAULT => -98
	},
	{#State 198
		ACTIONS => {
			"{" => 200
		},
		GOTOS => {
			'mblock' => 207
		}
	},
	{#State 199
		DEFAULT => -2
	},
	{#State 200
		DEFAULT => -5,
		GOTOS => {
			'mremember' => 208
		}
	},
	{#State 201
		ACTIONS => {
			'ELSE' => 209,
			'ELSIF' => 211
		},
		DEFAULT => -18,
		GOTOS => {
			'else' => 210
		}
	},
	{#State 202
		DEFAULT => -95
	},
	{#State 203
		ACTIONS => {
			"{" => 200
		},
		GOTOS => {
			'mblock' => 212
		}
	},
	{#State 204
		ACTIONS => {
			")" => 213
		}
	},
	{#State 205
		DEFAULT => -25
	},
	{#State 206
		ACTIONS => {
			";" => 214
		}
	},
	{#State 207
		DEFAULT => -22
	},
	{#State 208
		DEFAULT => -7,
		GOTOS => {
			'lineseq' => 215
		}
	},
	{#State 209
		ACTIONS => {
			"{" => 200
		},
		GOTOS => {
			'mblock' => 216
		}
	},
	{#State 210
		DEFAULT => -21
	},
	{#State 211
		ACTIONS => {
			"(" => 217
		}
	},
	{#State 212
		DEFAULT => -24
	},
	{#State 213
		ACTIONS => {
			"{" => 200
		},
		GOTOS => {
			'mblock' => 218
		}
	},
	{#State 214
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
			'sideff' => 181,
			'mnexpr' => 219,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 45,
			'nexpr' => 183,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 215
		ACTIONS => {
			"}" => 220,
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
	{#State 216
		DEFAULT => -19
	},
	{#State 217
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
			'mexpr' => 221,
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 168,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 218
		DEFAULT => -23
	},
	{#State 219
		ACTIONS => {
			")" => 222
		}
	},
	{#State 220
		DEFAULT => -4
	},
	{#State 221
		ACTIONS => {
			")" => 223
		}
	},
	{#State 222
		ACTIONS => {
			"{" => 200
		},
		GOTOS => {
			'mblock' => 224
		}
	},
	{#State 223
		ACTIONS => {
			"{" => 200
		},
		GOTOS => {
			'mblock' => 225
		}
	},
	{#State 224
		DEFAULT => -26
	},
	{#State 225
		ACTIONS => {
			'ELSE' => 209,
			'ELSIF' => 211
		},
		DEFAULT => -18,
		GOTOS => {
			'else' => 226
		}
	},
	{#State 226
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
		 'indexblock', 3,
sub
#line 244 "plpy.yp"
{
                printer(\@_, qw( indexblock { sideff } )); 
                return "[$_[3]]";
            }
	],
	[#Rule 7
		 'lineseq', 0, undef
	],
	[#Rule 8
		 'lineseq', 2,
sub
#line 253 "plpy.yp"
{
                printer(\@_, qw( lineseq lineseq decl )); 
                return "$_[1]$_[2]";
            }
	],
	[#Rule 9
		 'lineseq', 2,
sub
#line 258 "plpy.yp"
{
                printer(\@_, "lineseq", "lineseq", "line");
                return "$_[1]$_[2]";
            }
	],
	[#Rule 10
		 'line', 1,
sub
#line 266 "plpy.yp"
{
                printer(\@_, qw( line cond )); 
                return $_[1];
            }
	],
	[#Rule 11
		 'line', 1,
sub
#line 272 "plpy.yp"
{
                printer(\@_, qw( line loop )); 
                return $_[1];
            }
	],
	[#Rule 12
		 'line', 2,
sub
#line 278 "plpy.yp"
{
                printer(\@_, "line", "sideff", "';'");
                return "$_[1]\n";
            }
	],
	[#Rule 13
		 'line', 1,
sub
#line 283 "plpy.yp"
{
                printer(\@_, "line", "COMMENT");
                return "$_[1]\n";
            }
	],
	[#Rule 14
		 'sideff', 1,
sub
#line 292 "plpy.yp"
{
                printer(\@_, "sideff", "expr");
                return $_[1];
            }
	],
	[#Rule 15
		 'sideff', 3,
sub
#line 298 "plpy.yp"
{
                printer(\@_, qw( sideff expr IF expr ));
                return "if $_[3]: $_[1]";
            }
	],
	[#Rule 16
		 'sideff', 3,
sub
#line 303 "plpy.yp"
{
                printer(\@_, qw( sideff expr WHILE expr ));
                return "$_[1] while $_[3]";
            }
	],
	[#Rule 17
		 'sideff', 3,
sub
#line 308 "plpy.yp"
{
                printer (\@_, qw(sideff expr FOR expr));
                return "$_[1] for $_[3]";
            }
	],
	[#Rule 18
		 'else', 0, undef
	],
	[#Rule 19
		 'else', 2,
sub
#line 317 "plpy.yp"
{
                printer (\@_, qw( else ELSE mblock ));
                return "else:$_[2]";
            }
	],
	[#Rule 20
		 'else', 6,
sub
#line 322 "plpy.yp"
{
                printer (\@_, qw( else ELSIF '(' mexpr ')' mblock else)); 
                return "elif $_[3]:$_[5]$_[6]";
            }
	],
	[#Rule 21
		 'cond', 7,
sub
#line 330 "plpy.yp"
{
                printer (\@_, qw( IF '(' remember mexpr ')' mblock else));
                return "if $_[4]:$_[6]$_[7]";
                
            }
	],
	[#Rule 22
		 'loop', 6,
sub
#line 339 "plpy.yp"
{
                 printer (\@_, qw(WHILE '(' remember mtexpr ')' mblock cont)); 
                 return "while $_[4]:$_[6]$_[7]";
            }
	],
	[#Rule 23
		 'loop', 8,
sub
#line 344 "plpy.yp"
{
                printer (\@_, qw(loop FOR MY remember my_scalar '(' mexpr ')' mblock cont)); 
                return "for $_[4] in $_[6]:$_[8]";
            }
	],
	[#Rule 24
		 'loop', 7,
sub
#line 349 "plpy.yp"
{
                printer (\@_, qw(loop FOR scalar '(' mexpr ')' mblock cont)); 
                return "for $_[2] in $_[5]:$_[7]";
            }
	],
	[#Rule 25
		 'loop', 6,
sub
#line 354 "plpy.yp"
{
                return "for _ in $_[4]:$_[6]";
            }
	],
	[#Rule 26
		 'loop', 10,
sub
#line 358 "plpy.yp"
{
                printer (\@_, qw(loop FOR '(' remember mnexpr ';' mtexpr ';' mnexpr ')' mblock)); 
                return "$_[4]\nwhile $_[6]:$_[10] hi   $_[8]\n";
            }
	],
	[#Rule 27
		 'nexpr', 0,
sub
#line 366 "plpy.yp"
{}
	],
	[#Rule 28
		 'nexpr', 1, undef
	],
	[#Rule 29
		 'texpr', 0,
sub
#line 372 "plpy.yp"
{}
	],
	[#Rule 30
		 'texpr', 1, undef
	],
	[#Rule 31
		 'mexpr', 1,
sub
#line 378 "plpy.yp"
{
                printer (\@_, qw(mexpr expr) ); 
                return $_[1];
            }
	],
	[#Rule 32
		 'mnexpr', 1, undef
	],
	[#Rule 33
		 'mtexpr', 1, undef
	],
	[#Rule 34
		 'decl', 1,
sub
#line 392 "plpy.yp"
{}
	],
	[#Rule 35
		 'subrout', 4,
sub
#line 397 "plpy.yp"
{
            }
	],
	[#Rule 36
		 'startsub', 0,
sub
#line 402 "plpy.yp"
{}
	],
	[#Rule 37
		 'subname', 1,
sub
#line 406 "plpy.yp"
{}
	],
	[#Rule 38
		 'subbody', 1,
sub
#line 410 "plpy.yp"
{}
	],
	[#Rule 39
		 'subbody', 1,
sub
#line 411 "plpy.yp"
{}
	],
	[#Rule 40
		 'expr', 3,
sub
#line 417 "plpy.yp"
{
                printer (\@_, qw(expr expr ANDOP expr)); 
                return "$_[1] and $_[3]";
            }
	],
	[#Rule 41
		 'expr', 3,
sub
#line 422 "plpy.yp"
{
                printer (\@_, qw(expr expr OROP expr)); 
                return "$_[1] or $_[3]";
            }
	],
	[#Rule 42
		 'expr', 1,
sub
#line 427 "plpy.yp"
{
                printer(\@_, qw(expr argexpr));
                return $_[1];
            }
	],
	[#Rule 43
		 'argexpr', 2,
sub
#line 435 "plpy.yp"
{
                printer (\@_, "argexpr", "','");
                return "$_[1], ";
            }
	],
	[#Rule 44
		 'argexpr', 3,
sub
#line 440 "plpy.yp"
{
                printer (\@_, "argexpr", "','", "term");
                return "$_[1], $_[3]";
            }
	],
	[#Rule 45
		 'argexpr', 1,
sub
#line 445 "plpy.yp"
{
                printer (\@_, "argexpr", "term");
                return $_[1];
            }
	],
	[#Rule 46
		 'subscripted', 4,
sub
#line 455 "plpy.yp"
{
                return "$_[1]$_[2]$_[3]$_[4]"; 
            }
	],
	[#Rule 47
		 'termbinop', 3,
sub
#line 462 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "ASSIGNOP", "term");
                if ($_[2] eq '.=') {$_[2] = '+='}
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 48
		 'termbinop', 3,
sub
#line 468 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "POWOP", "term");
                return "eval(str($_[1])) $_[2] eval(str($_[3]))";
            }
	],
	[#Rule 49
		 'termbinop', 3,
sub
#line 473 "plpy.yp"
{
                printer (\@_, "termbinop", "term", "MULOP", "term");
                return "eval(str($_[1])) $_[2] eval(str($_[3]))";
            }
	],
	[#Rule 50
		 'termbinop', 3,
sub
#line 478 "plpy.yp"
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
	[#Rule 51
		 'termbinop', 3,
sub
#line 488 "plpy.yp"
{
                printer (\@_, qw(term SHIFTOP term)); 
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 52
		 'termbinop', 3,
sub
#line 493 "plpy.yp"
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
	[#Rule 53
		 'termbinop', 3,
sub
#line 505 "plpy.yp"
{
                printer (\@_, qw(termbinop term EQOP term)); 
                if ($_[2] eq 'eq') {$_[2] = '=='}
                if ($_[2] eq '<=>') {
                    return "((a > b) - (a < b))";
                }
                return "$_[1] $_[2] $_[3]";
            }
	],
	[#Rule 54
		 'termbinop', 3,
sub
#line 514 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITANDOP term)); 
                return "$_[1] & $_[2]";
            }
	],
	[#Rule 55
		 'termbinop', 3,
sub
#line 519 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITOROP term)); 
                return "$_[1] | $_[2]";
            }
	],
	[#Rule 56
		 'termbinop', 3,
sub
#line 524 "plpy.yp"
{
                printer (\@_, qw(termbinop term BITXOROP term)); 
                return "$_[1] ^ $_[2]";
            }
	],
	[#Rule 57
		 'termbinop', 3,
sub
#line 529 "plpy.yp"
{
                return "list(range($_[1], $_[3] + 1))";
            }
	],
	[#Rule 58
		 'termbinop', 3,
sub
#line 533 "plpy.yp"
{
                printer (\@_, qw(termbinop term ANDAND term)); 
                return "$_[1] and $_[3]";
            }
	],
	[#Rule 59
		 'termbinop', 3,
sub
#line 538 "plpy.yp"
{
                printer (\@_, qw(termbinop term OROR term)); 
                return "$_[1] or $_[3]";
            }
	],
	[#Rule 60
		 'termbinop', 3,
sub
#line 543 "plpy.yp"
{
                $_[0]->YYData->{"IMPORTS"}{"import re"} = 1; 
                $_[3] =~ /s\/((?:[^\/\\]|\\\/|\\\\)*)\/((?:[^\/\\]|\\\/|\\\\)*)\/([msixpodualngcer]?)/;
                return "$_[1] = re.sub(r'$1', $_[1])";
            }
	],
	[#Rule 61
		 'termunop', 2,
sub
#line 552 "plpy.yp"
{
                return "-$_[2]"; 
            }
	],
	[#Rule 62
		 'termunop', 2,
sub
#line 556 "plpy.yp"
{
                return $_[2]; 
            }
	],
	[#Rule 63
		 'termunop', 2,
sub
#line 560 "plpy.yp"
{
                printer (\@_, qw(termunop '!' term)); 
                return "not $_[2]";
            }
	],
	[#Rule 64
		 'termunop', 2,
sub
#line 565 "plpy.yp"
{
                printer (\@_, qw(termunop '~' term)); 
                return "~$_[2]";
            }
	],
	[#Rule 65
		 'termunop', 2,
sub
#line 570 "plpy.yp"
{
                printer (\@_, qw(termunop term POSTINC)); 
                return "$_[1] += 1";
            }
	],
	[#Rule 66
		 'termunop', 2,
sub
#line 575 "plpy.yp"
{
                printer (\@_, qw(termunop term POSTDEC)); 
                return "$_[1] -= 1";
            }
	],
	[#Rule 67
		 'term', 1, undef
	],
	[#Rule 68
		 'term', 1, undef
	],
	[#Rule 69
		 'term', 1, undef
	],
	[#Rule 70
		 'term', 1, undef
	],
	[#Rule 71
		 'term', 1,
sub
#line 586 "plpy.yp"
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
	[#Rule 72
		 'term', 1,
sub
#line 607 "plpy.yp"
{
                $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                $_[0]->YYData->{"PRELUDE"}{"sys.argv = sys.argv[1:]"} = 1; 
                return "sys.argv";
            }
	],
	[#Rule 73
		 'term', 1,
sub
#line 613 "plpy.yp"
{
                printer (\@_, "term", "STRING");
                $_[1] =~ s/^"\$(\w+)"/$1/;
                return $_[1];
            }
	],
	[#Rule 74
		 'term', 1,
sub
#line 620 "plpy.yp"
{}
	],
	[#Rule 75
		 'term', 3,
sub
#line 622 "plpy.yp"
{
                return $_[2];    
            }
	],
	[#Rule 76
		 'term', 2,
sub
#line 626 "plpy.yp"
{}
	],
	[#Rule 77
		 'term', 1,
sub
#line 628 "plpy.yp"
{
                printer (\@_, "term", "scalar");
                return $_[1];
            }
	],
	[#Rule 78
		 'term', 1,
sub
#line 633 "plpy.yp"
{}
	],
	[#Rule 79
		 'term', 1,
sub
#line 635 "plpy.yp"
{
                printer (\@_, qw(term ary)); 
                return $_[1];
            }
	],
	[#Rule 80
		 'term', 1, undef
	],
	[#Rule 81
		 'term', 1, undef
	],
	[#Rule 82
		 'term', 4,
sub
#line 642 "plpy.yp"
{
                return "$_[1]$_[2]$_[3]$_[4]"; 
            }
	],
	[#Rule 83
		 'term', 1,
sub
#line 646 "plpy.yp"
{}
	],
	[#Rule 84
		 'term', 3,
sub
#line 648 "plpy.yp"
{}
	],
	[#Rule 85
		 'term', 4,
sub
#line 650 "plpy.yp"
{}
	],
	[#Rule 86
		 'term', 3,
sub
#line 652 "plpy.yp"
{
                printer (\@_, qw(term NOAMP WORD listexpr)); 
            }
	],
	[#Rule 87
		 'term', 1,
sub
#line 656 "plpy.yp"
{
                if ($_[1] eq "last"){
                    return "break";
                }
                elsif ($_[1] eq "next"){
                    return "continue";
                }

            }
	],
	[#Rule 88
		 'term', 2,
sub
#line 666 "plpy.yp"
{
                printer (\@_, qw(term NOTOP argexpr)); 
                return "not $_[2]";
            }
	],
	[#Rule 89
		 'term', 1,
sub
#line 671 "plpy.yp"
{
                printer (\@_, qw(term UNIOP)); 
                if ($_[1] eq "exit"){
                   return "exit()";
                }
            }
	],
	[#Rule 90
		 'term', 2,
sub
#line 678 "plpy.yp"
{}
	],
	[#Rule 91
		 'term', 2,
sub
#line 680 "plpy.yp"
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
	[#Rule 92
		 'term', 3,
sub
#line 700 "plpy.yp"
{
                if ($_[1] eq "exit"){
                   return "exit()";
                }
            }
	],
	[#Rule 93
		 'term', 4,
sub
#line 706 "plpy.yp"
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
	[#Rule 94
		 'term', 4,
sub
#line 727 "plpy.yp"
{}
	],
	[#Rule 95
		 'term', 6,
sub
#line 729 "plpy.yp"
{
                $_[3] =~ s/\/(.*)\//$1/;
                #$_[3] =~ s/\\([\{\}\[\]\(\)\^\$\.\|\*\+\?\\])/$1/g;
                $_[3] =~ s/\\([\Q{}[]()^$.|*+?\\E])/$1/g;
                return "split($_[3], $_[5])";
            }
	],
	[#Rule 96
		 'term', 1, undef
	],
	[#Rule 97
		 'term', 3,
sub
#line 739 "plpy.yp"
{
                #sort goes here
                printer (\@_, "term", "LSTOP", "indirob", "argexpr");
            }
	],
	[#Rule 98
		 'term', 5,
sub
#line 744 "plpy.yp"
{
                #sort goes here
            }
	],
	[#Rule 99
		 'term', 2,
sub
#line 748 "plpy.yp"
{
                printer (\@_, "term", "LSTOP", "listexpr");

                if ($_[1] eq "printf"){
                    my @list;
                    my ($string, @args) = split(', ', $_[2]);

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
	[#Rule 100
		 'term', 4,
sub
#line 833 "plpy.yp"
{
                if ($_[1] eq "printf"){
                    my @list;
                    my ($string, @args) = split(', ', $_[2]);

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
                elsif ($_[1] eq "join") {
                    printer (\@_, "term", "LSTOP", "listexpr");
                    my @list = split(', ', $_[3]);
                    my $delim = shift @list;
                    return "$delim.join(@list)";
                }
                elsif ($_[1] eq "print"){
                    #if ending newline was removed
                    # "hi\n" or "hi", "\n"
                    if ($_[3] =~ s/^.*\K(?:,\s*"\\n"$)|(?:(?<!\\)\\n(?=\s*"$))//){ #"
                    # finds all strings and then replaces
                    # "$var" to var
                    # yes, that's a regex in a regex.
                        $_[3] =~ s["(?:\\"|""|\\\\|[^"])*"]{ 
                                     $& =~ /"\$(.*)"/ ? $1 : $& 
                                 }eg;
                        return "print($_[3])";
                    }
                    else{
                        $_[3] =~ s["(?:\\"|""|\\\\|[^"])*"]{ 
                                     $& =~ /"\$(.*)"/ ? $1 : $& 
                                 }eg;
                        return "print($_[3], end='')";
                    }
                }
            }
	],
	[#Rule 101
		 'myattrterm', 2,
sub
#line 890 "plpy.yp"
{
                return $_[2];
            }
	],
	[#Rule 102
		 'myterm', 3,
sub
#line 897 "plpy.yp"
{
                    return $_[2];
                }
	],
	[#Rule 103
		 'myterm', 2, undef
	],
	[#Rule 104
		 'myterm', 1, undef
	],
	[#Rule 105
		 'myterm', 1, undef
	],
	[#Rule 106
		 'myterm', 1, undef
	],
	[#Rule 107
		 'listexpr', 0,
sub
#line 909 "plpy.yp"
{print "empty listexpr\n";}
	],
	[#Rule 108
		 'listexpr', 1,
sub
#line 911 "plpy.yp"
{
                printer (\@_, "listexpr", "argexpr");
                return $_[1];
            }
	],
	[#Rule 109
		 'listexprcom', 0, undef
	],
	[#Rule 110
		 'listexprcom', 1,
sub
#line 920 "plpy.yp"
{
                printer (\@_, "listexprcom", "expr");
                return "$_[1]";
            }
	],
	[#Rule 111
		 'listexprcom', 2,
sub
#line 925 "plpy.yp"
{
                printer (\@_, "listexprcom", "expr", "','");
                return "$_[1], ";
            }
	],
	[#Rule 112
		 'my_scalar', 1, undef
	],
	[#Rule 113
		 'amper', 2,
sub
#line 937 "plpy.yp"
{}
	],
	[#Rule 114
		 'scalar', 2,
sub
#line 941 "plpy.yp"
{
                printer (\@_, "scalar", "'\$'", "indirob"); 
                return "$_[2]";
            }
	],
	[#Rule 115
		 'ary', 2,
sub
#line 948 "plpy.yp"
{
                printer (\@_, "scalar", "'\@'", "indirob"); 
                return $_[2];
            }
	],
	[#Rule 116
		 'hsh', 2,
sub
#line 955 "plpy.yp"
{
                return "$_[2]";
            }
	],
	[#Rule 117
		 'arylen', 2,
sub
#line 961 "plpy.yp"
{
                return "len($_[2])";
            }
	],
	[#Rule 118
		 'indirob', 1,
sub
#line 968 "plpy.yp"
{
                printer (\@_, "indirob", "WORD");
                return $_[1];
            }
	],
	[#Rule 119
		 'indirob', 1,
sub
#line 973 "plpy.yp"
{
                $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                $_[0]->YYData->{"PRELUDE"}{"sys.argv = sys.argv[1:]"} = 1; 
                return "sys.argv";
            }
	],
	[#Rule 120
		 'indirob', 1, undef
	],
	[#Rule 121
		 'indirob', 1, undef
	]
],
                                  @_);
    bless($self,$class);
}

#line 982 "plpy.yp"


1;
