FROM ruby:2.1.5

RUN apt-get update
RUN apt-get install -y nodejs

RUN gem update --system
RUN gem install bundler

ADD Gemfile /gems/Gemfile
ADD Gemfile.lock /gems/Gemfile.lock

WORKDIR /gems
RUN bundle install --deployment --path /gems
ADD . /app

WORKDIR /app
ENV DATABASE_URL mysql2://localhost/fake
RUN bundle exec rake assets:precompile
