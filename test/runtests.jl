using Genie, Test

function test()
    @testset "hello" begin
        include("hello/test.jl")
    end

    @testset "responses" begin
        include("responses/test.jl")
    end
end

test()
