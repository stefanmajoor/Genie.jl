using Genie, Test

function test()
    @testset "hello" begin
        include("hello/test.jl")
    end

    @testset "responses" begin
        include("responses/test.jl")
    end

    @testset "postform" begin
        include("postform/test.jl")
    end
end

test()
