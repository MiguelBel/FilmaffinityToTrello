
module Trello
  class Database
    class << self
      def persist_movie(movie)
        redis.rpush('movies_list', movie.id)
      end

      def load_movies_ids_list
        redis.lrange('movies_list', 0, -1).map(&:to_i)
      end

      private

      def redis
        redis ||= Redis.new
      end
    end
  end
end
