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
		DEFAULT => -3,
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
		DEFAULT => -90
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
		DEFAULT => -71
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
		DEFAULT => -64
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
		DEFAULT => -9
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
		DEFAULT => -101,
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
		DEFAULT => -73
	},
	{#State 15
		DEFAULT => -7
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
		DEFAULT => -63
	},
	{#State 18
		DEFAULT => -4
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
		DEFAULT => -5
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
		DEFAULT => -6
	},
	{#State 29
		DEFAULT => -66
	},
	{#State 30
		ACTIONS => {
			'WORD' => 80
		},
		GOTOS => {
			'subname' => 81
		}
	},
	{#State 31
		ACTIONS => {
			"(" => 82
		},
		DEFAULT => -77
	},
	{#State 32
		DEFAULT => -68
	},
	{#State 33
		ACTIONS => {
			"[" => 83,
			"{" => 84
		},
		DEFAULT => -75
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
			")" => 86,
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
			'expr' => 85,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 35
		ACTIONS => {
			"(" => 87
		}
	},
	{#State 36
		DEFAULT => -26
	},
	{#State 37
		ACTIONS => {
			";" => 88
		}
	},
	{#State 38
		ACTIONS => {
			"(" => 91,
			"\$" => 19,
			'MY' => 90
		},
		GOTOS => {
			'scalar' => 89
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
			'term' => 92,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 40
		ACTIONS => {
			'WORD' => 93
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
			'indirob' => 94,
			'block' => 60
		}
	},
	{#State 42
		ACTIONS => {
			"(" => 95
		}
	},
	{#State 43
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			'ASSIGNOP' => 97,
			'POSTINC' => 105,
			'BITOROP' => 106,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'DOTDOT' => 108,
			'MULOP' => 109,
			'BITXOROP' => 110,
			'SHIFTOP' => 100,
			'OROR' => 111,
			'ANDAND' => 101,
			'EQOP' => 102,
			'RELOP' => 103
		},
		DEFAULT => -36
	},
	{#State 44
		DEFAULT => -67
	},
	{#State 45
		ACTIONS => {
			'FOR' => 114,
			'OROP' => 113,
			'ANDOP' => 112,
			'WHILE' => 115
		},
		DEFAULT => -10
	},
	{#State 46
		DEFAULT => -81
	},
	{#State 47
		ACTIONS => {
			"(" => 116
		}
	},
	{#State 48
		DEFAULT => -74
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
			'indirob' => 117,
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
		DEFAULT => -83,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 118,
			'ary' => 14,
			'termbinop' => 21,
			'block' => 119,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 51
		ACTIONS => {
			"," => 120
		},
		DEFAULT => -33
	},
	{#State 52
		ACTIONS => {
			'POSTINC' => 105,
			'POWOP' => 98,
			'POSTDEC' => 107
		},
		DEFAULT => -55
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
			'expr' => 121,
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
			'expr' => 122,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 55
		DEFAULT => -113
	},
	{#State 56
		DEFAULT => -111
	},
	{#State 57
		DEFAULT => -108
	},
	{#State 58
		DEFAULT => -112
	},
	{#State 59
		DEFAULT => -3,
		GOTOS => {
			'lineseq' => 123
		}
	},
	{#State 60
		DEFAULT => -114
	},
	{#State 61
		ACTIONS => {
			'POSTINC' => 105,
			'POWOP' => 98,
			'POSTDEC' => 107
		},
		DEFAULT => -58
	},
	{#State 62
		DEFAULT => -109
	},
	{#State 63
		DEFAULT => -98
	},
	{#State 64
		DEFAULT => -100
	},
	{#State 65
		DEFAULT => -99
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
			")" => 125,
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
	{#State 67
		DEFAULT => -95
	},
	{#State 68
		ACTIONS => {
			'BITANDOP' => -90,
			'ANDOP' => -90,
			'ASSIGNOP' => -90,
			"]" => -90,
			'POWOP' => -90,
			'MATCHOP' => -90,
			'OROP' => -90,
			'SHIFTOP' => -90,
			'ANDAND' => -90,
			'RELOP' => -90,
			'EQOP' => -90,
			";" => -90,
			'FOR' => -90,
			'ADDOP' => -90,
			"," => -90,
			'POSTINC' => -90,
			'BITOROP' => -90,
			")" => -90,
			'WHILE' => -90,
			'POSTDEC' => -90,
			'DOTDOT' => -90,
			'MULOP' => -90,
			'BITXOROP' => -90,
			'OROR' => -90
		},
		DEFAULT => -111
	},
	{#State 69
		ACTIONS => {
			'BITANDOP' => -71,
			'ANDOP' => -71,
			'ASSIGNOP' => -71,
			"[" => 53,
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
			"{" => 54,
			'DOTDOT' => -71,
			'MULOP' => -71,
			'BITXOROP' => -71,
			'OROR' => -71
		},
		DEFAULT => -113
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
			'argexpr' => 126,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 71
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
		DEFAULT => -112
	},
	{#State 72
		DEFAULT => -93
	},
	{#State 73
		ACTIONS => {
			"," => 120
		},
		DEFAULT => -102
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
			'expr' => 127,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 75
		ACTIONS => {
			'POSTINC' => 105,
			'POWOP' => 98,
			'POSTDEC' => 107
		},
		DEFAULT => -57
	},
	{#State 76
		DEFAULT => -107
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
			'term' => 43,
			'ary' => 14,
			'expr' => 128,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
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
			'term' => 129,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 79
		ACTIONS => {
			"," => 120
		},
		DEFAULT => -82
	},
	{#State 80
		DEFAULT => -28
	},
	{#State 81
		ACTIONS => {
			";" => 131,
			"{" => 59
		},
		GOTOS => {
			'block' => 132,
			'subbody' => 130
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
			")" => 134,
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
			'expr' => 135,
			'termbinop' => 21,
			'argexpr' => 51,
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
			'expr' => 136,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 85
		ACTIONS => {
			'OROP' => 113,
			")" => 137,
			'ANDOP' => 112
		}
	},
	{#State 86
		DEFAULT => -70
	},
	{#State 87
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
			")" => 139,
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
			'expr' => 138,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 88
		DEFAULT => -8
	},
	{#State 89
		ACTIONS => {
			"(" => 140
		}
	},
	{#State 90
		ACTIONS => {
			"\$" => 19
		},
		GOTOS => {
			'scalar' => 141
		}
	},
	{#State 91
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
		DEFAULT => -22,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'sideff' => 142,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 143,
			'nexpr' => 144,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 92
		ACTIONS => {
			'POSTINC' => 105,
			'POWOP' => 98,
			'POSTDEC' => 107
		},
		DEFAULT => -56
	},
	{#State 93
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
		DEFAULT => -101,
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
			'listexpr' => 145,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 94
		DEFAULT => -110
	},
	{#State 95
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
		DEFAULT => -103,
		GOTOS => {
			'scalar' => 69,
			'arylen' => 48,
			'indirob' => 146,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 148,
			'termbinop' => 21,
			'listexprcom' => 147,
			'block' => 60,
			'argexpr' => 51,
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
			'term' => 149,
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
	{#State 105
		DEFAULT => -59
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
			'term' => 158,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 107
		DEFAULT => -60
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
			'term' => 159,
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
			'expr' => 163,
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
			'expr' => 164,
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
			'expr' => 165,
			'termbinop' => 21,
			'argexpr' => 51,
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
			'expr' => 166,
			'termbinop' => 21,
			'argexpr' => 51,
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
		DEFAULT => -24,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 168,
			'texpr' => 167,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 117
		DEFAULT => -106
	},
	{#State 118
		ACTIONS => {
			'ADDOP' => 104,
			'POSTINC' => 105,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109,
			'SHIFTOP' => 100
		},
		DEFAULT => -85
	},
	{#State 119
		DEFAULT => -84
	},
	{#State 120
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
		DEFAULT => -34,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 169,
			'ary' => 14,
			'termbinop' => 21,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 121
		ACTIONS => {
			'OROP' => 113,
			"]" => 170,
			'ANDOP' => 112
		}
	},
	{#State 122
		ACTIONS => {
			";" => 171,
			'OROP' => 113,
			'ANDOP' => 112
		}
	},
	{#State 123
		ACTIONS => {
			"}" => 172,
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
	{#State 124
		ACTIONS => {
			'OROP' => 113,
			")" => 173,
			'ANDOP' => 112
		}
	},
	{#State 125
		DEFAULT => -97
	},
	{#State 126
		ACTIONS => {
			"," => 120
		},
		DEFAULT => -91
	},
	{#State 127
		ACTIONS => {
			'OROP' => 113,
			"]" => 174,
			'ANDOP' => 112
		}
	},
	{#State 128
		ACTIONS => {
			'OROP' => 113,
			")" => 175,
			'ANDOP' => 112
		}
	},
	{#State 129
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			"," => 176,
			'ASSIGNOP' => 97,
			'POSTINC' => 105,
			")" => 177,
			'BITOROP' => 106,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'DOTDOT' => 108,
			'MULOP' => 109,
			'BITXOROP' => 110,
			'SHIFTOP' => 100,
			'OROR' => 111,
			'ANDAND' => 101,
			'RELOP' => 103,
			'EQOP' => 102
		}
	},
	{#State 130
		DEFAULT => -27
	},
	{#State 131
		DEFAULT => -30
	},
	{#State 132
		DEFAULT => -29
	},
	{#State 133
		ACTIONS => {
			'OROP' => 113,
			")" => 178,
			'ANDOP' => 112
		}
	},
	{#State 134
		DEFAULT => -78
	},
	{#State 135
		ACTIONS => {
			'OROP' => 113,
			"]" => 179,
			'ANDOP' => 112
		}
	},
	{#State 136
		ACTIONS => {
			";" => 180,
			'OROP' => 113,
			'ANDOP' => 112
		}
	},
	{#State 137
		DEFAULT => -69
	},
	{#State 138
		ACTIONS => {
			'OROP' => 113,
			")" => 181,
			'ANDOP' => 112
		}
	},
	{#State 139
		DEFAULT => -86
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
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 182,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 141
		ACTIONS => {
			"(" => 183
		}
	},
	{#State 142
		DEFAULT => -23
	},
	{#State 143
		ACTIONS => {
			'FOR' => 114,
			'OROP' => 113,
			")" => 184,
			'ANDOP' => 112,
			'WHILE' => 115
		},
		DEFAULT => -10
	},
	{#State 144
		ACTIONS => {
			";" => 185
		}
	},
	{#State 145
		DEFAULT => -80
	},
	{#State 146
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
			'expr' => 186,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 147
		ACTIONS => {
			")" => 187
		}
	},
	{#State 148
		ACTIONS => {
			'OROP' => 113,
			"," => 188,
			'ANDOP' => 112
		},
		DEFAULT => -104
	},
	{#State 149
		ACTIONS => {
			'ADDOP' => 104,
			'POSTINC' => 105,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109,
			'SHIFTOP' => 100,
			'EQOP' => 102,
			'RELOP' => 103
		},
		DEFAULT => -48
	},
	{#State 150
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			'ASSIGNOP' => 97,
			'POSTINC' => 105,
			'BITOROP' => 106,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'DOTDOT' => 108,
			'MULOP' => 109,
			'BITXOROP' => 110,
			'SHIFTOP' => 100,
			'OROR' => 111,
			'ANDAND' => 101,
			'EQOP' => 102,
			'RELOP' => 103
		},
		DEFAULT => -41
	},
	{#State 151
		ACTIONS => {
			'POSTINC' => 105,
			'POWOP' => 98,
			'POSTDEC' => 107
		},
		DEFAULT => -42
	},
	{#State 152
		ACTIONS => {
			'POSTINC' => 105,
			'POWOP' => 98,
			'POSTDEC' => 107
		},
		DEFAULT => -54
	},
	{#State 153
		ACTIONS => {
			'ADDOP' => 104,
			'POSTINC' => 105,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109
		},
		DEFAULT => -45
	},
	{#State 154
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			'POSTINC' => 105,
			'BITOROP' => 106,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109,
			'BITXOROP' => 110,
			'SHIFTOP' => 100,
			'EQOP' => 102,
			'RELOP' => 103
		},
		DEFAULT => -52
	},
	{#State 155
		ACTIONS => {
			'ADDOP' => 104,
			'POSTINC' => 105,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109,
			'SHIFTOP' => 100,
			'EQOP' => undef,
			'RELOP' => 103
		},
		DEFAULT => -47
	},
	{#State 156
		ACTIONS => {
			'ADDOP' => 104,
			'POSTINC' => 105,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109,
			'SHIFTOP' => 100,
			'RELOP' => undef
		},
		DEFAULT => -46
	},
	{#State 157
		ACTIONS => {
			'POSTINC' => 105,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109
		},
		DEFAULT => -44
	},
	{#State 158
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			'POSTINC' => 105,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109,
			'SHIFTOP' => 100,
			'EQOP' => 102,
			'RELOP' => 103
		},
		DEFAULT => -49
	},
	{#State 159
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			'POSTINC' => 105,
			'BITOROP' => 106,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'DOTDOT' => undef,
			'MULOP' => 109,
			'BITXOROP' => 110,
			'SHIFTOP' => 100,
			'OROR' => 111,
			'ANDAND' => 101,
			'EQOP' => 102,
			'RELOP' => 103
		},
		DEFAULT => -51
	},
	{#State 160
		ACTIONS => {
			'POSTINC' => 105,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107
		},
		DEFAULT => -43
	},
	{#State 161
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			'POSTINC' => 105,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109,
			'SHIFTOP' => 100,
			'EQOP' => 102,
			'RELOP' => 103
		},
		DEFAULT => -50
	},
	{#State 162
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			'POSTINC' => 105,
			'BITOROP' => 106,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'MULOP' => 109,
			'BITXOROP' => 110,
			'SHIFTOP' => 100,
			'ANDAND' => 101,
			'EQOP' => 102,
			'RELOP' => 103
		},
		DEFAULT => -53
	},
	{#State 163
		DEFAULT => -31
	},
	{#State 164
		ACTIONS => {
			'ANDOP' => 112
		},
		DEFAULT => -32
	},
	{#State 165
		ACTIONS => {
			'OROP' => 113,
			'ANDOP' => 112
		},
		DEFAULT => -12
	},
	{#State 166
		ACTIONS => {
			'OROP' => 113,
			'ANDOP' => 112
		},
		DEFAULT => -11
	},
	{#State 167
		ACTIONS => {
			")" => 189
		}
	},
	{#State 168
		ACTIONS => {
			'OROP' => 113,
			'ANDOP' => 112
		},
		DEFAULT => -25
	},
	{#State 169
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			'ASSIGNOP' => 97,
			'POSTINC' => 105,
			'BITOROP' => 106,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'DOTDOT' => 108,
			'MULOP' => 109,
			'BITXOROP' => 110,
			'SHIFTOP' => 100,
			'OROR' => 111,
			'ANDAND' => 101,
			'EQOP' => 102,
			'RELOP' => 103
		},
		DEFAULT => -35
	},
	{#State 170
		DEFAULT => -37
	},
	{#State 171
		ACTIONS => {
			"}" => 190
		}
	},
	{#State 172
		DEFAULT => -2
	},
	{#State 173
		DEFAULT => -96
	},
	{#State 174
		DEFAULT => -76
	},
	{#State 175
		ACTIONS => {
			"{" => 59
		},
		GOTOS => {
			'block' => 191
		}
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
	{#State 177
		DEFAULT => -88
	},
	{#State 178
		DEFAULT => -79
	},
	{#State 179
		DEFAULT => -38
	},
	{#State 180
		ACTIONS => {
			"}" => 193
		}
	},
	{#State 181
		DEFAULT => -87
	},
	{#State 182
		ACTIONS => {
			'OROP' => 113,
			")" => 194,
			'ANDOP' => 112
		}
	},
	{#State 183
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
			'expr' => 195,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 184
		ACTIONS => {
			"{" => 59
		},
		GOTOS => {
			'block' => 196
		}
	},
	{#State 185
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
		DEFAULT => -24,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 168,
			'texpr' => 197,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 186
		ACTIONS => {
			'OROP' => 113,
			")" => 198,
			'ANDOP' => 112
		}
	},
	{#State 187
		DEFAULT => -94
	},
	{#State 188
		DEFAULT => -105
	},
	{#State 189
		ACTIONS => {
			"{" => 59
		},
		GOTOS => {
			'block' => 199
		}
	},
	{#State 190
		DEFAULT => -39
	},
	{#State 191
		ACTIONS => {
			'ELSE' => 200,
			'ELSIF' => 202
		},
		DEFAULT => -13,
		GOTOS => {
			'else' => 201
		}
	},
	{#State 192
		ACTIONS => {
			'BITANDOP' => 96,
			'ADDOP' => 104,
			'ASSIGNOP' => 97,
			'POSTINC' => 105,
			")" => 203,
			'BITOROP' => 106,
			'POWOP' => 98,
			'MATCHOP' => 99,
			'POSTDEC' => 107,
			'DOTDOT' => 108,
			'MULOP' => 109,
			'BITXOROP' => 110,
			'SHIFTOP' => 100,
			'OROR' => 111,
			'ANDAND' => 101,
			'RELOP' => 103,
			'EQOP' => 102
		}
	},
	{#State 193
		DEFAULT => -40
	},
	{#State 194
		ACTIONS => {
			"{" => 59
		},
		GOTOS => {
			'block' => 204
		}
	},
	{#State 195
		ACTIONS => {
			'OROP' => 113,
			")" => 205,
			'ANDOP' => 112
		}
	},
	{#State 196
		DEFAULT => -20
	},
	{#State 197
		ACTIONS => {
			";" => 206
		}
	},
	{#State 198
		DEFAULT => -92
	},
	{#State 199
		DEFAULT => -17
	},
	{#State 200
		ACTIONS => {
			"{" => 59
		},
		GOTOS => {
			'block' => 207
		}
	},
	{#State 201
		DEFAULT => -16
	},
	{#State 202
		ACTIONS => {
			"(" => 208
		}
	},
	{#State 203
		DEFAULT => -89
	},
	{#State 204
		DEFAULT => -19
	},
	{#State 205
		ACTIONS => {
			"{" => 59
		},
		GOTOS => {
			'block' => 209
		}
	},
	{#State 206
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
		DEFAULT => -22,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'sideff' => 142,
			'myattrterm' => 32,
			'amper' => 31,
			'subscripted' => 33,
			'term' => 43,
			'ary' => 14,
			'expr' => 45,
			'nexpr' => 210,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 207
		DEFAULT => -14
	},
	{#State 208
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
			'expr' => 211,
			'termbinop' => 21,
			'argexpr' => 51,
			'hsh' => 23,
			'termunop' => 24
		}
	},
	{#State 209
		DEFAULT => -18
	},
	{#State 210
		ACTIONS => {
			")" => 212
		}
	},
	{#State 211
		ACTIONS => {
			'OROP' => 113,
			")" => 213,
			'ANDOP' => 112
		}
	},
	{#State 212
		ACTIONS => {
			"{" => 59
		},
		GOTOS => {
			'block' => 214
		}
	},
	{#State 213
		ACTIONS => {
			"{" => 59
		},
		GOTOS => {
			'block' => 215
		}
	},
	{#State 214
		DEFAULT => -21
	},
	{#State 215
		ACTIONS => {
			'ELSE' => 200,
			'ELSIF' => 202
		},
		DEFAULT => -13,
		GOTOS => {
			'else' => 216
		}
	},
	{#State 216
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
		 'block', 3,
sub
#line 216 "plpy.yp"
{
                        printer(\@_, qw( block '{' lineseq '}' )); 
                        #adds indentation
                        $_[3] =~ s/^/    /gm;   #"/
                        return "\n$_[3]\n";
                    }
	],
	[#Rule 3
		 'lineseq', 0, undef
	],
	[#Rule 4
		 'lineseq', 2,
sub
#line 227 "plpy.yp"
{
                        printer(\@_, qw( lineseq lineseq decl )); 
                        return "$_[1]$_[2]";
                    }
	],
	[#Rule 5
		 'lineseq', 2,
sub
#line 232 "plpy.yp"
{
                        printer(\@_, "lineseq", "lineseq", "line");
                        return "$_[1]$_[2]";
                    }
	],
	[#Rule 6
		 'line', 1, undef
	],
	[#Rule 7
		 'line', 1, undef
	],
	[#Rule 8
		 'line', 2, undef
	],
	[#Rule 9
		 'line', 1,
sub
#line 243 "plpy.yp"
{
                        printer(\@_, "line", "COMMENT")
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
                    $_[0]->yydata->{"prelude"}{"$_[1] = {}"} = 1; 
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
                    return "$_[1] + $_[3]";
                }
                else{
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
                if ($_[3] =~ /^s/){
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
	[#Rule 55
		 'termunop', 2,
sub
#line 533 "plpy.yp"
{
                return "-$_[2]"; 
            }
	],
	[#Rule 56
		 'termunop', 2,
sub
#line 537 "plpy.yp"
{
                return $_[2]; 
            }
	],
	[#Rule 57
		 'termunop', 2,
sub
#line 541 "plpy.yp"
{
                printer (\@_, qw(termunop '!' term)); 
                return "not $_[2]";
            }
	],
	[#Rule 58
		 'termunop', 2,
sub
#line 546 "plpy.yp"
{
                printer (\@_, qw(termunop '~' term)); 
                return "~$_[2]";
            }
	],
	[#Rule 59
		 'termunop', 2,
sub
#line 551 "plpy.yp"
{
                printer (\@_, qw(termunop term POSTINC)); 
                return "$_[1] += 1";
            }
	],
	[#Rule 60
		 'termunop', 2,
sub
#line 556 "plpy.yp"
{
                printer (\@_, qw(termunop term POSTDEC)); 
                return "$_[1] -= 1";
            }
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
#line 565 "plpy.yp"
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
	[#Rule 64
		 'term', 1, undef
	],
	[#Rule 65
		 'term', 1, undef
	],
	[#Rule 66
		 'term', 1,
sub
#line 588 "plpy.yp"
{
                $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                $_[0]->YYData->{"PRELUDE"}{"sys.argv = sys.argv[1:]"} = 1; 
                return "sys.argv";
            }
	],
	[#Rule 67
		 'term', 1,
sub
#line 594 "plpy.yp"
{
                printer (\@_, "term", "STRING");
                $_[1] =~ s/^"\$(\w+)"/$1/;
                return $_[1];
            }
	],
	[#Rule 68
		 'term', 1,
sub
#line 601 "plpy.yp"
{}
	],
	[#Rule 69
		 'term', 3,
sub
#line 603 "plpy.yp"
{
                return $_[2];    
            }
	],
	[#Rule 70
		 'term', 2,
sub
#line 607 "plpy.yp"
{}
	],
	[#Rule 71
		 'term', 1,
sub
#line 609 "plpy.yp"
{
                printer (\@_, "term", "scalar");
                return $_[1];
            }
	],
	[#Rule 72
		 'term', 1,
sub
#line 614 "plpy.yp"
{}
	],
	[#Rule 73
		 'term', 1,
sub
#line 616 "plpy.yp"
{
                printer (\@_, qw(term ary)); 
                return $_[1];
            }
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
#line 623 "plpy.yp"
{
                return "$_[1]$_[2]$_[3]$_[4]"; 
            }
	],
	[#Rule 77
		 'term', 1,
sub
#line 627 "plpy.yp"
{}
	],
	[#Rule 78
		 'term', 3,
sub
#line 629 "plpy.yp"
{}
	],
	[#Rule 79
		 'term', 4,
sub
#line 631 "plpy.yp"
{}
	],
	[#Rule 80
		 'term', 3,
sub
#line 633 "plpy.yp"
{
                printer (\@_, qw(term NOAMP WORD listexpr)); 
            }
	],
	[#Rule 81
		 'term', 1,
sub
#line 637 "plpy.yp"
{
                if ($_[1] eq "last"){
                    return "break";
                }
                elsif ($_[1] eq "next"){
                    return "continue";
                }

            }
	],
	[#Rule 82
		 'term', 2,
sub
#line 647 "plpy.yp"
{
                printer (\@_, qw(term NOTOP argexpr)); 
                return "not $_[2]";
            }
	],
	[#Rule 83
		 'term', 1,
sub
#line 652 "plpy.yp"
{
                printer (\@_, qw(term UNIOP)); 
                if ($_[1] eq "exit"){
                   return "exit()";
                }
            }
	],
	[#Rule 84
		 'term', 2,
sub
#line 659 "plpy.yp"
{}
	],
	[#Rule 85
		 'term', 2,
sub
#line 661 "plpy.yp"
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
	[#Rule 86
		 'term', 3,
sub
#line 681 "plpy.yp"
{
                if ($_[1] eq "exit"){
                   return "exit()";
                }
            }
	],
	[#Rule 87
		 'term', 4,
sub
#line 687 "plpy.yp"
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
	[#Rule 88
		 'term', 4,
sub
#line 708 "plpy.yp"
{}
	],
	[#Rule 89
		 'term', 6,
sub
#line 710 "plpy.yp"
{
                $_[3] =~ s/\/(.*)\//$1/;
                #$_[3] =~ s/\\([\{\}\[\]\(\)\^\$\.\|\*\+\?\\])/$1/g;
                $_[3] =~ s/\\([\Q{}[]()^$.|*+?\\E])/$1/g;
                return "split($_[3], $_[5])";
            }
	],
	[#Rule 90
		 'term', 1, undef
	],
	[#Rule 91
		 'term', 3,
sub
#line 720 "plpy.yp"
{
                #sort goes here
                printer (\@_, "term", "LSTOP", "indirob", "argexpr");
            }
	],
	[#Rule 92
		 'term', 5,
sub
#line 725 "plpy.yp"
{
                #sort goes here
            }
	],
	[#Rule 93
		 'term', 2,
sub
#line 729 "plpy.yp"
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
	[#Rule 94
		 'term', 4,
sub
#line 847 "plpy.yp"
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
	[#Rule 95
		 'myattrterm', 2,
sub
#line 918 "plpy.yp"
{$_[2]}
	],
	[#Rule 96
		 'myterm', 3,
sub
#line 921 "plpy.yp"
{$_[2]}
	],
	[#Rule 97
		 'myterm', 2, undef
	],
	[#Rule 98
		 'myterm', 1, undef
	],
	[#Rule 99
		 'myterm', 1, undef
	],
	[#Rule 100
		 'myterm', 1, undef
	],
	[#Rule 101
		 'listexpr', 0, undef
	],
	[#Rule 102
		 'listexpr', 1, undef
	],
	[#Rule 103
		 'listexprcom', 0, undef
	],
	[#Rule 104
		 'listexprcom', 1, undef
	],
	[#Rule 105
		 'listexprcom', 2,
sub
#line 937 "plpy.yp"
{"$_[1], "}
	],
	[#Rule 106
		 'amper', 2,
sub
#line 942 "plpy.yp"
{$_[2]}
	],
	[#Rule 107
		 'scalar', 2,
sub
#line 945 "plpy.yp"
{$_[2]}
	],
	[#Rule 108
		 'ary', 2,
sub
#line 948 "plpy.yp"
{$_[2]}
	],
	[#Rule 109
		 'hsh', 2,
sub
#line 951 "plpy.yp"
{$_[2]}
	],
	[#Rule 110
		 'arylen', 2,
sub
#line 954 "plpy.yp"
{return "len($_[2]) - 1";}
	],
	[#Rule 111
		 'indirob', 1, undef
	],
	[#Rule 112
		 'indirob', 1,
sub
#line 960 "plpy.yp"
{
                        $_[0]->YYData->{"IMPORTS"}{"import sys"} = 1; 
                    $_[0]->YYData->{"PRELUDE"}{"sys.argv = sys.argv[1:]"} = 1; 
                    return "sys.argv";
                }
	],
	[#Rule 113
		 'indirob', 1, undef
	],
	[#Rule 114
		 'indirob', 1, undef
	]
],
                                  @_);
    bless($self,$class);
}

#line 969 "plpy.yp"


1;
