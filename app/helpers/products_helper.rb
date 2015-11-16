require 'net/http'
require 'uri'

module ProductsHelper

  def get_photo
    uri = URI.parse('http://jsonplaceholder.typicode.com/photos/')

    # Shortcut
    response = Net::HTTP.get_response(uri)

    # Will print response.body
    Net::HTTP.get_print(uri)

    # Full
    http = Net::HTTP.new(uri.host, uri.port)
    response = http.request(Net::HTTP::Get.new(uri.request_uri))
  end

end
