module RequestSpecHelper
  def json
    Json.parse(response.body)
  end
end