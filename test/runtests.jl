using Genie, Test

function test()
    @testset "hello" begin
        include("hello/test.jl")
    end
end

test()
