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

  # It does not work properly
  def query
    uri = URI.parse('http://jsonplaceholder.typicode.com/todos/')
    parameters = { 'id' => '1' }
    response = Net::HTTP.post_form(uri, parameters)
    id = JSON::parse(response.body)
    id = id['id']
  end

end
