Movie = Struct.new(:id, :title, :image, :year)

module Filmaffinity
  class MovieParser
    class << self
      def parse(movie)
        new(movie).parse
      end
    end

    def initialize(movie)
      @movie = movie
    end

    def parse
      Movie.new(id, title, image, year)
    end

    private

    def id
      @movie.css('.movie-card').first.attr('data-movie-id').to_i
    end

    def title
      @movie.search('.mc-poster a').first.attr('title').strip
    end

    def image
      @movie.search('.mc-poster a img').first.attr('src').strip
    end

    def year
      @movie.search('.mc-title').xpath('text()').text.strip.gsub(/[()]/, "")
    end
  end
end
