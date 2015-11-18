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
      set_body
      add_attachments
      @email.deliver
    end

    def form_email
      @email = Mail.new do
        from ENV['FROM_EMAIL']
        to ENV['TRELLO_EMAIL']

        delivery_method Mail::Postmark, :api_token => ENV['POSTMARK_API_KEY']
      end
    end

    def set_subject
      subject = "#{@movie.title} (#{@movie.year}) #{ENV['TRELLO_LABEL']}"
      @email.subject = subject
    end

    def set_body
      body = "Sync from Filmaffinity to Trello. http://www.filmaffinity.com/en/film#{@movie.id}.html #Films"
      @email.body = body
    end

    def add_attachments
      @email.attachments['image.jpg'] = open(@movie.image) { |i| i.read }
    end

    def persist_in_database
      Database.persist_movie(@movie)
    end
  end
end
