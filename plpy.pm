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

#line 8 "plpy.y"

//list of functions
//print, chomp, split, join, exit?, push, pop, shift, 
//unshift, reverse, open, printf, sort BLOCK LIST, keys, 
    sub Lexer {
        my @tokens = (
            ("WORD", /^w+/),
            ("PMFUNC", /^split/),
            //^(\/[^/]*\/)|(s\/[^/]*\/[^/]*\/)
            ("SUB", /^sub/),
            ("WHILE", /^while/),
            ("IF", /^if/),
            ("ELSE", /^else/),
            ("ELSIF", /^elsif/),
            ("CONTINUE", /^next/),
            ("FOR", /^(for)|(foreach)/),
            ("LOOPEX", /^last/),
            ("DOTDOT", /^\.\.\.?/),
            ("FUNC0", /^(print)|(printf)|(chomp)|(split)|(exit)|(pop)|(shift)/),
            ("FUNC1", /^(print)|(printf)|(chomp)|(split)|(exit)|(pop)|(shift)|(reverse)|(open)|(sort)|(keys)/),
            ("FUNC", /^(print)|(printf)|(chomp)|(split)|(join)|(push)|(unshift)|(open)/),
            ("UNIOP", /??/),
            ("LSTOP", /??/),
            ("RELOP", /^(>)|(<)|(<=)|(>=)|(lt)|(gt)|(le)|(ge)/),
            ("EQOP", /^(==)|(!=)|(<=>)/),
            ("MULOP", /^[/%x*]/),
            ("ADDOP", /^[+-.]/),
            ("DOLSHARP", /^\$#/), 
            ("MY", /^my/),
            ("OROP", /^or/),
            ("ANDOP", /^and/), 
            ("NOTOP", /^not/),
            (",", /^,/),
            ("ASSIGNOP", /^(=)|(\.=)/),
            ("OROR", /^(\|\|)/),
            ("ANDAND", /^&&/),
            ("EQOP", /^(==)|(eq)/)
            ("MATCHOP", /^=~/),
            ("!", /^!/),
            ("POWOP", /^\*\*/),
            ("POSTINC", /^\+\+/),
            ("POSTDEC", /^--/),
            (")", /^\)/),
            ("(", /^\(/),
            ("{", /^\{/),
            ("}", /^\}/),
            ("[", /^\[/),
            ("]", /^\]/)

        )

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
			"+" => 35,
			'FOR' => 34,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			'IF' => 17,
			"\$" => 16,
			'error' => 43,
			'LOOPEX' => 42,
			'WHILE' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FORMAT' => 24,
			'FUNC0' => 46,
			'SUB' => 26,
			"{" => 50,
			'UNIOP' => 49,
			"&" => 48,
			'USE' => 52,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 32,
			'sideff' => 33,
			'term' => 38,
			'loop' => 13,
			'ary' => 12,
			'use' => 41,
			'expr' => 40,
			'decl' => 15,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20,
			'line' => 21,
			'cond' => 25,
			'arylen' => 47,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'package' => 51,
			'format' => 53,
			'block' => 54,
			'argexpr' => 55
		}
	},
	{#State 3
		DEFAULT => 0
	},
	{#State 4
		DEFAULT => -108
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
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 56,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 6
		ACTIONS => {
			"[" => 57
		},
		DEFAULT => -84
	},
	{#State 7
		ACTIONS => {
			'WORD' => 59,
			"\$" => 16,
			"{" => 50
		},
		GOTOS => {
			'scalar' => 58,
			'indirob' => 60,
			'block' => 61
		}
	},
	{#State 8
		ACTIONS => {
			'WORD' => 62,
			";" => 63
		}
	},
	{#State 9
		ACTIONS => {
			'WORD' => 59,
			"\$" => 16,
			"{" => 50
		},
		GOTOS => {
			'scalar' => 58,
			'indirob' => 64,
			'block' => 61
		}
	},
	{#State 10
		ACTIONS => {
			"(" => 68,
			"\@" => 7,
			"\$" => 16,
			"%" => 9
		},
		GOTOS => {
			'scalar' => 65,
			'myterm' => 69,
			'hsh' => 67,
			'ary' => 66
		}
	},
	{#State 11
		ACTIONS => {
			"-" => 5,
			'WORD' => 70,
			"\@" => 7,
			'MY' => 10,
			"%" => 9,
			'LSTOP' => 11,
			"!" => 14,
			"\$" => 16,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			"(" => 30,
			'FUNC1' => 31,
			"+" => 35,
			'NOAMP' => 36,
			'DOLSHARP' => 37,
			'FUNC' => 39,
			'LOOPEX' => 42,
			'FUNC0' => 46,
			"&" => 48,
			'UNIOP' => 49,
			"{" => 50
		},
		DEFAULT => -117,
		GOTOS => {
			'scalar' => 71,
			'arylen' => 47,
			'indirob' => 72,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'termbinop' => 18,
			'block' => 61,
			'argexpr' => 74,
			'listop' => 44,
			'listexpr' => 73,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 12
		ACTIONS => {
			"[" => 75,
			"{" => 76
		},
		DEFAULT => -86
	},
	{#State 13
		DEFAULT => -10
	},
	{#State 14
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 77,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 15
		DEFAULT => -7
	},
	{#State 16
		ACTIONS => {
			'WORD' => 59,
			"\$" => 16,
			"{" => 50
		},
		GOTOS => {
			'scalar' => 58,
			'indirob' => 78,
			'block' => 61
		}
	},
	{#State 17
		ACTIONS => {
			"(" => 79
		}
	},
	{#State 18
		DEFAULT => -79
	},
	{#State 19
		DEFAULT => -85
	},
	{#State 20
		DEFAULT => -80
	},
	{#State 21
		DEFAULT => -8
	},
	{#State 22
		ACTIONS => {
			"(" => 80
		}
	},
	{#State 23
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 81,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 24
		DEFAULT => -45,
		GOTOS => {
			'startformsub' => 82
		}
	},
	{#State 25
		DEFAULT => -9
	},
	{#State 26
		DEFAULT => -44,
		GOTOS => {
			'startsub' => 83
		}
	},
	{#State 27
		ACTIONS => {
			"(" => 84
		},
		DEFAULT => -93
	},
	{#State 28
		DEFAULT => -81
	},
	{#State 29
		DEFAULT => -88
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
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			")" => 86,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 85,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 31
		ACTIONS => {
			"(" => 87
		}
	},
	{#State 32
		DEFAULT => -37
	},
	{#State 33
		ACTIONS => {
			";" => 88
		}
	},
	{#State 34
		ACTIONS => {
			"(" => 91,
			"\$" => 16,
			'MY' => 90
		},
		GOTOS => {
			'scalar' => 89
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
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 92,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 36
		ACTIONS => {
			'WORD' => 93
		}
	},
	{#State 37
		ACTIONS => {
			'WORD' => 59,
			"\$" => 16,
			"{" => 50
		},
		GOTOS => {
			'scalar' => 58,
			'indirob' => 94,
			'block' => 61
		}
	},
	{#State 38
		ACTIONS => {
			'ADDOP' => 101,
			'ASSIGNOP' => 95,
			'POSTINC' => 102,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 103,
			'DOTDOT' => 104,
			'MULOP' => 105,
			'ANDAND' => 98,
			'OROR' => 106,
			'RELOP' => 100,
			'EQOP' => 99
		},
		DEFAULT => -58
	},
	{#State 39
		ACTIONS => {
			"(" => 107
		}
	},
	{#State 40
		ACTIONS => {
			'FOR' => 111,
			'OROP' => 110,
			'ANDOP' => 108,
			'IF' => 109,
			'WHILE' => 112
		},
		DEFAULT => -13
	},
	{#State 41
		DEFAULT => -39
	},
	{#State 42
		DEFAULT => -97
	},
	{#State 43
		DEFAULT => -12
	},
	{#State 44
		DEFAULT => -109
	},
	{#State 45
		ACTIONS => {
			"(" => 113
		}
	},
	{#State 46
		ACTIONS => {
			"(" => 114
		},
		DEFAULT => -102
	},
	{#State 47
		DEFAULT => -87
	},
	{#State 48
		ACTIONS => {
			'WORD' => 59,
			"\$" => 16,
			"{" => 50
		},
		GOTOS => {
			'scalar' => 58,
			'indirob' => 115,
			'block' => 61
		}
	},
	{#State 49
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
			"(" => 30,
			'FUNC1' => 31,
			"+" => 35,
			'NOAMP' => 36,
			'DOLSHARP' => 37,
			'FUNC' => 39,
			'LOOPEX' => 42,
			'FUNC0' => 46,
			"&" => 48,
			'UNIOP' => 49,
			"{" => 50
		},
		DEFAULT => -99,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 116,
			'ary' => 12,
			'termbinop' => 18,
			'block' => 117,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 50
		DEFAULT => -3,
		GOTOS => {
			'remember' => 118
		}
	},
	{#State 51
		DEFAULT => -38
	},
	{#State 52
		DEFAULT => -44,
		GOTOS => {
			'startsub' => 119
		}
	},
	{#State 53
		DEFAULT => -36
	},
	{#State 54
		ACTIONS => {
			'CONTINUE' => 120
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 121
		}
	},
	{#State 55
		ACTIONS => {
			"," => 122
		},
		DEFAULT => -55
	},
	{#State 56
		ACTIONS => {
			'POSTINC' => 102,
			'POWOP' => 96,
			'POSTDEC' => 103
		},
		DEFAULT => -74
	},
	{#State 57
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 123,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 58
		DEFAULT => -129
	},
	{#State 59
		DEFAULT => -128
	},
	{#State 60
		DEFAULT => -125
	},
	{#State 61
		DEFAULT => -130
	},
	{#State 62
		ACTIONS => {
			";" => 124
		}
	},
	{#State 63
		DEFAULT => -50
	},
	{#State 64
		DEFAULT => -126
	},
	{#State 65
		DEFAULT => -114
	},
	{#State 66
		DEFAULT => -116
	},
	{#State 67
		DEFAULT => -115
	},
	{#State 68
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			")" => 126,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 125,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 69
		ACTIONS => {
			'myattrlist' => 127
		},
		DEFAULT => -111
	},
	{#State 70
		ACTIONS => {
			"-" => -128,
			'WORD' => -128,
			"\@" => -128,
			"%" => -128,
			'MY' => -128,
			'LSTOP' => -128,
			"!" => -128,
			"\$" => -128,
			'NOTOP' => -128,
			'PMFUNC' => -128,
			"(" => -128,
			'FUNC1' => -128,
			"+" => -128,
			'NOAMP' => -128,
			'FUNC' => -128,
			'DOLSHARP' => -128,
			'LOOPEX' => -128,
			'FUNC0' => -128,
			"&" => -128,
			'UNIOP' => -128
		},
		DEFAULT => -108
	},
	{#State 71
		ACTIONS => {
			"-" => -129,
			'WORD' => -129,
			"\@" => -129,
			"%" => -129,
			'MY' => -129,
			'LSTOP' => -129,
			"!" => -129,
			"\$" => -129,
			"[" => 57,
			'NOTOP' => -129,
			'PMFUNC' => -129,
			"(" => -129,
			'FUNC1' => -129,
			"+" => -129,
			'NOAMP' => -129,
			'FUNC' => -129,
			'DOLSHARP' => -129,
			'LOOPEX' => -129,
			'FUNC0' => -129,
			"&" => -129,
			'UNIOP' => -129
		},
		DEFAULT => -84
	},
	{#State 72
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 128,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 73
		DEFAULT => -61
	},
	{#State 74
		ACTIONS => {
			"," => 122
		},
		DEFAULT => -118
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
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 129,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 76
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 130,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 77
		ACTIONS => {
			'POSTINC' => 102,
			'POWOP' => 96,
			'POSTDEC' => 103
		},
		DEFAULT => -76
	},
	{#State 78
		DEFAULT => -124
	},
	{#State 79
		DEFAULT => -3,
		GOTOS => {
			'remember' => 131
		}
	},
	{#State 80
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 132,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 81
		ACTIONS => {
			"," => 122
		},
		DEFAULT => -98
	},
	{#State 82
		ACTIONS => {
			'WORD' => 133
		},
		DEFAULT => -42,
		GOTOS => {
			'formname' => 134
		}
	},
	{#State 83
		ACTIONS => {
			'WORD' => 135
		},
		GOTOS => {
			'subname' => 136
		}
	},
	{#State 84
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			")" => 138,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 137,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 85
		ACTIONS => {
			'OROP' => 110,
			")" => 139,
			'ANDOP' => 108
		}
	},
	{#State 86
		ACTIONS => {
			"[" => 140
		},
		DEFAULT => -83
	},
	{#State 87
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			")" => 142,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 141,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 88
		DEFAULT => -11
	},
	{#State 89
		ACTIONS => {
			"(" => 143
		}
	},
	{#State 90
		DEFAULT => -3,
		GOTOS => {
			'remember' => 144
		}
	},
	{#State 91
		DEFAULT => -3,
		GOTOS => {
			'remember' => 145
		}
	},
	{#State 92
		ACTIONS => {
			'POSTINC' => 102,
			'POWOP' => 96,
			'POSTDEC' => 103
		},
		DEFAULT => -75
	},
	{#State 93
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
			"(" => 30,
			'FUNC1' => 31,
			"+" => 35,
			'NOAMP' => 36,
			'DOLSHARP' => 37,
			'FUNC' => 39,
			'LOOPEX' => 42,
			'FUNC0' => 46,
			"&" => 48,
			'UNIOP' => 49
		},
		DEFAULT => -117,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 74,
			'listop' => 44,
			'listexpr' => 146,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 94
		DEFAULT => -127
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
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 147,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
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
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 148,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
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
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 149,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
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
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 150,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
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
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 151,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
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
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 152,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 101
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 153,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 102
		DEFAULT => -77
	},
	{#State 103
		DEFAULT => -78
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
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 154,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
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
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 155,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
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
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 156,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 107
		ACTIONS => {
			"-" => 5,
			'WORD' => 70,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			"{" => 50,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		DEFAULT => -119,
		GOTOS => {
			'scalar' => 71,
			'indirob' => 157,
			'term' => 38,
			'ary' => 12,
			'expr' => 159,
			'termbinop' => 18,
			'listexprcom' => 158,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20,
			'arylen' => 47,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'block' => 61,
			'argexpr' => 55
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
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 160,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
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
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 161,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
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
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 162,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 111
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 163,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 112
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 164,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 113
		DEFAULT => -3,
		GOTOS => {
			'remember' => 165
		}
	},
	{#State 114
		ACTIONS => {
			")" => 166
		}
	},
	{#State 115
		DEFAULT => -123
	},
	{#State 116
		ACTIONS => {
			'ADDOP' => 101,
			'POSTINC' => 102,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 103,
			'MULOP' => 105
		},
		DEFAULT => -101
	},
	{#State 117
		DEFAULT => -100
	},
	{#State 118
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 167
		}
	},
	{#State 119
		DEFAULT => -51,
		GOTOS => {
			'@1-2' => 168
		}
	},
	{#State 120
		ACTIONS => {
			"{" => 50
		},
		GOTOS => {
			'block' => 169
		}
	},
	{#State 121
		DEFAULT => -28
	},
	{#State 122
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
			"(" => 30,
			'FUNC1' => 31,
			"+" => 35,
			'NOAMP' => 36,
			'DOLSHARP' => 37,
			'FUNC' => 39,
			'LOOPEX' => 42,
			'FUNC0' => 46,
			"&" => 48,
			'UNIOP' => 49
		},
		DEFAULT => -56,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 170,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 123
		ACTIONS => {
			'OROP' => 110,
			"]" => 171,
			'ANDOP' => 108
		}
	},
	{#State 124
		DEFAULT => -49
	},
	{#State 125
		ACTIONS => {
			'OROP' => 110,
			")" => 172,
			'ANDOP' => 108
		}
	},
	{#State 126
		DEFAULT => -113
	},
	{#State 127
		DEFAULT => -110
	},
	{#State 128
		ACTIONS => {
			"," => 122
		},
		DEFAULT => -59
	},
	{#State 129
		ACTIONS => {
			'OROP' => 110,
			"]" => 173,
			'ANDOP' => 108
		}
	},
	{#State 130
		ACTIONS => {
			";" => 174,
			'OROP' => 110,
			'ANDOP' => 108
		}
	},
	{#State 131
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 175,
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 176,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 132
		ACTIONS => {
			'MATCHOP' => 97,
			'POSTDEC' => 103,
			'MULOP' => 105,
			'DOTDOT' => 104,
			'ADDOP' => 101,
			"," => 177,
			'ASSIGNOP' => 95,
			'OROR' => 106,
			'POSTINC' => 102,
			'ANDAND' => 98,
			")" => 178,
			'POWOP' => 96,
			'EQOP' => 99,
			'RELOP' => 100
		}
	},
	{#State 133
		DEFAULT => -41
	},
	{#State 134
		ACTIONS => {
			"{" => 50
		},
		GOTOS => {
			'block' => 179
		}
	},
	{#State 135
		DEFAULT => -46
	},
	{#State 136
		ACTIONS => {
			";" => 181,
			"{" => 50
		},
		GOTOS => {
			'block' => 182,
			'subbody' => 180
		}
	},
	{#State 137
		ACTIONS => {
			'OROP' => 110,
			")" => 183,
			'ANDOP' => 108
		}
	},
	{#State 138
		DEFAULT => -94
	},
	{#State 139
		ACTIONS => {
			"[" => 184
		},
		DEFAULT => -82
	},
	{#State 140
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 185,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 141
		ACTIONS => {
			'OROP' => 110,
			")" => 186,
			'ANDOP' => 108
		}
	},
	{#State 142
		DEFAULT => -104
	},
	{#State 143
		DEFAULT => -3,
		GOTOS => {
			'remember' => 187
		}
	},
	{#State 144
		ACTIONS => {
			"\$" => 16
		},
		GOTOS => {
			'scalar' => 188,
			'my_scalar' => 189
		}
	},
	{#State 145
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			";" => -29,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'error' => 43,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 190,
			'scalar' => 6,
			'sideff' => 192,
			'term' => 38,
			'ary' => 12,
			'expr' => 193,
			'nexpr' => 194,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20,
			'arylen' => 47,
			'mnexpr' => 191,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'argexpr' => 55
		}
	},
	{#State 146
		DEFAULT => -96
	},
	{#State 147
		ACTIONS => {
			'ADDOP' => 101,
			'ASSIGNOP' => 95,
			'POSTINC' => 102,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 103,
			'DOTDOT' => 104,
			'MULOP' => 105,
			'ANDAND' => 98,
			'OROR' => 106,
			'RELOP' => 100,
			'EQOP' => 99
		},
		DEFAULT => -64
	},
	{#State 148
		ACTIONS => {
			'POSTINC' => 102,
			'POWOP' => 96,
			'POSTDEC' => 103
		},
		DEFAULT => -65
	},
	{#State 149
		ACTIONS => {
			'POSTINC' => 102,
			'POWOP' => 96,
			'POSTDEC' => 103
		},
		DEFAULT => -73
	},
	{#State 150
		ACTIONS => {
			'ADDOP' => 101,
			'POSTINC' => 102,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 103,
			'MULOP' => 105,
			'RELOP' => 100,
			'EQOP' => 99
		},
		DEFAULT => -71
	},
	{#State 151
		ACTIONS => {
			'ADDOP' => 101,
			'POSTINC' => 102,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 103,
			'MULOP' => 105,
			'RELOP' => 100,
			'EQOP' => undef
		},
		DEFAULT => -69
	},
	{#State 152
		ACTIONS => {
			'ADDOP' => 101,
			'POSTINC' => 102,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 103,
			'MULOP' => 105,
			'RELOP' => undef
		},
		DEFAULT => -68
	},
	{#State 153
		ACTIONS => {
			'POSTINC' => 102,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 103,
			'MULOP' => 105
		},
		DEFAULT => -67
	},
	{#State 154
		ACTIONS => {
			'ADDOP' => 101,
			'POSTINC' => 102,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 103,
			'DOTDOT' => undef,
			'MULOP' => 105,
			'ANDAND' => 98,
			'OROR' => 106,
			'RELOP' => 100,
			'EQOP' => 99
		},
		DEFAULT => -70
	},
	{#State 155
		ACTIONS => {
			'POSTINC' => 102,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 103
		},
		DEFAULT => -66
	},
	{#State 156
		ACTIONS => {
			'ADDOP' => 101,
			'POSTINC' => 102,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 103,
			'MULOP' => 105,
			'ANDAND' => 98,
			'RELOP' => 100,
			'EQOP' => 99
		},
		DEFAULT => -72
	},
	{#State 157
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 195,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 158
		ACTIONS => {
			")" => 196
		}
	},
	{#State 159
		ACTIONS => {
			'OROP' => 110,
			"," => 197,
			'ANDOP' => 108
		},
		DEFAULT => -120
	},
	{#State 160
		DEFAULT => -53
	},
	{#State 161
		ACTIONS => {
			'OROP' => 110,
			'ANDOP' => 108
		},
		DEFAULT => -14
	},
	{#State 162
		ACTIONS => {
			'ANDOP' => 108
		},
		DEFAULT => -54
	},
	{#State 163
		ACTIONS => {
			'OROP' => 110,
			'ANDOP' => 108
		},
		DEFAULT => -16
	},
	{#State 164
		ACTIONS => {
			'OROP' => 110,
			'ANDOP' => 108
		},
		DEFAULT => -15
	},
	{#State 165
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		DEFAULT => -31,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 200,
			'texpr' => 198,
			'termbinop' => 18,
			'mtexpr' => 199,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 166
		DEFAULT => -103
	},
	{#State 167
		ACTIONS => {
			"}" => 201,
			"-" => 5,
			'WORD' => 4,
			'PACKAGE' => 8,
			"\@" => 7,
			'FOR' => 34,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			'IF' => 17,
			"\$" => 16,
			'error' => 43,
			'LOOPEX' => 42,
			'WHILE' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FORMAT' => 24,
			'FUNC0' => 46,
			'SUB' => 26,
			"{" => 50,
			'UNIOP' => 49,
			"&" => 48,
			'USE' => 52,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 32,
			'sideff' => 33,
			'term' => 38,
			'loop' => 13,
			'ary' => 12,
			'expr' => 40,
			'use' => 41,
			'decl' => 15,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20,
			'line' => 21,
			'cond' => 25,
			'arylen' => 47,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'package' => 51,
			'format' => 53,
			'block' => 54,
			'argexpr' => 55
		}
	},
	{#State 168
		ACTIONS => {
			'WORD' => 202
		}
	},
	{#State 169
		DEFAULT => -22
	},
	{#State 170
		ACTIONS => {
			'ADDOP' => 101,
			'ASSIGNOP' => 95,
			'POSTINC' => 102,
			'POWOP' => 96,
			'MATCHOP' => 97,
			'POSTDEC' => 103,
			'DOTDOT' => 104,
			'MULOP' => 105,
			'ANDAND' => 98,
			'OROR' => 106,
			'RELOP' => 100,
			'EQOP' => 99
		},
		DEFAULT => -57
	},
	{#State 171
		DEFAULT => -63
	},
	{#State 172
		DEFAULT => -112
	},
	{#State 173
		DEFAULT => -91
	},
	{#State 174
		ACTIONS => {
			"}" => 203
		}
	},
	{#State 175
		ACTIONS => {
			")" => 204
		}
	},
	{#State 176
		ACTIONS => {
			'OROP' => 110,
			'ANDOP' => 108
		},
		DEFAULT => -33
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
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 205,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 178
		DEFAULT => -106
	},
	{#State 179
		DEFAULT => -40
	},
	{#State 180
		DEFAULT => -43
	},
	{#State 181
		DEFAULT => -48
	},
	{#State 182
		DEFAULT => -47
	},
	{#State 183
		DEFAULT => -95
	},
	{#State 184
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 206,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 185
		ACTIONS => {
			'OROP' => 110,
			"]" => 207,
			'ANDOP' => 108
		}
	},
	{#State 186
		DEFAULT => -105
	},
	{#State 187
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 208,
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 176,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 188
		DEFAULT => -122
	},
	{#State 189
		ACTIONS => {
			"(" => 209
		}
	},
	{#State 190
		ACTIONS => {
			")" => 210
		}
	},
	{#State 191
		ACTIONS => {
			";" => 211
		}
	},
	{#State 192
		DEFAULT => -30
	},
	{#State 193
		ACTIONS => {
			'FOR' => 111,
			'OROP' => 110,
			'ANDOP' => 108,
			'IF' => 109,
			")" => -33,
			'WHILE' => 112
		},
		DEFAULT => -13
	},
	{#State 194
		DEFAULT => -34
	},
	{#State 195
		ACTIONS => {
			'OROP' => 110,
			")" => 212,
			'ANDOP' => 108
		}
	},
	{#State 196
		DEFAULT => -62
	},
	{#State 197
		DEFAULT => -121
	},
	{#State 198
		DEFAULT => -35
	},
	{#State 199
		ACTIONS => {
			")" => 213
		}
	},
	{#State 200
		ACTIONS => {
			'OROP' => 110,
			'ANDOP' => 108
		},
		DEFAULT => -32
	},
	{#State 201
		DEFAULT => -2
	},
	{#State 202
		ACTIONS => {
			'WORD' => 214
		}
	},
	{#State 203
		DEFAULT => -92
	},
	{#State 204
		ACTIONS => {
			"{" => 215
		},
		GOTOS => {
			'mblock' => 216
		}
	},
	{#State 205
		ACTIONS => {
			'MATCHOP' => 97,
			'POSTDEC' => 103,
			'MULOP' => 105,
			'DOTDOT' => 104,
			'ADDOP' => 101,
			'ASSIGNOP' => 95,
			'OROR' => 106,
			'ANDAND' => 98,
			'POSTINC' => 102,
			")" => 217,
			'POWOP' => 96,
			'EQOP' => 99,
			'RELOP' => 100
		}
	},
	{#State 206
		ACTIONS => {
			'OROP' => 110,
			"]" => 218,
			'ANDOP' => 108
		}
	},
	{#State 207
		DEFAULT => -90
	},
	{#State 208
		ACTIONS => {
			")" => 219
		}
	},
	{#State 209
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 220,
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 176,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 210
		ACTIONS => {
			"{" => 215
		},
		GOTOS => {
			'mblock' => 221
		}
	},
	{#State 211
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		DEFAULT => -31,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 200,
			'texpr' => 198,
			'termbinop' => 18,
			'mtexpr' => 222,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 212
		DEFAULT => -60
	},
	{#State 213
		ACTIONS => {
			"{" => 215
		},
		GOTOS => {
			'mblock' => 223
		}
	},
	{#State 214
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		DEFAULT => -117,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 74,
			'listop' => 44,
			'listexpr' => 224,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 215
		DEFAULT => -5,
		GOTOS => {
			'mremember' => 225
		}
	},
	{#State 216
		ACTIONS => {
			'ELSE' => 226,
			'ELSIF' => 228
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 227
		}
	},
	{#State 217
		DEFAULT => -107
	},
	{#State 218
		DEFAULT => -89
	},
	{#State 219
		ACTIONS => {
			"{" => 215
		},
		GOTOS => {
			'mblock' => 229
		}
	},
	{#State 220
		ACTIONS => {
			")" => 230
		}
	},
	{#State 221
		ACTIONS => {
			'CONTINUE' => 120
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 231
		}
	},
	{#State 222
		ACTIONS => {
			";" => 232
		}
	},
	{#State 223
		ACTIONS => {
			'CONTINUE' => 120
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
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 235
		}
	},
	{#State 226
		ACTIONS => {
			"{" => 215
		},
		GOTOS => {
			'mblock' => 236
		}
	},
	{#State 227
		DEFAULT => -20
	},
	{#State 228
		ACTIONS => {
			"(" => 237
		}
	},
	{#State 229
		ACTIONS => {
			'CONTINUE' => 120
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 238
		}
	},
	{#State 230
		ACTIONS => {
			"{" => 215
		},
		GOTOS => {
			'mblock' => 239
		}
	},
	{#State 231
		DEFAULT => -26
	},
	{#State 232
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'error' => 43,
			'LOOPEX' => 42,
			")" => -29,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'sideff' => 192,
			'term' => 38,
			'ary' => 12,
			'expr' => 40,
			'nexpr' => 194,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20,
			'arylen' => 47,
			'mnexpr' => 240,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'argexpr' => 55
		}
	},
	{#State 233
		DEFAULT => -23
	},
	{#State 234
		DEFAULT => -52
	},
	{#State 235
		ACTIONS => {
			"}" => 241,
			"-" => 5,
			'WORD' => 4,
			'PACKAGE' => 8,
			"\@" => 7,
			'FOR' => 34,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			'IF' => 17,
			"\$" => 16,
			'error' => 43,
			'LOOPEX' => 42,
			'WHILE' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FORMAT' => 24,
			'FUNC0' => 46,
			'SUB' => 26,
			"{" => 50,
			'UNIOP' => 49,
			"&" => 48,
			'USE' => 52,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'subrout' => 32,
			'sideff' => 33,
			'term' => 38,
			'loop' => 13,
			'ary' => 12,
			'expr' => 40,
			'use' => 41,
			'decl' => 15,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20,
			'line' => 21,
			'cond' => 25,
			'arylen' => 47,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'package' => 51,
			'format' => 53,
			'block' => 54,
			'argexpr' => 55
		}
	},
	{#State 236
		DEFAULT => -18
	},
	{#State 237
		ACTIONS => {
			"-" => 5,
			'WORD' => 4,
			"\@" => 7,
			"+" => 35,
			'MY' => 10,
			"%" => 9,
			'NOAMP' => 36,
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 46,
			'UNIOP' => 49,
			"&" => 48,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 242,
			'scalar' => 6,
			'arylen' => 47,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 176,
			'termbinop' => 18,
			'argexpr' => 55,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 238
		DEFAULT => -25
	},
	{#State 239
		ACTIONS => {
			'CONTINUE' => 120
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 243
		}
	},
	{#State 240
		ACTIONS => {
			")" => 244
		}
	},
	{#State 241
		DEFAULT => -4
	},
	{#State 242
		ACTIONS => {
			")" => 245
		}
	},
	{#State 243
		DEFAULT => -24
	},
	{#State 244
		ACTIONS => {
			"{" => 215
		},
		GOTOS => {
			'mblock' => 246
		}
	},
	{#State 245
		ACTIONS => {
			"{" => 215
		},
		GOTOS => {
			'mblock' => 247
		}
	},
	{#State 246
		DEFAULT => -27
	},
	{#State 247
		ACTIONS => {
			'ELSE' => 226,
			'ELSIF' => 228
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 248
		}
	},
	{#State 248
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
#line 109 "plpy.y"
{/* $$ = $1; newPROG(block_end($1,$2)); */}
	],
	[#Rule 2
		 'block', 4,
sub
#line 114 "plpy.y"
{ /* if (PL_copline > (line_t)$1)
			      PL_copline = (line_t)$1;
			  $$ = block_end($2, $3); */ }
	],
	[#Rule 3
		 'remember', 0,
sub
#line 120 "plpy.y"
{/* $$ = block_start(TRUE); */}
	],
	[#Rule 4
		 'mblock', 4,
sub
#line 124 "plpy.y"
{/* if (PL_copline > (line_t)$1)
			      PL_copline = (line_t)$1;
			  $$ = block_end($2, $3); */}
	],
	[#Rule 5
		 'mremember', 0,
sub
#line 130 "plpy.y"
{/* $$ = block_start(FALSE); */}
	],
	[#Rule 6
		 'lineseq', 0,
sub
#line 135 "plpy.y"
{/* $$ = Nullop;*/ }
	],
	[#Rule 7
		 'lineseq', 2,
sub
#line 137 "plpy.y"
{/* $$ = $1;*/ }
	],
	[#Rule 8
		 'lineseq', 2,
sub
#line 139 "plpy.y"
{/*   $$ = append_list(OP_LINESEQ,
				(LISTOP*)$1, (LISTOP*)$2);
			    PL_pad_reset_pending = TRUE;
			    if ($1 && $2) PL_hints |= HINT_BLOCK_SCOPE;*/ }
	],
	[#Rule 9
		 'line', 1,
sub
#line 147 "plpy.y"
{/* $$ = newSTATEOP(0, $1, $2); */}
	],
	[#Rule 10
		 'line', 1, undef
	],
	[#Rule 11
		 'line', 2,
sub
#line 160 "plpy.y"
{ $$ = newSTATEOP(0, $1, $2);
			  PL_expect = XSTATE; }
	],
	[#Rule 12
		 'sideff', 1,
sub
#line 166 "plpy.y"
{/* $$ = Nullop; */}
	],
	[#Rule 13
		 'sideff', 1,
sub
#line 168 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 14
		 'sideff', 3,
sub
#line 170 "plpy.y"
{ $$ = newLOGOP(OP_AND, 0, $3, $1); }
	],
	[#Rule 15
		 'sideff', 3,
sub
#line 176 "plpy.y"
{/* $$ = newLOOPOP(OPf_PARENS, 1, scalar($3), $1); */}
	],
	[#Rule 16
		 'sideff', 3,
sub
#line 182 "plpy.y"
{/* $$ = newFOROP(0, Nullch, (line_t)$2,
					Nullop, $3, $1, Nullop); */}
	],
	[#Rule 17
		 'else', 0,
sub
#line 188 "plpy.y"
{/* $$ = Nullop; */}
	],
	[#Rule 18
		 'else', 2,
sub
#line 190 "plpy.y"
{/* ($2)->op_flags |= OPf_PARENS; $$ = scope($2); */}
	],
	[#Rule 19
		 'else', 6,
sub
#line 192 "plpy.y"
{/* PL_copline = (line_t)$1;
			    $$ = newCONDOP(0, $3, scope($5), $6);
			    PL_hints |= HINT_BLOCK_SCOPE; */}
	],
	[#Rule 20
		 'cond', 7,
sub
#line 199 "plpy.y"
{ /*PL_copline = (line_t)$1;
			    $$ = block_end($3,
				   newCONDOP(0, $4, scope($6), $7)); */}
	],
	[#Rule 21
		 'cont', 0,
sub
#line 212 "plpy.y"
{/* $$ = Nullop; */}
	],
	[#Rule 22
		 'cont', 2,
sub
#line 214 "plpy.y"
{/* $$ = scope($2); */}
	],
	[#Rule 23
		 'loop', 7,
sub
#line 219 "plpy.y"
{/* PL_copline = (line_t)$2;
			    $$ = block_end($4,
				   newSTATEOP(0, $1,
				     newWHILEOP(0, 1, (LOOP*)Nullop,
						$2, $5, $7, $8))); */}
	],
	[#Rule 24
		 'loop', 9,
sub
#line 233 "plpy.y"
{/* $$ = block_end($4,
				 newFOROP(0, $1, (line_t)$2, $5, $7, $9, $10)); */}
	],
	[#Rule 25
		 'loop', 8,
sub
#line 236 "plpy.y"
{/* $$ = block_end($5,
				 newFOROP(0, $1, (line_t)$2, mod($3, OP_ENTERLOOP),
					  $6, $8, $9)); */}
	],
	[#Rule 26
		 'loop', 7,
sub
#line 240 "plpy.y"
{/* $$ = block_end($4,
				 newFOROP(0, $1, (line_t)$2, Nullop, $5, $7, $8)); */}
	],
	[#Rule 27
		 'loop', 10,
sub
#line 244 "plpy.y"
{/* OP *forop;
			  PL_copline = (line_t)$2;
			  forop = newSTATEOP(0, $1,
					    newWHILEOP(0, 1, (LOOP*)Nullop,
						$2, scalar($7),
						$11, $9));
			  if ($5) {
				forop = append_elem(OP_LINESEQ,
                                        newSTATEOP(0, ($1?savepv($1):Nullch),
						   $5),
					forop);
			  }

			  $$ = block_end($4, forop); */}
	],
	[#Rule 28
		 'loop', 2,
sub
#line 259 "plpy.y"
{/* $$ = newSTATEOP(0, $1,
				 newWHILEOP(0, 1, (LOOP*)Nullop,
					    NOLINE, Nullop, $2, $3)); */}
	],
	[#Rule 29
		 'nexpr', 0,
sub
#line 266 "plpy.y"
{/* $$ = Nullop; */}
	],
	[#Rule 30
		 'nexpr', 1, undef
	],
	[#Rule 31
		 'texpr', 0,
sub
#line 272 "plpy.y"
{/* (void)scan_num("1", &yylval); $$ = yylval.opval; */}
	],
	[#Rule 32
		 'texpr', 1, undef
	],
	[#Rule 33
		 'mexpr', 1,
sub
#line 285 "plpy.y"
{/* $$ = $1; intro_my(); */}
	],
	[#Rule 34
		 'mnexpr', 1,
sub
#line 289 "plpy.y"
{/* $$ = $1; intro_my(); */}
	],
	[#Rule 35
		 'mtexpr', 1,
sub
#line 293 "plpy.y"
{/* $$ = $1; intro_my(); */}
	],
	[#Rule 36
		 'decl', 1,
sub
#line 311 "plpy.y"
{/* $$ = 0; */}
	],
	[#Rule 37
		 'decl', 1,
sub
#line 313 "plpy.y"
{/* $$ = 0; */}
	],
	[#Rule 38
		 'decl', 1,
sub
#line 319 "plpy.y"
{/* $$ = 0; */}
	],
	[#Rule 39
		 'decl', 1,
sub
#line 321 "plpy.y"
{/* $$ = 0; */}
	],
	[#Rule 40
		 'format', 4,
sub
#line 325 "plpy.y"
{/* newFORM($2, $3, $4); */}
	],
	[#Rule 41
		 'formname', 1,
sub
#line 328 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 42
		 'formname', 0,
sub
#line 329 "plpy.y"
{/* $$ = Nullop; */}
	],
	[#Rule 43
		 'subrout', 4,
sub
#line 341 "plpy.y"
{/* newATTRSUB($2, $3, $4, $5, $6); */}
	],
	[#Rule 44
		 'startsub', 0,
sub
#line 345 "plpy.y"
{/* $$ = start_subparse(FALSE, 0); */}
	],
	[#Rule 45
		 'startformsub', 0,
sub
#line 355 "plpy.y"
{/* $$ = start_subparse(TRUE, 0); */}
	],
	[#Rule 46
		 'subname', 1,
sub
#line 359 "plpy.y"
{ /*STRLEN n_a; char *name = SvPV(((SVOP*)$1)->op_sv,n_a);
			  if (strEQ(name, "BEGIN") || strEQ(name, "END")
			      || strEQ(name, "INIT") || strEQ(name, "CHECK"))
			      CvSPECIAL_on(PL_compcv);
			  $$ = $1; */}
	],
	[#Rule 47
		 'subbody', 1,
sub
#line 395 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 48
		 'subbody', 1,
sub
#line 396 "plpy.y"
{/* $$ = Nullop; PL_expect = XSTATE; */}
	],
	[#Rule 49
		 'package', 3,
sub
#line 400 "plpy.y"
{/* package($2); */}
	],
	[#Rule 50
		 'package', 2,
sub
#line 402 "plpy.y"
{/* package(Nullop); */}
	],
	[#Rule 51
		 '@1-2', 0,
sub
#line 406 "plpy.y"
{/* CvSPECIAL_on(PL_compcv); /* It's a BEGIN {} */ */}
	],
	[#Rule 52
		 'use', 7,
sub
#line 408 "plpy.y"
{/* utilize($1, $2, $4, $5, $6); */}
	],
	[#Rule 53
		 'expr', 3,
sub
#line 413 "plpy.y"
{/* $$ = newLOGOP(OP_AND, 0, $1, $3); */}
	],
	[#Rule 54
		 'expr', 3,
sub
#line 415 "plpy.y"
{/* $$ = newLOGOP($2, 0, $1, $3); */}
	],
	[#Rule 55
		 'expr', 1, undef
	],
	[#Rule 56
		 'argexpr', 2,
sub
#line 421 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 57
		 'argexpr', 3,
sub
#line 423 "plpy.y"
{/* $$ = append_elem(OP_LIST, $1, $3); */}
	],
	[#Rule 58
		 'argexpr', 1, undef
	],
	[#Rule 59
		 'listop', 3,
sub
#line 429 "plpy.y"
{/* $$ = convert($1, OPf_STACKED,
				prepend_elem(OP_LIST, newGVREF($1,$2), $3) ); */}
	],
	[#Rule 60
		 'listop', 5,
sub
#line 432 "plpy.y"
{/* $$ = convert($1, OPf_STACKED,
				prepend_elem(OP_LIST, newGVREF($1,$3), $4) ); */}
	],
	[#Rule 61
		 'listop', 2,
sub
#line 456 "plpy.y"
{/* $$ = convert($1, 0, $2); */}
	],
	[#Rule 62
		 'listop', 4,
sub
#line 458 "plpy.y"
{/* $$ = convert($1, 0, $3); */}
	],
	[#Rule 63
		 'subscripted', 4,
sub
#line 486 "plpy.y"
{/* $$ = newBINOP(OP_AELEM, 0, oopsAV($1), scalar($3)); */}
	],
	[#Rule 64
		 'termbinop', 3,
sub
#line 529 "plpy.y"
{/* $$ = newASSIGNOP(OPf_STACKED, $1, $2, $3); */}
	],
	[#Rule 65
		 'termbinop', 3,
sub
#line 531 "plpy.y"
{/* $$ = newBINOP($2, 0, scalar($1), scalar($3)); */}
	],
	[#Rule 66
		 'termbinop', 3,
sub
#line 533 "plpy.y"
{/*   if ($2 != OP_REPEAT)
				scalar($1);
			    $$ = newBINOP($2, 0, $1, scalar($3)); */}
	],
	[#Rule 67
		 'termbinop', 3,
sub
#line 537 "plpy.y"
{/* $$ = newBINOP($2, 0, scalar($1), scalar($3)); */}
	],
	[#Rule 68
		 'termbinop', 3,
sub
#line 543 "plpy.y"
{/* $$ = newBINOP($2, 0, scalar($1), scalar($3)); */}
	],
	[#Rule 69
		 'termbinop', 3,
sub
#line 545 "plpy.y"
{/* $$ = newBINOP($2, 0, scalar($1), scalar($3)); */}
	],
	[#Rule 70
		 'termbinop', 3,
sub
#line 553 "plpy.y"
{/* $$ = newRANGE($2, scalar($1), scalar($3));*/}
	],
	[#Rule 71
		 'termbinop', 3,
sub
#line 555 "plpy.y"
{/* $$ = newLOGOP(OP_AND, 0, $1, $3); */}
	],
	[#Rule 72
		 'termbinop', 3,
sub
#line 557 "plpy.y"
{/* $$ = newLOGOP(OP_OR, 0, $1, $3); */}
	],
	[#Rule 73
		 'termbinop', 3,
sub
#line 559 "plpy.y"
{/* $$ = bind_match($2, $1, $3); */}
	],
	[#Rule 74
		 'termunop', 2,
sub
#line 564 "plpy.y"
{/* $$ = newUNOP(OP_NEGATE, 0, scalar($2)); */}
	],
	[#Rule 75
		 'termunop', 2,
sub
#line 566 "plpy.y"
{/* $$ = $2; */}
	],
	[#Rule 76
		 'termunop', 2,
sub
#line 568 "plpy.y"
{/* $$ = newUNOP(OP_NOT, 0, scalar($2)); */}
	],
	[#Rule 77
		 'termunop', 2,
sub
#line 574 "plpy.y"
{ /*$$ = newUNOP(OP_POSTINC, 0,
					mod(scalar($1), OP_POSTINC)); */}
	],
	[#Rule 78
		 'termunop', 2,
sub
#line 577 "plpy.y"
{ /*$$ = newUNOP(OP_POSTDEC, 0,
					mod(scalar($1), OP_POSTDEC)); */}
	],
	[#Rule 79
		 'term', 1, undef
	],
	[#Rule 80
		 'term', 1, undef
	],
	[#Rule 81
		 'term', 1,
sub
#line 653 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 82
		 'term', 3,
sub
#line 659 "plpy.y"
{/* $$ = sawparens($2); */}
	],
	[#Rule 83
		 'term', 2,
sub
#line 661 "plpy.y"
{/* $$ = sawparens(newNULLLIST()); */}
	],
	[#Rule 84
		 'term', 1,
sub
#line 663 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 85
		 'term', 1,
sub
#line 669 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 86
		 'term', 1,
sub
#line 671 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 87
		 'term', 1,
sub
#line 673 "plpy.y"
{/* $$ = newUNOP(OP_AV2ARYLEN, 0, ref($1, OP_AV2ARYLEN));*/}
	],
	[#Rule 88
		 'term', 1,
sub
#line 675 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 89
		 'term', 6,
sub
#line 677 "plpy.y"
{/* $$ = newSLICEOP(0, $5, $2); */}
	],
	[#Rule 90
		 'term', 5,
sub
#line 679 "plpy.y"
{/* $$ = newSLICEOP(0, $4, Nullop); */}
	],
	[#Rule 91
		 'term', 4,
sub
#line 681 "plpy.y"
{ /*$$ = prepend_elem(OP_ASLICE,
				newOP(OP_PUSHMARK, 0),
				    newLISTOP(OP_ASLICE, 0,
					list($3),
					ref($1, OP_ASLICE))); */}
	],
	[#Rule 92
		 'term', 5,
sub
#line 687 "plpy.y"
{ /*$$ = prepend_elem(OP_HSLICE,
				newOP(OP_PUSHMARK, 0),
				    newLISTOP(OP_HSLICE, 0,
					list($3),
					ref(oopsHV($1), OP_HSLICE)));
			    PL_expect = XOPERATOR; */}
	],
	[#Rule 93
		 'term', 1,
sub
#line 698 "plpy.y"
{/* $$ = newUNOP(OP_ENTERSUB, 0, scalar($1)); */}
	],
	[#Rule 94
		 'term', 3,
sub
#line 700 "plpy.y"
{/* $$ = newUNOP(OP_ENTERSUB, OPf_STACKED, scalar($1)); */}
	],
	[#Rule 95
		 'term', 4,
sub
#line 702 "plpy.y"
{/* $$ = newUNOP(OP_ENTERSUB, OPf_STACKED,
			    append_elem(OP_LIST, $3, scalar($1))); */}
	],
	[#Rule 96
		 'term', 3,
sub
#line 705 "plpy.y"
{/* $$ = newUNOP(OP_ENTERSUB, OPf_STACKED,
			    append_elem(OP_LIST, $3, scalar($2))); */}
	],
	[#Rule 97
		 'term', 1,
sub
#line 708 "plpy.y"
{/* $$ = newOP($1, OPf_SPECIAL);
			    PL_hints |= HINT_BLOCK_SCOPE; */}
	],
	[#Rule 98
		 'term', 2,
sub
#line 715 "plpy.y"
{/* $$ = newUNOP(OP_NOT, 0, scalar($2)); */}
	],
	[#Rule 99
		 'term', 1,
sub
#line 717 "plpy.y"
{/* $$ = newOP($1, 0); */}
	],
	[#Rule 100
		 'term', 2,
sub
#line 719 "plpy.y"
{/* $$ = newUNOP($1, 0, $2); */}
	],
	[#Rule 101
		 'term', 2,
sub
#line 721 "plpy.y"
{/* $$ = newUNOP($1, 0, $2); */}
	],
	[#Rule 102
		 'term', 1,
sub
#line 728 "plpy.y"
{/* $$ = newOP($1, 0); */}
	],
	[#Rule 103
		 'term', 3,
sub
#line 730 "plpy.y"
{/* $$ = newOP($1, 0); */}
	],
	[#Rule 104
		 'term', 3,
sub
#line 737 "plpy.y"
{/* $$ = $1 == OP_NOT ? newUNOP($1, 0, newSVOP(OP_CONST, 0, newSViv(0)))
					    : newOP($1, OPf_SPECIAL); */}
	],
	[#Rule 105
		 'term', 4,
sub
#line 740 "plpy.y"
{/* $$ = newUNOP($1, 0, $3); */}
	],
	[#Rule 106
		 'term', 4,
sub
#line 742 "plpy.y"
{/* $$ = pmruntime($1, $3, Nullop); */}
	],
	[#Rule 107
		 'term', 6,
sub
#line 744 "plpy.y"
{/* $$ = pmruntime($1, $3, $5); */}
	],
	[#Rule 108
		 'term', 1, undef
	],
	[#Rule 109
		 'term', 1, undef
	],
	[#Rule 110
		 'myattrterm', 3,
sub
#line 751 "plpy.y"
{/* $$ = my_attrs($2,$3); */}
	],
	[#Rule 111
		 'myattrterm', 2,
sub
#line 753 "plpy.y"
{/* $$ = localize($2,$1); */}
	],
	[#Rule 112
		 'myterm', 3,
sub
#line 758 "plpy.y"
{/* $$ = sawparens($2); */}
	],
	[#Rule 113
		 'myterm', 2,
sub
#line 760 "plpy.y"
{/* $$ = sawparens(newNULLLIST()); */}
	],
	[#Rule 114
		 'myterm', 1,
sub
#line 762 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 115
		 'myterm', 1,
sub
#line 764 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 116
		 'myterm', 1,
sub
#line 766 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 117
		 'listexpr', 0,
sub
#line 771 "plpy.y"
{/* $$ = Nullop; */}
	],
	[#Rule 118
		 'listexpr', 1,
sub
#line 773 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 119
		 'listexprcom', 0,
sub
#line 777 "plpy.y"
{/* $$ = Nullop; */}
	],
	[#Rule 120
		 'listexprcom', 1,
sub
#line 779 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 121
		 'listexprcom', 2,
sub
#line 781 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 122
		 'my_scalar', 1,
sub
#line 787 "plpy.y"
{/* PL_in_my = 0; $$ = my($1); */}
	],
	[#Rule 123
		 'amper', 2,
sub
#line 791 "plpy.y"
{/* $$ = newCVREF($1,$2); */}
	],
	[#Rule 124
		 'scalar', 2,
sub
#line 795 "plpy.y"
{/* $$ = newSVREF($2); */}
	],
	[#Rule 125
		 'ary', 2,
sub
#line 799 "plpy.y"
{/* $$ = newAVREF($2); */}
	],
	[#Rule 126
		 'hsh', 2,
sub
#line 803 "plpy.y"
{/* $$ = newHVREF($2); */}
	],
	[#Rule 127
		 'arylen', 2,
sub
#line 807 "plpy.y"
{/* $$ = newAVREF($2); */}
	],
	[#Rule 128
		 'indirob', 1,
sub
#line 818 "plpy.y"
{/* $$ = scalar($1); */}
	],
	[#Rule 129
		 'indirob', 1,
sub
#line 820 "plpy.y"
{/* $$ = scalar($1);  */}
	],
	[#Rule 130
		 'indirob', 1,
sub
#line 822 "plpy.y"
{/* $$ = scope($1); */}
	]
],
                                  @_);
    bless($self,$class);
}

#line 829 "plpy.y"
 /* PROGRAM */

/* more stuff added to make perly_c.diff easier to apply */
/* Tokens.  
#define GRAMPROG 258
#define GRAMEXPR 259
#define GRAMBLOCK 260
#define GRAMBARESTMT 261
#define GRAMFULLSTMT 262
#define GRAMSTMTSEQ 263
#define WORD 264
#define METHOD 265
#define FUNCMETH 266
#define THING 267
#define PMFUNC 268
#define PRIVATEREF 269
#define QWLIST 270
#define FUNC0SUB 271
#define UNIOPSUB 272
#define LSTOPSUB 273
#define PLUGEXPR 274
#define PLUGSTMT 275
#define LABEL 276
#define FORMAT 277
#define SUB 278
#define ANONSUB 279
#define PACKAGE 280
#define USE 281
#define WHILE 282
#define UNTIL 283
#define IF 284
#define UNLESS 285
#define ELSE 286
#define ELSIF 287
#define CONTINUE 288
#define FOR 289
#define GIVEN 290
#define WHEN 291
#define DEFAULT 292
#define LOOPEX 293
#define DOTDOT 294
#define YADAYADA 295
#define FUNC0 296
#define FUNC1 297
#define FUNC 298
#define UNIOP 299
#define LSTOP 300
#define RELOP 301
#define EQOP 302
#define MULOP 303
#define ADDOP 304
#define DOLSHARP 305
#define DO 306
#define HASHBRACK 307
#define NOAMP 308
#define LOCAL 309
#define MY 310
#define MYSUB 311
#define REQUIRE 312
#define COLONATTR 313
#define PREC_LOW 314
#define DOROP 315
#define OROP 316
#define ANDOP 317
#define NOTOP 318
#define ASSIGNOP 319
#define DORDOR 320
#define OROR 321
#define ANDAND 322
#define BITOROP 323
#define BITANDOP 324
#define SHIFTOP 325
#define MATCHOP 326
#define REFGEN 327
#define UMINUS 328
#define POWOP 329
#define POSTDEC 330
#define POSTINC 331
#define PREDEC 332
#define PREINC 333
#define ARROW 334
#define PEG 335
*/

1;
