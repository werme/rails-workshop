class Movie < ActiveRecord::Base
  belongs_to :category

  validates :title, presence: true, uniqueness: { case_sensitive: false }, length: { in: 2..60 }
  validates :category, presence: true
  validates :rating, inclusion: { in: 1..10, message: "%{value} is not in valid range 1 - 10." }

  before_save :update_info_from_omdb

  def update_info_from_omdb
    result = query_omdb(self.title)

    self.year        = result["Year"]
    self.description = result["Plot"]
    self.poster_uri  = result["Poster"]
  end

  def query_omdb(query)
    require 'open-uri'
    require 'json'

    uri = URI.parse(URI.encode("http://www.omdbapi.com/?t=#{query.strip}"))
    result = JSON.parse(open(uri).read)
  end
end