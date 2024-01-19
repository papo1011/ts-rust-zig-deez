using Test

include("../src/token.jl")
include("../src/lexer.jl")
include("../src/ast.jl")
include("../src/parser.jl")

import .Lexers
import .Tokens
import .Parsers

@testset "test let statements" begin
    input = """
    let x = 5;
    let y = 10;
    let foobar = 838383;
    """

    lexer = Lexers.Lexer(input)
    parser = Parsers.Parser(lexer)

    program = Parsers.parse_program(parser)
    if isnothing(program)
        @test false
    end

    @test length(program.statements) == 3

    tests = [
        "x",
        "y",
        "foobar",
    ]

    for (i, tt) in enumerate(tests)
        stmt = program.statements[i]
        @test stmt.name.value == tt
    end

end