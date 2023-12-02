module Lexers

import ..Tokens
import ..Tokens: Token, lookup_ident

function is_letter(ch::Char)
    return ('a' <= ch <= 'z') || ('A' <= ch <= 'Z') || ch == '_'
end

mutable struct Lexer
	input::String
	position::Int
	read_position::Int
	ch::Char
end

function Lexer(input::String)
	lexer = Lexer(input, 0, 0, '\0')
	read_char(lexer)
	return lexer
end

function read_char(lexer::Lexer)
	if lexer.read_position >= length(lexer.input)
		lexer.ch = '\0'
	else
		lexer.ch = lexer.input[lexer.read_position+1]
	end
	lexer.position = lexer.read_position
	lexer.read_position += 1
end

function next_token(lexer::Lexer)
	skip_whitespace(lexer)
	
	tok = Token(Tokens.ILLEGAL, "")
	if lexer.ch == '='
		if peek_char(lexer) == '='
			ch = lexer.ch
			read_char(lexer)
			literal = string(ch, lexer.ch)
			tok = Token(Tokens.EQ, literal)
		else
			tok = Token(Tokens.ASSIGN, string(lexer.ch))
		end
	elseif lexer.ch == '+'
		tok = Token(Tokens.PLUS, string(lexer.ch))
	elseif lexer.ch == '-'
		tok = Token(Tokens.MINUS, string(lexer.ch))
	elseif lexer.ch == '!'
		if peek_char(lexer) == '='
			ch = lexer.ch
			read_char(lexer)
			literal = string(ch, lexer.ch)
			tok = Token(Tokens.NOT_EQ, literal)
		else
			tok = Token(Tokens.BANG, string(lexer.ch))
		end
	elseif lexer.ch == '*'
		tok = Token(Tokens.ASTERISK, string(lexer.ch))
	elseif lexer.ch == '/'
		tok = Token(Tokens.SLASH, string(lexer.ch))
	elseif lexer.ch == '<'
		tok = Token(Tokens.LT, string(lexer.ch))
	elseif lexer.ch == '>'
		tok = Token(Tokens.GT, string(lexer.ch))
	elseif lexer.ch == ','
		tok = Token(Tokens.COMMA, string(lexer.ch))
	elseif lexer.ch == ';'
		tok = Token(Tokens.SEMICOLON, string(lexer.ch))
	elseif lexer.ch == '('
		tok = Token(Tokens.LPAREN, string(lexer.ch))
	elseif lexer.ch == ')'
		tok = Token(Tokens.RPAREN, string(lexer.ch))
	elseif lexer.ch == '{'
		tok = Token(Tokens.LBRACE, string(lexer.ch))
	elseif lexer.ch == '}'
		tok = Token(Tokens.RBRACE, string(lexer.ch))
	elseif is_letter(lexer.ch)
		literal = read_identifier(lexer)
		type = lookup_ident(literal)
		tok = Token(type, literal)
		return tok
	elseif isdigit(lexer.ch)
		literal = read_number(lexer)
		tok = Token(Tokens.INT, literal)
		return tok
	elseif lexer.ch == '\0'
		tok = Token(Tokens.EOF, "")
	else
		tok = Token(Tokens.ILLEGAL, string(lexer.ch))
	end

	read_char(lexer)
	return tok
end

function read_identifier(lexer::Lexer)
	start = lexer.position
	while is_letter(lexer.ch)
		read_char(lexer)
	end
	return lexer.input[start+1:lexer.position]
end

function read_number(lexer::Lexer)
	start = lexer.position
	while isdigit(lexer.ch)
		read_char(lexer)
	end
	return lexer.input[start+1:lexer.position]
end

function  skip_whitespace(lexer::Lexer)
	while lexer.ch == ' ' || lexer.ch == '\t' || lexer.ch == '\n' || lexer.ch == '\r'
		read_char(lexer)
	end
end

"""
	Peek at the next character in the input without advancing the lexer.
"""
function peek_char(lexer::Lexer)
	if lexer.read_position >= length(lexer.input)
		return '\0'
	else
		return lexer.input[lexer.read_position+1]
	end
end
	
end
