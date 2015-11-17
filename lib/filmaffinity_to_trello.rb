class FilmaffinityToTrello
  class << self
    def synchronize
      movies_to_insert = Trello::Movies.movies_to_insert
      movies_to_insert.each do |movie|
        Trello::Mailer.synchronize_movie(movie)
      end
    end
  end
end

