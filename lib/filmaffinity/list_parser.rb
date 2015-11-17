require 'httparty'
require 'nokogiri'

module Filmaffinity
  class ListParser
    def initialize (user_id, list_id)
      @user_id = user_id
      @list_id = list_id
    end

    def movies
      movies = []
      parsed_response.css('.movie-wrapper').each do |movie|
        movies << Filmaffinity::MovieParser.parse(movie)
      end

      movies
    end
    private

    def url
      "http://www.filmaffinity.com/en/userlist.php?user_id=#{@user_id}&list_id=#{@list_id}"
    end

    def petition
      HTTParty.get(url)
    end

    def parsed_response
      Nokogiri::HTML(petition.response.body)
    end
  end
end
