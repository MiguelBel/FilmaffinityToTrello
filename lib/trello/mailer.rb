require 'mail'
require 'postmark'
require 'redis'
require 'open-uri'

module Trello
  class Mailer
    class << self
      def synchronize_movie(movie)
        new(movie).synchronize_movie
      end
    end

    def initialize(movie)
      @movie = movie
    end

    def synchronize_movie
      send_email
      persist_in_database
    end

    private

    def send_email
      form_email
      set_subject
      add_attachments
      @email.deliver
    end

    def form_email
      @email = Mail.new do
        from ENV['FROM_EMAIL']
        to ENV['TRELLO_EMAIL']
        body 'Sync from Filmaffinity to Trello #Films'

        delivery_method Mail::Postmark, :api_token => ENV['POSTMARK_API_KEY']
      end
    end

    def set_subject
      subject = "#{@movie.title} (#{@movie.year}) #{ENV['TRELLO_LABEL']}"
      @email.subject = subject
    end

    def add_attachments
      @email.attachments['image.jpg'] = open(@movie.image) { |i| i.read }
    end

    def persist_in_database
      Redis.new.rpush('movies_list', @movie.id)
    end
  end
end
