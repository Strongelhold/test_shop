class TransactionService

  include Service
  
  def call
    uri = URI.parse('http://jsonplaceholder.typicode.com/photos/')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    n = rand(5000)
    response = http.request(request)
    photo_url = JSON::parse(response.body)
    photo_url = photo_url[n]
  end

  def query
    uri = URI.parse('http://jsonplaceholder.typicode.com/todos/')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request["Content-Type"] = "application/json"
    response = http.request(request)
    id = JSON.parse(response.body)["id"]
  end

  def self.successful?(photo_url)
    first_number  = photo_url['thumbnailUrl'].split('/').last
    second_number = photo_url['url'].split('/').last
    first_number.to_i(16) > second_number.to_i(16)
  end

end
