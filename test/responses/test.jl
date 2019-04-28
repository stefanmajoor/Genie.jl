using Test
using Genie, HTTP
using Genie.Router, Genie.Responses
using HTTP.ExceptionRequest: StatusError

@testset "Simple correct response" begin
  route("/responses", method = GET) do
    setstatus(301)
    setheaders(Dict("X-Foo-Bar"=>"Baz"))
    setheaders(Dict("Content-Type" => "text/text"))
    setheaders(Dict("X-A-B"=>"C", "X-Moo"=>"Cow"))
    setbody("Hello")
  end


  Genie.AppServer.startup()

  response = HTTP.request("GET", "http://localhost:8000/responses")
  @test response.status == 301
  @test String(response.body) == "Hello"

  headers = Dict(response.headers)
  @test headers["X-Foo-Bar"] == "Baz" # We can set a custom header
  @test headers["Content-Type"] == "text/text"  # We can overwrite a standard header
  @test headers["X-A-B"] == "C" && headers["X-Moo"] == "Cow" # We can set two headers at once
end

@testset "Server failure" begin
  route("/broken") do
   omg!()
  end

  Genie.AppServer.startup()

  status = nothing
  try
      HTTP.request("GET", "http://localhost:8000/broken", ["Content-Type"=>"text/plain"])
  catch e
    status = e.status
  end
  @test status == 500
end

@testset "Server returns 404 on non existing route" begin
    Genie.AppServer.startup()
    status = nothing
    try
       HTTP.request("GET", "http://localhost:8000/thisdoesnotexist", ["Content-Type"=>"text/plain"])
    catch e
      status = e.status
    end
    @test status == 404
end
