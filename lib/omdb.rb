module OMDB
   def query_omdb(query)
    require 'open-uri'
    require 'json'

    uri = URI.parse(URI.encode("http://www.omdbapi.com/?t=#{query.strip}"))
    result = JSON.parse(open(uri).read)
  end
end