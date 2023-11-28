const TokenType = String

const ILLEGAL = "ILLEGAL"
const EOF = "EOF"
const IDENT = "IDENT"
const INT = "INT"
const ASSIGN = "="
const PLUS = "+"
const COMMA = ","
const SEMICOLON = ";"
const LPAREN = "("
const RPAREN = ")"
const LBRACE = "{"
const RBRACE = "}"

struct Token
    Type::TokenType
    Literal::String
end

export ILLEGAL, EOF, IDENT, INT, ASSIGN, PLUS, COMMA, SEMICOLON, LPAREN, RPAREN, LBRACE, RBRACE, Token
