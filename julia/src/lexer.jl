module Lexers

import ..Tokens
import ..Tokens: Token

is_letter(ch) = isletter(ch) || ch == '_'

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
	while lexer.ch == ' ' || lexer.ch == '\t' || lexer.ch == '\n' || lexer.ch == '\r'
		read_char(lexer)
	end

	tok = Token(Tokens.ILLEGAL, "")
	if lexer.ch == '='
		tok = Token(Tokens.ASSIGN, string(lexer.ch))
	elseif lexer.ch == '+'
		tok = Token(Tokens.PLUS, string(lexer.ch))
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
		tok = Token(Tokens.IDENT, literal)
	elseif isdigit(lexer.ch)
		literal = read_number(lexer)
		tok = Token(Tokens.INT, literal)
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

end
