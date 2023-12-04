module Monkey

include("token.jl")
include("lexer.jl")
include("repl.jl")

import .Lexers
import .Tokens
import .REPL

REPL.start(stdin)

end