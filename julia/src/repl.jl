module REPL

import ..Lexers
import ..Tokens

const PROMPT = ">> "

export start

function start(instream::IO)
    while true
        print(PROMPT)
        line = readline(instream)
        if line === nothing
            break
        end

        l = Lexers.Lexer(line)
        while true
            tok = Lexers.next_token(l)
            if tok.Type == Tokens.EOF
                break
            end
            println(tok.Type, " ", tok.Literal)
        end
    end

end

end