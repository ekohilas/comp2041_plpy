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
            ("WORD", /w+/),
            ("PMFUNC", /\/[^/]*\/|s\/[^/]*\/[^/]*\/|split/),
            ("SUB", /sub/),
            ("WHILE", /while/),
            ("IF", /if/),
            ("ELSE", /else/),
            ("ELSIF", /elsif/),
            ("CONTINUE", /next/),
            ("FOR", /for|foreach/),
            ("LOOPEX", /last/),
            ("DOTDOT", /\.\.\.?/),
            ("FUNC0", /print|printf|chomp|split|exit|pop|shift/),
            ("FUNC1", /print|printf|chomp|split|exit|pop|shift|reverse|open|sort|keys/),
            ("FUNC", /print|printf|chomp|split|join|push|unshift|open/),
            ("UNIOP", /??/),
            ("LSTOP", /??/),
            ("RELOP", />|<|<=|>=/),
            ("EQOP", /==/),
            ("MULOP", /[*x]/),
            ("ADDOP", /\+/),
            ("DOLSHARP", /\$#/), 
            ("MY", /my/),
            ("OROP", /or/),
            ("ANDOP", /and/), 
            ("NOTOP", /not/),
            (",", /,/),
            ("ASSIGNOP", /=/),
            ("OROR", /\|\|/),
            ("ANDAND", /&&/),
            ("EQOP", /==|eq/)
            ("MATCHOP", /=~/),
            ("!", /!/),
            ("POWOP", /\*\*/),
            ("POSTINC", /\+\+/),
            ("POSTDEC", /--/),
            (")", /\)/),
            ("(", /\(/),
            ("{", /\{/),
            ("}", /\}/),
            ("[", /\[/),
            ("]", /\]/)

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
			'MY' => 10,
			"%" => 9,
			'LSTOP' => 11,
			"!" => 14,
			'IF' => 17,
			"\$" => 16,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FORMAT' => 24,
			'SUB' => 26,
			"(" => 30,
			'FUNC1' => 31,
			'FOR' => 34,
			"+" => 35,
			'NOAMP' => 36,
			'DOLSHARP' => 37,
			'FUNC' => 39,
			'LOOPEX' => 42,
			'error' => 43,
			'UNIOPSUB' => 45,
			'WHILE' => 46,
			'FUNC0' => 47,
			"&" => 49,
			'UNIOP' => 50,
			"{" => 51,
			'USE' => 53
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
			'arylen' => 48,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'package' => 52,
			'format' => 54,
			'block' => 55,
			'argexpr' => 56
		}
	},
	{#State 3
		DEFAULT => 0
	},
	{#State 4
		DEFAULT => -109
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 57,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 6
		ACTIONS => {
			"[" => 58
		},
		DEFAULT => -84
	},
	{#State 7
		ACTIONS => {
			'WORD' => 60,
			"\$" => 16,
			"{" => 51
		},
		GOTOS => {
			'scalar' => 59,
			'indirob' => 61,
			'block' => 62
		}
	},
	{#State 8
		ACTIONS => {
			'WORD' => 63,
			";" => 64
		}
	},
	{#State 9
		ACTIONS => {
			'WORD' => 60,
			"\$" => 16,
			"{" => 51
		},
		GOTOS => {
			'scalar' => 59,
			'indirob' => 65,
			'block' => 62
		}
	},
	{#State 10
		ACTIONS => {
			"(" => 69,
			"\@" => 7,
			"\$" => 16,
			"%" => 9
		},
		GOTOS => {
			'scalar' => 66,
			'myterm' => 70,
			'hsh' => 68,
			'ary' => 67
		}
	},
	{#State 11
		ACTIONS => {
			"-" => 5,
			'WORD' => 71,
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
			'UNIOPSUB' => 45,
			'FUNC0' => 47,
			"&" => 49,
			'UNIOP' => 50,
			"{" => 51
		},
		DEFAULT => -118,
		GOTOS => {
			'scalar' => 72,
			'arylen' => 48,
			'indirob' => 73,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'termbinop' => 18,
			'block' => 62,
			'argexpr' => 75,
			'listop' => 44,
			'listexpr' => 74,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 12
		ACTIONS => {
			"[" => 76,
			"{" => 77
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 78,
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
			'WORD' => 60,
			"\$" => 16,
			"{" => 51
		},
		GOTOS => {
			'scalar' => 59,
			'indirob' => 79,
			'block' => 62
		}
	},
	{#State 17
		ACTIONS => {
			"(" => 80
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
			"(" => 81
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 82,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 24
		DEFAULT => -45,
		GOTOS => {
			'startformsub' => 83
		}
	},
	{#State 25
		DEFAULT => -9
	},
	{#State 26
		DEFAULT => -44,
		GOTOS => {
			'startsub' => 84
		}
	},
	{#State 27
		ACTIONS => {
			"(" => 85
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
			")" => 87,
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 86,
			'termbinop' => 18,
			'argexpr' => 56,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 31
		ACTIONS => {
			"(" => 88
		}
	},
	{#State 32
		DEFAULT => -37
	},
	{#State 33
		ACTIONS => {
			";" => 89
		}
	},
	{#State 34
		ACTIONS => {
			"(" => 92,
			"\$" => 16,
			'MY' => 91
		},
		GOTOS => {
			'scalar' => 90
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 93,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 36
		ACTIONS => {
			'WORD' => 94
		}
	},
	{#State 37
		ACTIONS => {
			'WORD' => 60,
			"\$" => 16,
			"{" => 51
		},
		GOTOS => {
			'scalar' => 59,
			'indirob' => 95,
			'block' => 62
		}
	},
	{#State 38
		ACTIONS => {
			'ADDOP' => 102,
			'ASSIGNOP' => 96,
			'POSTINC' => 103,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 104,
			'DOTDOT' => 105,
			'MULOP' => 106,
			'ANDAND' => 99,
			'OROR' => 107,
			'RELOP' => 101,
			'EQOP' => 100
		},
		DEFAULT => -58
	},
	{#State 39
		ACTIONS => {
			"(" => 108
		}
	},
	{#State 40
		ACTIONS => {
			'FOR' => 112,
			'OROP' => 111,
			'ANDOP' => 109,
			'IF' => 110,
			'WHILE' => 113
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
		DEFAULT => -110
	},
	{#State 45
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 114,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 46
		ACTIONS => {
			"(" => 115
		}
	},
	{#State 47
		ACTIONS => {
			"(" => 116
		},
		DEFAULT => -103
	},
	{#State 48
		DEFAULT => -87
	},
	{#State 49
		ACTIONS => {
			'WORD' => 60,
			"\$" => 16,
			"{" => 51
		},
		GOTOS => {
			'scalar' => 59,
			'indirob' => 117,
			'block' => 62
		}
	},
	{#State 50
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
			'UNIOPSUB' => 45,
			'FUNC0' => 47,
			"&" => 49,
			'UNIOP' => 50,
			"{" => 51
		},
		DEFAULT => -99,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 118,
			'ary' => 12,
			'termbinop' => 18,
			'block' => 119,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 51
		DEFAULT => -3,
		GOTOS => {
			'remember' => 120
		}
	},
	{#State 52
		DEFAULT => -38
	},
	{#State 53
		DEFAULT => -44,
		GOTOS => {
			'startsub' => 121
		}
	},
	{#State 54
		DEFAULT => -36
	},
	{#State 55
		ACTIONS => {
			'CONTINUE' => 122
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 123
		}
	},
	{#State 56
		ACTIONS => {
			"," => 124
		},
		DEFAULT => -55
	},
	{#State 57
		ACTIONS => {
			'POSTINC' => 103,
			'POWOP' => 97,
			'POSTDEC' => 104
		},
		DEFAULT => -74
	},
	{#State 58
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 125,
			'termbinop' => 18,
			'argexpr' => 56,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 59
		DEFAULT => -130
	},
	{#State 60
		DEFAULT => -129
	},
	{#State 61
		DEFAULT => -126
	},
	{#State 62
		DEFAULT => -131
	},
	{#State 63
		ACTIONS => {
			";" => 126
		}
	},
	{#State 64
		DEFAULT => -50
	},
	{#State 65
		DEFAULT => -127
	},
	{#State 66
		DEFAULT => -115
	},
	{#State 67
		DEFAULT => -117
	},
	{#State 68
		DEFAULT => -116
	},
	{#State 69
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
			")" => 128,
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 127,
			'termbinop' => 18,
			'argexpr' => 56,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 70
		ACTIONS => {
			'myattrlist' => 129
		},
		DEFAULT => -112
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
			'NOTOP' => -129,
			'PMFUNC' => -129,
			"(" => -129,
			'FUNC1' => -129,
			"+" => -129,
			'NOAMP' => -129,
			'FUNC' => -129,
			'DOLSHARP' => -129,
			'LOOPEX' => -129,
			'UNIOPSUB' => -129,
			'FUNC0' => -129,
			"&" => -129,
			'UNIOP' => -129
		},
		DEFAULT => -109
	},
	{#State 72
		ACTIONS => {
			"-" => -130,
			'WORD' => -130,
			"\@" => -130,
			"%" => -130,
			'MY' => -130,
			'LSTOP' => -130,
			"!" => -130,
			"\$" => -130,
			"[" => 58,
			'NOTOP' => -130,
			'PMFUNC' => -130,
			"(" => -130,
			'FUNC1' => -130,
			"+" => -130,
			'NOAMP' => -130,
			'FUNC' => -130,
			'DOLSHARP' => -130,
			'LOOPEX' => -130,
			'UNIOPSUB' => -130,
			'FUNC0' => -130,
			"&" => -130,
			'UNIOP' => -130
		},
		DEFAULT => -84
	},
	{#State 73
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 130,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 74
		DEFAULT => -61
	},
	{#State 75
		ACTIONS => {
			"," => 124
		},
		DEFAULT => -119
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 131,
			'termbinop' => 18,
			'argexpr' => 56,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 77
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 132,
			'termbinop' => 18,
			'argexpr' => 56,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 78
		ACTIONS => {
			'POSTINC' => 103,
			'POWOP' => 97,
			'POSTDEC' => 104
		},
		DEFAULT => -76
	},
	{#State 79
		DEFAULT => -125
	},
	{#State 80
		DEFAULT => -3,
		GOTOS => {
			'remember' => 133
		}
	},
	{#State 81
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 134,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 82
		ACTIONS => {
			"," => 124
		},
		DEFAULT => -98
	},
	{#State 83
		ACTIONS => {
			'WORD' => 135
		},
		DEFAULT => -42,
		GOTOS => {
			'formname' => 136
		}
	},
	{#State 84
		ACTIONS => {
			'WORD' => 137
		},
		GOTOS => {
			'subname' => 138
		}
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
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			")" => 140,
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 139,
			'termbinop' => 18,
			'argexpr' => 56,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 86
		ACTIONS => {
			'OROP' => 111,
			")" => 141,
			'ANDOP' => 109
		}
	},
	{#State 87
		ACTIONS => {
			"[" => 142
		},
		DEFAULT => -83
	},
	{#State 88
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
			")" => 144,
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 143,
			'termbinop' => 18,
			'argexpr' => 56,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 89
		DEFAULT => -11
	},
	{#State 90
		ACTIONS => {
			"(" => 145
		}
	},
	{#State 91
		DEFAULT => -3,
		GOTOS => {
			'remember' => 146
		}
	},
	{#State 92
		DEFAULT => -3,
		GOTOS => {
			'remember' => 147
		}
	},
	{#State 93
		ACTIONS => {
			'POSTINC' => 103,
			'POWOP' => 97,
			'POSTDEC' => 104
		},
		DEFAULT => -75
	},
	{#State 94
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
			'UNIOPSUB' => 45,
			'FUNC0' => 47,
			"&" => 49,
			'UNIOP' => 50
		},
		DEFAULT => -118,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 75,
			'listop' => 44,
			'listexpr' => 148,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 95
		DEFAULT => -128
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
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
	{#State 102
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
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
	{#State 103
		DEFAULT => -77
	},
	{#State 104
		DEFAULT => -78
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 157,
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 158,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 108
		ACTIONS => {
			"-" => 5,
			'WORD' => 71,
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			"{" => 51,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		DEFAULT => -120,
		GOTOS => {
			'scalar' => 72,
			'indirob' => 159,
			'term' => 38,
			'ary' => 12,
			'expr' => 161,
			'termbinop' => 18,
			'listexprcom' => 160,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20,
			'arylen' => 48,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'block' => 62,
			'argexpr' => 56
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 162,
			'termbinop' => 18,
			'argexpr' => 56,
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 163,
			'termbinop' => 18,
			'argexpr' => 56,
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 164,
			'termbinop' => 18,
			'argexpr' => 56,
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 165,
			'termbinop' => 18,
			'argexpr' => 56,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 113
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 166,
			'termbinop' => 18,
			'argexpr' => 56,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 114
		ACTIONS => {
			'ADDOP' => 102,
			'POSTINC' => 103,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 104,
			'MULOP' => 106
		},
		DEFAULT => -102
	},
	{#State 115
		DEFAULT => -3,
		GOTOS => {
			'remember' => 167
		}
	},
	{#State 116
		ACTIONS => {
			")" => 168
		}
	},
	{#State 117
		DEFAULT => -124
	},
	{#State 118
		ACTIONS => {
			'ADDOP' => 102,
			'POSTINC' => 103,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 104,
			'MULOP' => 106
		},
		DEFAULT => -101
	},
	{#State 119
		DEFAULT => -100
	},
	{#State 120
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 169
		}
	},
	{#State 121
		DEFAULT => -51,
		GOTOS => {
			'@1-2' => 170
		}
	},
	{#State 122
		ACTIONS => {
			"{" => 51
		},
		GOTOS => {
			'block' => 171
		}
	},
	{#State 123
		DEFAULT => -28
	},
	{#State 124
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
			'UNIOPSUB' => 45,
			'FUNC0' => 47,
			"&" => 49,
			'UNIOP' => 50
		},
		DEFAULT => -56,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 172,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 125
		ACTIONS => {
			'OROP' => 111,
			"]" => 173,
			'ANDOP' => 109
		}
	},
	{#State 126
		DEFAULT => -49
	},
	{#State 127
		ACTIONS => {
			'OROP' => 111,
			")" => 174,
			'ANDOP' => 109
		}
	},
	{#State 128
		DEFAULT => -114
	},
	{#State 129
		DEFAULT => -111
	},
	{#State 130
		ACTIONS => {
			"," => 124
		},
		DEFAULT => -59
	},
	{#State 131
		ACTIONS => {
			'OROP' => 111,
			"]" => 175,
			'ANDOP' => 109
		}
	},
	{#State 132
		ACTIONS => {
			";" => 176,
			'OROP' => 111,
			'ANDOP' => 109
		}
	},
	{#State 133
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 177,
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 178,
			'termbinop' => 18,
			'argexpr' => 56,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 134
		ACTIONS => {
			'MATCHOP' => 98,
			'POSTDEC' => 104,
			'MULOP' => 106,
			'DOTDOT' => 105,
			'ADDOP' => 102,
			"," => 179,
			'ASSIGNOP' => 96,
			'OROR' => 107,
			'POSTINC' => 103,
			'ANDAND' => 99,
			")" => 180,
			'POWOP' => 97,
			'EQOP' => 100,
			'RELOP' => 101
		}
	},
	{#State 135
		DEFAULT => -41
	},
	{#State 136
		ACTIONS => {
			"{" => 51
		},
		GOTOS => {
			'block' => 181
		}
	},
	{#State 137
		DEFAULT => -46
	},
	{#State 138
		ACTIONS => {
			";" => 183,
			"{" => 51
		},
		GOTOS => {
			'block' => 184,
			'subbody' => 182
		}
	},
	{#State 139
		ACTIONS => {
			'OROP' => 111,
			")" => 185,
			'ANDOP' => 109
		}
	},
	{#State 140
		DEFAULT => -94
	},
	{#State 141
		ACTIONS => {
			"[" => 186
		},
		DEFAULT => -82
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
			'LSTOP' => 11,
			'FUNC' => 39,
			'DOLSHARP' => 37,
			"!" => 14,
			"\$" => 16,
			'LOOPEX' => 42,
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 187,
			'termbinop' => 18,
			'argexpr' => 56,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 143
		ACTIONS => {
			'OROP' => 111,
			")" => 188,
			'ANDOP' => 109
		}
	},
	{#State 144
		DEFAULT => -105
	},
	{#State 145
		DEFAULT => -3,
		GOTOS => {
			'remember' => 189
		}
	},
	{#State 146
		ACTIONS => {
			"\$" => 16
		},
		GOTOS => {
			'scalar' => 190,
			'my_scalar' => 191
		}
	},
	{#State 147
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 192,
			'scalar' => 6,
			'sideff' => 194,
			'term' => 38,
			'ary' => 12,
			'expr' => 195,
			'nexpr' => 196,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20,
			'arylen' => 48,
			'mnexpr' => 193,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'argexpr' => 56
		}
	},
	{#State 148
		DEFAULT => -96
	},
	{#State 149
		ACTIONS => {
			'ADDOP' => 102,
			'ASSIGNOP' => 96,
			'POSTINC' => 103,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 104,
			'DOTDOT' => 105,
			'MULOP' => 106,
			'ANDAND' => 99,
			'OROR' => 107,
			'RELOP' => 101,
			'EQOP' => 100
		},
		DEFAULT => -64
	},
	{#State 150
		ACTIONS => {
			'POSTINC' => 103,
			'POWOP' => 97,
			'POSTDEC' => 104
		},
		DEFAULT => -65
	},
	{#State 151
		ACTIONS => {
			'POSTINC' => 103,
			'POWOP' => 97,
			'POSTDEC' => 104
		},
		DEFAULT => -73
	},
	{#State 152
		ACTIONS => {
			'ADDOP' => 102,
			'POSTINC' => 103,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 104,
			'MULOP' => 106,
			'RELOP' => 101,
			'EQOP' => 100
		},
		DEFAULT => -71
	},
	{#State 153
		ACTIONS => {
			'ADDOP' => 102,
			'POSTINC' => 103,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 104,
			'MULOP' => 106,
			'RELOP' => 101,
			'EQOP' => undef
		},
		DEFAULT => -69
	},
	{#State 154
		ACTIONS => {
			'ADDOP' => 102,
			'POSTINC' => 103,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 104,
			'MULOP' => 106,
			'RELOP' => undef
		},
		DEFAULT => -68
	},
	{#State 155
		ACTIONS => {
			'POSTINC' => 103,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 104,
			'MULOP' => 106
		},
		DEFAULT => -67
	},
	{#State 156
		ACTIONS => {
			'ADDOP' => 102,
			'POSTINC' => 103,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 104,
			'DOTDOT' => undef,
			'MULOP' => 106,
			'ANDAND' => 99,
			'OROR' => 107,
			'RELOP' => 101,
			'EQOP' => 100
		},
		DEFAULT => -70
	},
	{#State 157
		ACTIONS => {
			'POSTINC' => 103,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 104
		},
		DEFAULT => -66
	},
	{#State 158
		ACTIONS => {
			'ADDOP' => 102,
			'POSTINC' => 103,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 104,
			'MULOP' => 106,
			'ANDAND' => 99,
			'RELOP' => 101,
			'EQOP' => 100
		},
		DEFAULT => -72
	},
	{#State 159
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 197,
			'termbinop' => 18,
			'argexpr' => 56,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 160
		ACTIONS => {
			")" => 198
		}
	},
	{#State 161
		ACTIONS => {
			'OROP' => 111,
			"," => 199,
			'ANDOP' => 109
		},
		DEFAULT => -121
	},
	{#State 162
		DEFAULT => -53
	},
	{#State 163
		ACTIONS => {
			'OROP' => 111,
			'ANDOP' => 109
		},
		DEFAULT => -14
	},
	{#State 164
		ACTIONS => {
			'ANDOP' => 109
		},
		DEFAULT => -54
	},
	{#State 165
		ACTIONS => {
			'OROP' => 111,
			'ANDOP' => 109
		},
		DEFAULT => -16
	},
	{#State 166
		ACTIONS => {
			'OROP' => 111,
			'ANDOP' => 109
		},
		DEFAULT => -15
	},
	{#State 167
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		DEFAULT => -31,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 202,
			'texpr' => 200,
			'termbinop' => 18,
			'mtexpr' => 201,
			'argexpr' => 56,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 168
		DEFAULT => -104
	},
	{#State 169
		ACTIONS => {
			"}" => 203,
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
			'WHILE' => 46,
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FORMAT' => 24,
			'FUNC0' => 47,
			'SUB' => 26,
			"{" => 51,
			'UNIOP' => 50,
			"&" => 49,
			'USE' => 53,
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
			'arylen' => 48,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'package' => 52,
			'format' => 54,
			'block' => 55,
			'argexpr' => 56
		}
	},
	{#State 170
		ACTIONS => {
			'WORD' => 204
		}
	},
	{#State 171
		DEFAULT => -22
	},
	{#State 172
		ACTIONS => {
			'ADDOP' => 102,
			'ASSIGNOP' => 96,
			'POSTINC' => 103,
			'POWOP' => 97,
			'MATCHOP' => 98,
			'POSTDEC' => 104,
			'DOTDOT' => 105,
			'MULOP' => 106,
			'ANDAND' => 99,
			'OROR' => 107,
			'RELOP' => 101,
			'EQOP' => 100
		},
		DEFAULT => -57
	},
	{#State 173
		DEFAULT => -63
	},
	{#State 174
		DEFAULT => -113
	},
	{#State 175
		DEFAULT => -91
	},
	{#State 176
		ACTIONS => {
			"}" => 205
		}
	},
	{#State 177
		ACTIONS => {
			")" => 206
		}
	},
	{#State 178
		ACTIONS => {
			'OROP' => 111,
			'ANDOP' => 109
		},
		DEFAULT => -33
	},
	{#State 179
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 207,
			'ary' => 12,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 180
		DEFAULT => -107
	},
	{#State 181
		DEFAULT => -40
	},
	{#State 182
		DEFAULT => -43
	},
	{#State 183
		DEFAULT => -48
	},
	{#State 184
		DEFAULT => -47
	},
	{#State 185
		DEFAULT => -95
	},
	{#State 186
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 208,
			'termbinop' => 18,
			'argexpr' => 56,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 187
		ACTIONS => {
			'OROP' => 111,
			"]" => 209,
			'ANDOP' => 109
		}
	},
	{#State 188
		DEFAULT => -106
	},
	{#State 189
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 210,
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 178,
			'termbinop' => 18,
			'argexpr' => 56,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 190
		DEFAULT => -123
	},
	{#State 191
		ACTIONS => {
			"(" => 211
		}
	},
	{#State 192
		ACTIONS => {
			")" => 212
		}
	},
	{#State 193
		ACTIONS => {
			";" => 213
		}
	},
	{#State 194
		DEFAULT => -30
	},
	{#State 195
		ACTIONS => {
			'FOR' => 112,
			'OROP' => 111,
			'ANDOP' => 109,
			'IF' => 110,
			")" => -33,
			'WHILE' => 113
		},
		DEFAULT => -13
	},
	{#State 196
		DEFAULT => -34
	},
	{#State 197
		ACTIONS => {
			'OROP' => 111,
			")" => 214,
			'ANDOP' => 109
		}
	},
	{#State 198
		DEFAULT => -62
	},
	{#State 199
		DEFAULT => -122
	},
	{#State 200
		DEFAULT => -35
	},
	{#State 201
		ACTIONS => {
			")" => 215
		}
	},
	{#State 202
		ACTIONS => {
			'OROP' => 111,
			'ANDOP' => 109
		},
		DEFAULT => -32
	},
	{#State 203
		DEFAULT => -2
	},
	{#State 204
		ACTIONS => {
			'WORD' => 216
		}
	},
	{#State 205
		DEFAULT => -92
	},
	{#State 206
		ACTIONS => {
			"{" => 217
		},
		GOTOS => {
			'mblock' => 218
		}
	},
	{#State 207
		ACTIONS => {
			'MATCHOP' => 98,
			'POSTDEC' => 104,
			'MULOP' => 106,
			'DOTDOT' => 105,
			'ADDOP' => 102,
			'ASSIGNOP' => 96,
			'OROR' => 107,
			'ANDAND' => 99,
			'POSTINC' => 103,
			")" => 219,
			'POWOP' => 97,
			'EQOP' => 100,
			'RELOP' => 101
		}
	},
	{#State 208
		ACTIONS => {
			'OROP' => 111,
			"]" => 220,
			'ANDOP' => 109
		}
	},
	{#State 209
		DEFAULT => -90
	},
	{#State 210
		ACTIONS => {
			")" => 221
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 222,
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 178,
			'termbinop' => 18,
			'argexpr' => 56,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 212
		ACTIONS => {
			"{" => 217
		},
		GOTOS => {
			'mblock' => 223
		}
	},
	{#State 213
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		DEFAULT => -31,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 202,
			'texpr' => 200,
			'termbinop' => 18,
			'mtexpr' => 224,
			'argexpr' => 56,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 214
		DEFAULT => -60
	},
	{#State 215
		ACTIONS => {
			"{" => 217
		},
		GOTOS => {
			'mblock' => 225
		}
	},
	{#State 216
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		DEFAULT => -118,
		GOTOS => {
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'termbinop' => 18,
			'argexpr' => 75,
			'listop' => 44,
			'listexpr' => 226,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 217
		DEFAULT => -5,
		GOTOS => {
			'mremember' => 227
		}
	},
	{#State 218
		ACTIONS => {
			'ELSE' => 228,
			'ELSIF' => 230
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 229
		}
	},
	{#State 219
		DEFAULT => -108
	},
	{#State 220
		DEFAULT => -89
	},
	{#State 221
		ACTIONS => {
			"{" => 217
		},
		GOTOS => {
			'mblock' => 231
		}
	},
	{#State 222
		ACTIONS => {
			")" => 232
		}
	},
	{#State 223
		ACTIONS => {
			'CONTINUE' => 122
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
		ACTIONS => {
			'CONTINUE' => 122
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 235
		}
	},
	{#State 226
		ACTIONS => {
			";" => 236
		}
	},
	{#State 227
		DEFAULT => -6,
		GOTOS => {
			'lineseq' => 237
		}
	},
	{#State 228
		ACTIONS => {
			"{" => 217
		},
		GOTOS => {
			'mblock' => 238
		}
	},
	{#State 229
		DEFAULT => -20
	},
	{#State 230
		ACTIONS => {
			"(" => 239
		}
	},
	{#State 231
		ACTIONS => {
			'CONTINUE' => 122
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 240
		}
	},
	{#State 232
		ACTIONS => {
			"{" => 217
		},
		GOTOS => {
			'mblock' => 241
		}
	},
	{#State 233
		DEFAULT => -26
	},
	{#State 234
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'scalar' => 6,
			'sideff' => 194,
			'term' => 38,
			'ary' => 12,
			'expr' => 40,
			'nexpr' => 196,
			'termbinop' => 18,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20,
			'arylen' => 48,
			'mnexpr' => 242,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'argexpr' => 56
		}
	},
	{#State 235
		DEFAULT => -23
	},
	{#State 236
		DEFAULT => -52
	},
	{#State 237
		ACTIONS => {
			"}" => 243,
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
			'WHILE' => 46,
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FORMAT' => 24,
			'FUNC0' => 47,
			'SUB' => 26,
			"{" => 51,
			'UNIOP' => 50,
			"&" => 49,
			'USE' => 53,
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
			'arylen' => 48,
			'amper' => 27,
			'myattrterm' => 28,
			'subscripted' => 29,
			'package' => 52,
			'format' => 54,
			'block' => 55,
			'argexpr' => 56
		}
	},
	{#State 238
		DEFAULT => -18
	},
	{#State 239
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
			'UNIOPSUB' => 45,
			'PMFUNC' => 22,
			'NOTOP' => 23,
			'FUNC0' => 47,
			'UNIOP' => 50,
			"&" => 49,
			"(" => 30,
			'FUNC1' => 31
		},
		GOTOS => {
			'mexpr' => 244,
			'scalar' => 6,
			'arylen' => 48,
			'myattrterm' => 28,
			'amper' => 27,
			'subscripted' => 29,
			'term' => 38,
			'ary' => 12,
			'expr' => 178,
			'termbinop' => 18,
			'argexpr' => 56,
			'listop' => 44,
			'hsh' => 19,
			'termunop' => 20
		}
	},
	{#State 240
		DEFAULT => -25
	},
	{#State 241
		ACTIONS => {
			'CONTINUE' => 122
		},
		DEFAULT => -21,
		GOTOS => {
			'cont' => 245
		}
	},
	{#State 242
		ACTIONS => {
			")" => 246
		}
	},
	{#State 243
		DEFAULT => -4
	},
	{#State 244
		ACTIONS => {
			")" => 247
		}
	},
	{#State 245
		DEFAULT => -24
	},
	{#State 246
		ACTIONS => {
			"{" => 217
		},
		GOTOS => {
			'mblock' => 248
		}
	},
	{#State 247
		ACTIONS => {
			"{" => 217
		},
		GOTOS => {
			'mblock' => 249
		}
	},
	{#State 248
		DEFAULT => -27
	},
	{#State 249
		ACTIONS => {
			'ELSE' => 228,
			'ELSIF' => 230
		},
		DEFAULT => -17,
		GOTOS => {
			'else' => 250
		}
	},
	{#State 250
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
#line 108 "plpy.y"
{/* $$ = $1; newPROG(block_end($1,$2)); */}
	],
	[#Rule 2
		 'block', 4,
sub
#line 113 "plpy.y"
{ /* if (PL_copline > (line_t)$1)
			      PL_copline = (line_t)$1;
			  $$ = block_end($2, $3); */ }
	],
	[#Rule 3
		 'remember', 0,
sub
#line 119 "plpy.y"
{/* $$ = block_start(TRUE); */}
	],
	[#Rule 4
		 'mblock', 4,
sub
#line 123 "plpy.y"
{/* if (PL_copline > (line_t)$1)
			      PL_copline = (line_t)$1;
			  $$ = block_end($2, $3); */}
	],
	[#Rule 5
		 'mremember', 0,
sub
#line 129 "plpy.y"
{/* $$ = block_start(FALSE); */}
	],
	[#Rule 6
		 'lineseq', 0,
sub
#line 134 "plpy.y"
{/* $$ = Nullop;*/ }
	],
	[#Rule 7
		 'lineseq', 2,
sub
#line 136 "plpy.y"
{/* $$ = $1;*/ }
	],
	[#Rule 8
		 'lineseq', 2,
sub
#line 138 "plpy.y"
{/*   $$ = append_list(OP_LINESEQ,
				(LISTOP*)$1, (LISTOP*)$2);
			    PL_pad_reset_pending = TRUE;
			    if ($1 && $2) PL_hints |= HINT_BLOCK_SCOPE;*/ }
	],
	[#Rule 9
		 'line', 1,
sub
#line 146 "plpy.y"
{/* $$ = newSTATEOP(0, $1, $2); */}
	],
	[#Rule 10
		 'line', 1, undef
	],
	[#Rule 11
		 'line', 2,
sub
#line 159 "plpy.y"
{ $$ = newSTATEOP(0, $1, $2);
			  PL_expect = XSTATE; }
	],
	[#Rule 12
		 'sideff', 1,
sub
#line 165 "plpy.y"
{/* $$ = Nullop; */}
	],
	[#Rule 13
		 'sideff', 1,
sub
#line 167 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 14
		 'sideff', 3,
sub
#line 169 "plpy.y"
{ $$ = newLOGOP(OP_AND, 0, $3, $1); }
	],
	[#Rule 15
		 'sideff', 3,
sub
#line 175 "plpy.y"
{/* $$ = newLOOPOP(OPf_PARENS, 1, scalar($3), $1); */}
	],
	[#Rule 16
		 'sideff', 3,
sub
#line 181 "plpy.y"
{/* $$ = newFOROP(0, Nullch, (line_t)$2,
					Nullop, $3, $1, Nullop); */}
	],
	[#Rule 17
		 'else', 0,
sub
#line 187 "plpy.y"
{/* $$ = Nullop; */}
	],
	[#Rule 18
		 'else', 2,
sub
#line 189 "plpy.y"
{/* ($2)->op_flags |= OPf_PARENS; $$ = scope($2); */}
	],
	[#Rule 19
		 'else', 6,
sub
#line 191 "plpy.y"
{/* PL_copline = (line_t)$1;
			    $$ = newCONDOP(0, $3, scope($5), $6);
			    PL_hints |= HINT_BLOCK_SCOPE; */}
	],
	[#Rule 20
		 'cond', 7,
sub
#line 198 "plpy.y"
{ /*PL_copline = (line_t)$1;
			    $$ = block_end($3,
				   newCONDOP(0, $4, scope($6), $7)); */}
	],
	[#Rule 21
		 'cont', 0,
sub
#line 211 "plpy.y"
{/* $$ = Nullop; */}
	],
	[#Rule 22
		 'cont', 2,
sub
#line 213 "plpy.y"
{/* $$ = scope($2); */}
	],
	[#Rule 23
		 'loop', 7,
sub
#line 218 "plpy.y"
{/* PL_copline = (line_t)$2;
			    $$ = block_end($4,
				   newSTATEOP(0, $1,
				     newWHILEOP(0, 1, (LOOP*)Nullop,
						$2, $5, $7, $8))); */}
	],
	[#Rule 24
		 'loop', 9,
sub
#line 232 "plpy.y"
{/* $$ = block_end($4,
				 newFOROP(0, $1, (line_t)$2, $5, $7, $9, $10)); */}
	],
	[#Rule 25
		 'loop', 8,
sub
#line 235 "plpy.y"
{/* $$ = block_end($5,
				 newFOROP(0, $1, (line_t)$2, mod($3, OP_ENTERLOOP),
					  $6, $8, $9)); */}
	],
	[#Rule 26
		 'loop', 7,
sub
#line 239 "plpy.y"
{/* $$ = block_end($4,
				 newFOROP(0, $1, (line_t)$2, Nullop, $5, $7, $8)); */}
	],
	[#Rule 27
		 'loop', 10,
sub
#line 243 "plpy.y"
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
#line 258 "plpy.y"
{/* $$ = newSTATEOP(0, $1,
				 newWHILEOP(0, 1, (LOOP*)Nullop,
					    NOLINE, Nullop, $2, $3)); */}
	],
	[#Rule 29
		 'nexpr', 0,
sub
#line 265 "plpy.y"
{/* $$ = Nullop; */}
	],
	[#Rule 30
		 'nexpr', 1, undef
	],
	[#Rule 31
		 'texpr', 0,
sub
#line 271 "plpy.y"
{/* (void)scan_num("1", &yylval); $$ = yylval.opval; */}
	],
	[#Rule 32
		 'texpr', 1, undef
	],
	[#Rule 33
		 'mexpr', 1,
sub
#line 284 "plpy.y"
{/* $$ = $1; intro_my(); */}
	],
	[#Rule 34
		 'mnexpr', 1,
sub
#line 288 "plpy.y"
{/* $$ = $1; intro_my(); */}
	],
	[#Rule 35
		 'mtexpr', 1,
sub
#line 292 "plpy.y"
{/* $$ = $1; intro_my(); */}
	],
	[#Rule 36
		 'decl', 1,
sub
#line 310 "plpy.y"
{/* $$ = 0; */}
	],
	[#Rule 37
		 'decl', 1,
sub
#line 312 "plpy.y"
{/* $$ = 0; */}
	],
	[#Rule 38
		 'decl', 1,
sub
#line 318 "plpy.y"
{/* $$ = 0; */}
	],
	[#Rule 39
		 'decl', 1,
sub
#line 320 "plpy.y"
{/* $$ = 0; */}
	],
	[#Rule 40
		 'format', 4,
sub
#line 324 "plpy.y"
{/* newFORM($2, $3, $4); */}
	],
	[#Rule 41
		 'formname', 1,
sub
#line 327 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 42
		 'formname', 0,
sub
#line 328 "plpy.y"
{/* $$ = Nullop; */}
	],
	[#Rule 43
		 'subrout', 4,
sub
#line 340 "plpy.y"
{/* newATTRSUB($2, $3, $4, $5, $6); */}
	],
	[#Rule 44
		 'startsub', 0,
sub
#line 344 "plpy.y"
{/* $$ = start_subparse(FALSE, 0); */}
	],
	[#Rule 45
		 'startformsub', 0,
sub
#line 354 "plpy.y"
{/* $$ = start_subparse(TRUE, 0); */}
	],
	[#Rule 46
		 'subname', 1,
sub
#line 358 "plpy.y"
{ /*STRLEN n_a; char *name = SvPV(((SVOP*)$1)->op_sv,n_a);
			  if (strEQ(name, "BEGIN") || strEQ(name, "END")
			      || strEQ(name, "INIT") || strEQ(name, "CHECK"))
			      CvSPECIAL_on(PL_compcv);
			  $$ = $1; */}
	],
	[#Rule 47
		 'subbody', 1,
sub
#line 394 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 48
		 'subbody', 1,
sub
#line 395 "plpy.y"
{/* $$ = Nullop; PL_expect = XSTATE; */}
	],
	[#Rule 49
		 'package', 3,
sub
#line 399 "plpy.y"
{/* package($2); */}
	],
	[#Rule 50
		 'package', 2,
sub
#line 401 "plpy.y"
{/* package(Nullop); */}
	],
	[#Rule 51
		 '@1-2', 0,
sub
#line 405 "plpy.y"
{/* CvSPECIAL_on(PL_compcv); /* It's a BEGIN {} */ */}
	],
	[#Rule 52
		 'use', 7,
sub
#line 407 "plpy.y"
{/* utilize($1, $2, $4, $5, $6); */}
	],
	[#Rule 53
		 'expr', 3,
sub
#line 412 "plpy.y"
{/* $$ = newLOGOP(OP_AND, 0, $1, $3); */}
	],
	[#Rule 54
		 'expr', 3,
sub
#line 414 "plpy.y"
{/* $$ = newLOGOP($2, 0, $1, $3); */}
	],
	[#Rule 55
		 'expr', 1, undef
	],
	[#Rule 56
		 'argexpr', 2,
sub
#line 420 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 57
		 'argexpr', 3,
sub
#line 422 "plpy.y"
{/* $$ = append_elem(OP_LIST, $1, $3); */}
	],
	[#Rule 58
		 'argexpr', 1, undef
	],
	[#Rule 59
		 'listop', 3,
sub
#line 428 "plpy.y"
{/* $$ = convert($1, OPf_STACKED,
				prepend_elem(OP_LIST, newGVREF($1,$2), $3) ); */}
	],
	[#Rule 60
		 'listop', 5,
sub
#line 431 "plpy.y"
{/* $$ = convert($1, OPf_STACKED,
				prepend_elem(OP_LIST, newGVREF($1,$3), $4) ); */}
	],
	[#Rule 61
		 'listop', 2,
sub
#line 455 "plpy.y"
{/* $$ = convert($1, 0, $2); */}
	],
	[#Rule 62
		 'listop', 4,
sub
#line 457 "plpy.y"
{/* $$ = convert($1, 0, $3); */}
	],
	[#Rule 63
		 'subscripted', 4,
sub
#line 485 "plpy.y"
{/* $$ = newBINOP(OP_AELEM, 0, oopsAV($1), scalar($3)); */}
	],
	[#Rule 64
		 'termbinop', 3,
sub
#line 528 "plpy.y"
{/* $$ = newASSIGNOP(OPf_STACKED, $1, $2, $3); */}
	],
	[#Rule 65
		 'termbinop', 3,
sub
#line 530 "plpy.y"
{/* $$ = newBINOP($2, 0, scalar($1), scalar($3)); */}
	],
	[#Rule 66
		 'termbinop', 3,
sub
#line 532 "plpy.y"
{/*   if ($2 != OP_REPEAT)
				scalar($1);
			    $$ = newBINOP($2, 0, $1, scalar($3)); */}
	],
	[#Rule 67
		 'termbinop', 3,
sub
#line 536 "plpy.y"
{/* $$ = newBINOP($2, 0, scalar($1), scalar($3)); */}
	],
	[#Rule 68
		 'termbinop', 3,
sub
#line 542 "plpy.y"
{/* $$ = newBINOP($2, 0, scalar($1), scalar($3)); */}
	],
	[#Rule 69
		 'termbinop', 3,
sub
#line 544 "plpy.y"
{/* $$ = newBINOP($2, 0, scalar($1), scalar($3)); */}
	],
	[#Rule 70
		 'termbinop', 3,
sub
#line 552 "plpy.y"
{/* $$ = newRANGE($2, scalar($1), scalar($3));*/}
	],
	[#Rule 71
		 'termbinop', 3,
sub
#line 554 "plpy.y"
{/* $$ = newLOGOP(OP_AND, 0, $1, $3); */}
	],
	[#Rule 72
		 'termbinop', 3,
sub
#line 556 "plpy.y"
{/* $$ = newLOGOP(OP_OR, 0, $1, $3); */}
	],
	[#Rule 73
		 'termbinop', 3,
sub
#line 558 "plpy.y"
{/* $$ = bind_match($2, $1, $3); */}
	],
	[#Rule 74
		 'termunop', 2,
sub
#line 563 "plpy.y"
{/* $$ = newUNOP(OP_NEGATE, 0, scalar($2)); */}
	],
	[#Rule 75
		 'termunop', 2,
sub
#line 565 "plpy.y"
{/* $$ = $2; */}
	],
	[#Rule 76
		 'termunop', 2,
sub
#line 567 "plpy.y"
{/* $$ = newUNOP(OP_NOT, 0, scalar($2)); */}
	],
	[#Rule 77
		 'termunop', 2,
sub
#line 573 "plpy.y"
{ /*$$ = newUNOP(OP_POSTINC, 0,
					mod(scalar($1), OP_POSTINC)); */}
	],
	[#Rule 78
		 'termunop', 2,
sub
#line 576 "plpy.y"
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
#line 652 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 82
		 'term', 3,
sub
#line 658 "plpy.y"
{/* $$ = sawparens($2); */}
	],
	[#Rule 83
		 'term', 2,
sub
#line 660 "plpy.y"
{/* $$ = sawparens(newNULLLIST()); */}
	],
	[#Rule 84
		 'term', 1,
sub
#line 662 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 85
		 'term', 1,
sub
#line 668 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 86
		 'term', 1,
sub
#line 670 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 87
		 'term', 1,
sub
#line 672 "plpy.y"
{/* $$ = newUNOP(OP_AV2ARYLEN, 0, ref($1, OP_AV2ARYLEN));*/}
	],
	[#Rule 88
		 'term', 1,
sub
#line 674 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 89
		 'term', 6,
sub
#line 676 "plpy.y"
{/* $$ = newSLICEOP(0, $5, $2); */}
	],
	[#Rule 90
		 'term', 5,
sub
#line 678 "plpy.y"
{/* $$ = newSLICEOP(0, $4, Nullop); */}
	],
	[#Rule 91
		 'term', 4,
sub
#line 680 "plpy.y"
{ /*$$ = prepend_elem(OP_ASLICE,
				newOP(OP_PUSHMARK, 0),
				    newLISTOP(OP_ASLICE, 0,
					list($3),
					ref($1, OP_ASLICE))); */}
	],
	[#Rule 92
		 'term', 5,
sub
#line 686 "plpy.y"
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
#line 697 "plpy.y"
{/* $$ = newUNOP(OP_ENTERSUB, 0, scalar($1)); */}
	],
	[#Rule 94
		 'term', 3,
sub
#line 699 "plpy.y"
{/* $$ = newUNOP(OP_ENTERSUB, OPf_STACKED, scalar($1)); */}
	],
	[#Rule 95
		 'term', 4,
sub
#line 701 "plpy.y"
{/* $$ = newUNOP(OP_ENTERSUB, OPf_STACKED,
			    append_elem(OP_LIST, $3, scalar($1))); */}
	],
	[#Rule 96
		 'term', 3,
sub
#line 704 "plpy.y"
{/* $$ = newUNOP(OP_ENTERSUB, OPf_STACKED,
			    append_elem(OP_LIST, $3, scalar($2))); */}
	],
	[#Rule 97
		 'term', 1,
sub
#line 707 "plpy.y"
{/* $$ = newOP($1, OPf_SPECIAL);
			    PL_hints |= HINT_BLOCK_SCOPE; */}
	],
	[#Rule 98
		 'term', 2,
sub
#line 714 "plpy.y"
{/* $$ = newUNOP(OP_NOT, 0, scalar($2)); */}
	],
	[#Rule 99
		 'term', 1,
sub
#line 716 "plpy.y"
{/* $$ = newOP($1, 0); */}
	],
	[#Rule 100
		 'term', 2,
sub
#line 718 "plpy.y"
{/* $$ = newUNOP($1, 0, $2); */}
	],
	[#Rule 101
		 'term', 2,
sub
#line 720 "plpy.y"
{/* $$ = newUNOP($1, 0, $2); */}
	],
	[#Rule 102
		 'term', 2,
sub
#line 722 "plpy.y"
{/* $$ = newUNOP(OP_ENTERSUB, OPf_STACKED,
			    append_elem(OP_LIST, $2, scalar($1))); */}
	],
	[#Rule 103
		 'term', 1,
sub
#line 725 "plpy.y"
{/* $$ = newOP($1, 0); */}
	],
	[#Rule 104
		 'term', 3,
sub
#line 727 "plpy.y"
{/* $$ = newOP($1, 0); */}
	],
	[#Rule 105
		 'term', 3,
sub
#line 734 "plpy.y"
{/* $$ = $1 == OP_NOT ? newUNOP($1, 0, newSVOP(OP_CONST, 0, newSViv(0)))
					    : newOP($1, OPf_SPECIAL); */}
	],
	[#Rule 106
		 'term', 4,
sub
#line 737 "plpy.y"
{/* $$ = newUNOP($1, 0, $3); */}
	],
	[#Rule 107
		 'term', 4,
sub
#line 739 "plpy.y"
{/* $$ = pmruntime($1, $3, Nullop); */}
	],
	[#Rule 108
		 'term', 6,
sub
#line 741 "plpy.y"
{/* $$ = pmruntime($1, $3, $5); */}
	],
	[#Rule 109
		 'term', 1, undef
	],
	[#Rule 110
		 'term', 1, undef
	],
	[#Rule 111
		 'myattrterm', 3,
sub
#line 748 "plpy.y"
{/* $$ = my_attrs($2,$3); */}
	],
	[#Rule 112
		 'myattrterm', 2,
sub
#line 750 "plpy.y"
{/* $$ = localize($2,$1); */}
	],
	[#Rule 113
		 'myterm', 3,
sub
#line 755 "plpy.y"
{/* $$ = sawparens($2); */}
	],
	[#Rule 114
		 'myterm', 2,
sub
#line 757 "plpy.y"
{/* $$ = sawparens(newNULLLIST()); */}
	],
	[#Rule 115
		 'myterm', 1,
sub
#line 759 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 116
		 'myterm', 1,
sub
#line 761 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 117
		 'myterm', 1,
sub
#line 763 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 118
		 'listexpr', 0,
sub
#line 768 "plpy.y"
{/* $$ = Nullop; */}
	],
	[#Rule 119
		 'listexpr', 1,
sub
#line 770 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 120
		 'listexprcom', 0,
sub
#line 774 "plpy.y"
{/* $$ = Nullop; */}
	],
	[#Rule 121
		 'listexprcom', 1,
sub
#line 776 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 122
		 'listexprcom', 2,
sub
#line 778 "plpy.y"
{/* $$ = $1; */}
	],
	[#Rule 123
		 'my_scalar', 1,
sub
#line 784 "plpy.y"
{/* PL_in_my = 0; $$ = my($1); */}
	],
	[#Rule 124
		 'amper', 2,
sub
#line 788 "plpy.y"
{/* $$ = newCVREF($1,$2); */}
	],
	[#Rule 125
		 'scalar', 2,
sub
#line 792 "plpy.y"
{/* $$ = newSVREF($2); */}
	],
	[#Rule 126
		 'ary', 2,
sub
#line 796 "plpy.y"
{/* $$ = newAVREF($2); */}
	],
	[#Rule 127
		 'hsh', 2,
sub
#line 800 "plpy.y"
{/* $$ = newHVREF($2); */}
	],
	[#Rule 128
		 'arylen', 2,
sub
#line 804 "plpy.y"
{/* $$ = newAVREF($2); */}
	],
	[#Rule 129
		 'indirob', 1,
sub
#line 815 "plpy.y"
{/* $$ = scalar($1); */}
	],
	[#Rule 130
		 'indirob', 1,
sub
#line 817 "plpy.y"
{/* $$ = scalar($1);  */}
	],
	[#Rule 131
		 'indirob', 1,
sub
#line 819 "plpy.y"
{/* $$ = scope($1); */}
	]
],
                                  @_);
    bless($self,$class);
}

#line 826 "plpy.y"
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
