using Genie, HTTP, Test
using Genie.Router, Genie.Responses

@testset "Test post text field" begin
  route("/post", method = POST) do
     @params(:greeting)
  end

  Genie.AppServer.startup()

  response = HTTP.request("POST", "http://localhost:8000/post";
    body="greeting=foo,bar",
    headers=Dict("Content-Type" => "application/x-www-form-urlencoded")
  )

  @test response.status == 200
  @test String(response.body) == "foo,bar"
end
