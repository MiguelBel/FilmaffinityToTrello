require_relative './lib/filmaffinity/list_parser'
require_relative './lib/filmaffinity/movie_parser'
require_relative './lib/trello/mailer'
require_relative './lib/trello/movies'
require_relative './lib/filmaffinity_to_trello'

desc 'Synchronize filmaffinity list with trello board'
task :synchronize do
  FilmaffinityToTrello.synchronize
end