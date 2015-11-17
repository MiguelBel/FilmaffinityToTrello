require 'spec_helper'

describe Filmaffinity::ListParser do
  let(:user_id) { 3882697 }
  let(:list_id) { 1001 }
  let(:list) { described_class.new(user_id, list_id) }
  let(:expected_list) { [ Movie.new(157007, 'Spectre', 'http://pics.filmaffinity.com/Spectre-157007-medium.jpg', '2015'), Movie.new(609114, 'Trumbo', 'http://pics.filmaffinity.com/Trumbo-609114-medium.jpg', '2015') ] }

  context 'when requiring all the movies' do
    it 'we should have as many movies on the list' do
      expect(list.movies.count).to eq(2)
    end

    it 'movies should have id and title attributes' do
      expect(list.movies).to eq(expected_list)
    end
  end
end