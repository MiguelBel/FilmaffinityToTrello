require 'spec_helper'

describe FilmaffinityToTrello do
  let(:list_movies) {  [ Movie.new(157007, 'Spectre'), Movie.new(609114, 'Trumbo'), Movie.new(12345, 'City of God') ] }

  describe '.synchronize' do
    it 'calls the movies and the mailer' do
      allow(Trello::Movies).to receive(:movies_to_insert).
        and_return(list_movies)

      list_movies.each do |movie|
        expect(Trello::Mailer).to receive(:synchronize_movie).
          with(movie)
      end

      FilmaffinityToTrello.synchronize
    end
  end
end
