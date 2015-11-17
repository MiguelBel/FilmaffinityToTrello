require 'spec_helper'

describe Trello::Movies do
  let(:redis) { Redis.new }
  let(:movies) {  [ Movie.new(157007, 'Spectre'), Movie.new(609114, 'Trumbo') ] }

  before do
    redis.rpush('movies_list', movies.first.id)
  end

  describe '.movies_to_insert' do
    it 'list all the movies which are not already on the database' do
      list_parser = Filmaffinity::ListParser.new(1, 1)
      allow(Filmaffinity::ListParser).to receive(:new).
        and_return(list_parser)
      allow(list_parser).to receive(:movies).
        and_return(movies)

      expect(Trello::Movies.movies_to_insert).to eq([movies.last])
    end
  end
end
