FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs vim
RUN mkdir /app
WORKDIR /app
ADD ../../serverGemfile /app/Gemfile
ADD ../../server/Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD ./server /app