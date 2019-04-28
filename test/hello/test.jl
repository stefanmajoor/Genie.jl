using Genie, HTTP, Test
import Genie.Router: route

route("/hello") do
  "Welcome to Genie!"
end
Genie.AppServer.startup()
response = HTTP.get("http://localhost:8000/hello")
@test String(response.body) == "Welcome to Genie!"
@test response.status == 200

headers = Dict(response.headers)
@test headers["Content-Type"] == "text/html"
