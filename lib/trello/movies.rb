require 'redis'

module Trello
  class Movies
    class << self
      def movies_to_insert
        movies_to_reject = movies_ids_already_in_database
        list_movies.reject { |movie| movies_to_reject.include?(movie.id) }
      end

      private

      def redis
        Redis.new
      end

      def movies_ids_already_in_database
        redis.lrange('movies_list', 0, -1).map(&:to_i)
      end

      def filmaffinity_list_parser
        Filmaffinity::ListParser.new(ENV['USER_ID'], ENV['LIST_ID'])
      end

      def list_movies
        filmaffinity_list_parser.movies
      end
    end
  end
end
