FROM ruby:2.1.5

RUN apt-get update
RUN apt-get install -y nodejs nginx-full mysql-client

RUN gem update --system
RUN gem install bundler

ADD Gemfile /gems/Gemfile
ADD Gemfile.lock /gems/Gemfile.lock

WORKDIR /gems
RUN bundle install --deployment --path /gems
ADD . /app
ADD nginx.conf /etc/nginx/nginx.conf

WORKDIR /app
ENV DATABASE_URL mysql2://localhost/fake
ENV RAILS_ENV production
RUN bundle exec rake assets:precompile

CMD bin/start_container
