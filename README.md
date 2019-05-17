# Brownfield of Dreams 

## About

This is a paired project while students at Turing School of Software and
Design's Backend Engineering program. The aim of the project is to use the following skills:

- Advanced database queries and manipulation using ActiveRecord and SQL 
- Build on an existing code base and work with technical debt
- OAuth
- MVC design pattern
- Consume an API with Faraday
- BDD using RSpec and Capybara
- Version control and project management within a paired environment
- Heroku deployment
- Experimentation with new technologies and gems

The project is a Ruby on Rails application used to organize YouTube content used for online learning. GitHub API is consumed to allow users to view their repos, followers, and following as well as the ability to add friends.

## Installation & Setup

The program can run in development from the Rails server after following the following steps in your console:

Clone down the repo
```
$ git clone https://github.com/chitasan/brownfield-of-dreams
```

Change directory into the app
```
$ cd brownfield-of-dreams
$ code .
```

Install the gem packages
```
$ bundle install
```

Install node packages for stimulus
```
$ brew install node
$ brew install yarn
$ yarn add stimulus
```

If there is a yarn error **
```
$ rm yarn.lock && yarn
```

Set up the database
```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

Run the server
```
$ rails s
```

On browser, go to `http://localhost:3000/`

## Testing

The project uses <a href="https://github.com/colszowka/simplecov"> SimpleCov</a> and <a href="https://github.com/rspec/rspec"> RSpec</a> to test.

Run the test suite:
```ruby
$ bundle exec rspec
```

## Live Web App

The project is in live production <a href='https://blooming-caverns-17100.herokuapp.com/'> here</a> 

To login as admin, `email: admin@example.com password: password`

To use as a regular use, please register and connect to your GitHub account. 

## System Requirements

* Ruby 2.4.1
* Rails 5.2.0
* PostgreSQL 11.2

## Contributors

Jennica Stiehl @stiehlrod

Chi Tran @chitasan