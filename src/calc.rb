# Prototype file of Ruby parser.
# Written by arikui <arikui.ruby _at_ gmail.com>
# This file is PUBLIC DOMAIN.



module Calc
	module Tokens
		TOKENS = {
		  YYERRTOK: 256,
		  ADD: 257,
		  SUB: 258,
		  MUL: 259,
		  DIV: 260,
		  CR: 261,
		  NUMBER_LITERAL: 262,
    }
	end

	class Parser
		def initialize(lexer, debug: false)
			@lexer = lexer
			@yydebug = debug
		end
	end
end







buffer = ""
token = ""
toktype = ""
YYDEFAULTSTACK = 512

YYERRTOK = 256
ADD = 257
SUB = 258
MUL = 259
DIV = 260
CR = 261
NUMBER_LITERAL = 262

	
#	#define yyclearin (yychar = -1)
#	#define yyerrok (yyerrflag = 0)
#	#define YYRECOVERING (yyerrflag != 0)
#	#define YYERROR	goto yyerrlab


# Debug mode flag
@yydebug = false

# lexical element object
@yylval = nil


YYTRANSLATE = [
	    0,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
	    8,    8,    8,    8,    8,    8,    1,    2,    3,    4,
	    5,    6,    7
].freeze

YYBADCH = 8
YYMAXLEX = 263
YYTERMS = 8
YYNONTERMS = 7

YYACTION = [
	    6,    7,    0,   16,   17,    8,    9,    0,    0,    0,
	   24
].freeze

YYLAST = 11

YYCHECK = [
	    2,    3,    0,    6,    6,    4,    5,   -1,   -1,   -1,
	    7
].freeze

YYBASE = [
	   -3,   -2,   -3,    1,    1,    1,    3,    3,    3,    3,
	    2,    3,    0,    3
].freeze

YY2TBLSTATE = 3

YYDEFAULTS = [
	    1,32767,    2,    7,    8,    9,32767,32767,32767,32767,
	32767
].freeze

YYGOTO = [
	    4,    5,    0,   22,   23,   15
].freeze

YYGLAST = 6

YYGCHECK = [
	    5,    5,   -1,    6,    6,    3
].freeze

YYGBASE = [
	    0,    0,    0,    3,    0,   -6,   -5
].freeze

YYGDEFAULTS = [
	-32768,   10,    2,   14,    1,    3,   21
].freeze

YYLHS = [
	    0,    1,    1,    2,    2,    3,    3,    4,    4,    4,
	    5,    5,    5,    6
].freeze

YYLEN = [
	    1,    0,    1,    1,    2,    1,    2,    1,    3,    3,
	    1,    3,    3,    1
].freeze

YYSTATES = 19
YYNLSTATES = 11
YYINTERRTOK = 1
YYUNEXPECTED = 32767
YYDEFAULT = -32766

# Parser entry point
def yyparse()
	r = 0...YYDEFAULTSTACK
	yyastk = r.to_a
	yysstk = r.to_a

	yystate = 0
	yychar = -1

	yysp = 0
	yysstk[yysp] = 0
	yyerrflag = 0
	while true
		if YYBASE[yystate] == 0
			yyn = YYDEFAULTS[yystate]
		else
			if yychar < 0
				yychar = yylex()
				yychar = 0 if yychar <= 0
				yychar = (yychar < YYMAXLEX ? YYTRANSLATE[yychar] : YYBADCH)
			end
			yyn = YYBASE[yystate] + yychar
			go_next = (yyn >= 0 && yyn < YYLAST && YYCHECK[yyn] == yychar)
			unless go_next
				go_next = yystate < YY2TBLSTATE
				if go_next
					yyn = YYBASE[yystate + YYNLSTATES] + yychar
					go_next = (yyn >= 0 && yyn < YYLAST && YYCHECK[yyn] == yychar)
				end
			end
			if go_next
				yyn = YYACTION[yyn]
				go_next = yyn != YYDEFAULT
			end
			if go_next
				# >= YYNLSTATE: shift and reduce
				# > 0: shift
				# = 0: accept
				# < 0: reduce
				# = -YYUNEXPECTED: error
				if yyn > 0
					# shift
					yysp = yysp + 1

					yysstk[yysp] = yystate = yyn
					yyastk[yysp] = @yylval
					yychar = -1
					
					yyerrflag -= 1 if yyerrflag > 0
					next if yyn < YYNLSTATES
					# yyn >= YYNLSTATES means shift-and-reduce
					yyn -= YYNLSTATES
				else
					yyn = -yyn
				end
			else
				yyn = YYDEFAULTS[yystate]
			end
		end
		
		while true
			# reduce/error
			if yyn == 0
				# accept
				return 0
			elsif yyn != YYUNEXPECTED
				# reduce
				yyl = YYLEN[yyn]
				yyval = yyastk[yysp-yyl+1]
				# Following line will be replaced by reduce actions
				if yyn == 6
					
         puts(">>> %f" % yyastk[yysp-(2-1)])
     
				end
				if yyn == 8
					
         yyval = yyastk[yysp-(3-1)] + yyastk[yysp-(3-3)]
     
				end
				if yyn == 9
					
         yyval = yyastk[yysp-(3-1)] - yyastk[yysp-(3-3)]
     
				end
				if yyn == 11
					
         yyval = yyastk[yysp-(3-1)] * yyastk[yysp-(3-3)]
     
				end
				if yyn == 12
					
         yyval = yyastk[yysp-(3-1)] / yyastk[yysp-(3-3)]
     
				end
				# Goto - shift nonterminal
				yysp -= yyl
				yyn = YYLHS[yyn]
				yyp = YYGBASE[yyn] + yysstk[yysp]
				if yyp >= 0 && yyp < YYGLAST && YYGCHECK[yyp] == yyn
					yystate = YYGOTO[yyp]
				else
					yystate = YYGDEFAULTS[yyn]
				end
					
				yysp = yysp + 1

				yysstk[yysp] = yystate
				yyastk[yysp] = yyval
			else
				# error
				yyerror "syntax error" if yyerrflag == 0
				case yyerrflag
				when 0..2
					yyerrflag = 3
					# Pop until error-expecting state uncovered
					while true
						yyn = YYBASE[yystate] + YYINTERRTOK
						b = (yyn >= 0 && yyn < YYLAST && YYCHECK[yyn] == YYINTERRTOK)
						unless b
							b = yystate < YY2TBLSTATE
							if b
								yyn = YYBASE[yystate + YYNLSTATES] + YYINTERRTOK
								b = (yyn >= 0 && yyn < YYLAST && YYCHECK[yyn] == YYINTERRTOK)
							end
						end
						break unless b
						return 1 if yysp <= 0
						yysp -= yysp
						yystate = yysstk[yysp]
					end
					yyn = YYACTION[yyn]
					yysp += 1
					yystate = yyn
					yysstk[yysp] = yyn
				when 3
					return 1if yychar == 0
					yychar = -1
				end
			end	
			break if yystate < YYNLSTATES
			# >= YYNLSTATES means shift-and-reduce
			yyn = yystate - YYNLSTATES
		end
	end
end


#"

def yylex
  @lexer.next
end

OP = {
  '+' => ADD,
  '-' => SUB,
  '*' => MUL,
  '/' => DIV,
}

def lex
  return enum_for(__method__) unless block_given?
  $stdin.each_line do |line|
    rest = line
    until rest.empty?
      case rest
      when /\A[\r\n\s]+/
        ;
      when /\A\d+\.\d+/, /\A\d+/
        @yylval = Float($&)
        yield NUMBER_LITERAL
      when /\A[\+\-\*\/]/
        yield OP.fetch($&)
      when /\A./
        raise "invalid character - `#{$&}'"
      else
        raise Exception, 'must not happen'
      end
      rest = $'
    end
    yield CR
  end
  while true
   yield 0
  end
end

@yydebug = true
@lexer = lex()
yyparse
