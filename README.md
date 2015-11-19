# Filmaffinity to Trello

## Utility

Syncs a filmaffinity list with trello.

## Usage

Every time you run the rake it checks your first fifty (pagination is not implemented yet) films in the indicated list and created a trello card via trello-to-email in the selected board. It also have an anti-duplication service.

The thing is about automation the run of the rake on heroku for have it the service free.

_Warning: Email-To-Trello can take up to 15 minutes to delay, keep calm_

## Dependences and Environment variables

The system depends on two external apps:

- [Filmaffinity](http://www.filmaffinity.com)
- [Trello](http://www.trello.com)

And the [emailing system](http://www.postmarkapp.com) and the database (redis).

The environment variables that you have to provide are:

- USER_ID: Filmaffinity user id
- LIST_ID: Filmaffinity list id to track

_http://www.filmaffinity.com/en/userlist.php?userid=3882697&listid=1001 that is the url of one of my lists, you can extract the data from the url_

- TRELLO_EMAIL: Email of [email-to-trello](http://blog.trello.com/create-cards-via-email/)

_it looks like:  mrandomuser+113323124dadas131rui@boards.trello.com_

- TRELLO_LABEL: It will be added at the end of the card title if you put for example '#Films' the card will have the label '#Films', if you put the label '#Films #to_watch' it will have both labels and so on.

- POSTMARK_API_KEY: Is the API key of [Postmark](http://www.postmarkapp.com) (first 25.000 emails for free)

_it looks like: 13312ss8e-1a37-3192-9991-ss3222z8z99c_

- FROM_EMAIL: A valid postmark from email, take a look in Postmark.

- REDIS_URL: For the Redis config. Provided by Heroku

## Development

Setup:

```
git clone git@github.com:MiguelBel/FilmaffinityToTrello.git
cd FilmaffinityToTrello/
bundle install
```

You can execute the rake with:

```USER_ID=YOUR_VAR LIST_ID=YOUR_VAR TRELLO_EMAIL=YOUR_VAR POSTMARK_API_KEY=YOUR_VAR FROM_EMAIL=YOUR_VAR rake synchronize```

## Deploy to Heroku

Heroku is the easiest way of host the service for free.

```
heroku create
git push heroku master
heroku config:set USER_ID=YOUR_VAR LIST_ID=YOUR_VAR TRELLO_EMAIL=YOUR_VAR POSTMARK_API_KEY=YOUR_VAR FROM_EMAIL=YOUR_VAR # Set the config variables
heroku addons:create heroku-redis:hobby-dev # Adds the heroku addon, it is already configured
heroku addons:create scheduler:standard # Adds the scheduler
heroku addons:open scheduler
```

And then it will open a webpage where you have to set the job and the frequency. You call to the job with the command ```rake synchronize```

The final result should look like:

![Imgur](http://i.imgur.com/dGimcHW.png)
