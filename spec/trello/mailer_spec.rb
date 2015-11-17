require 'spec_helper'

describe Trello::Mailer do
  let(:redis) { Redis.new }
  let(:movie) { Movie.new(157009, 'Other Movie', 'http://pics.filmaffinity.com/Spectre-157007-medium.jpg', '2015') }

  describe '.synchronize_movie' do
    it 'send the email to the trello address' do
      expected_mail_first = Mail.new do
        from 'hi@miguel.im'
        to 'trello@email.com'
        subject 'Other Movie (2015)'
        body 'two'

        delivery_method Mail::Postmark, :api_token => 'your-postmark-api-token'
      end

      allow(Mail).to receive(:new).
        and_return(expected_mail_first)
      allow(Redis).to receive(:new).
        and_return(redis)
      allow(redis).to receive(:rpush)

      expect(expected_mail_first).to receive(:deliver)

      Trello::Mailer.synchronize_movie(movie)
    end

    it 'saves the movie id in the database' do
      mail = Mail.new
      allow(Mail).to receive(:new).
        and_return(mail)
      allow(mail).to receive(:deliver)

      expect(Redis).to receive(:new).
        and_return(redis)
      expect(redis).to receive(:rpush).
        with('movies_list', movie.id)

      Trello::Mailer.synchronize_movie(movie)
    end
  end
end
