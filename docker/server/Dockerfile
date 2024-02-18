FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs vim
RUN mkdir /app
WORKDIR /app
ADD ../../server/Gemfile /app/Gemfile
ADD ../../server/Gemfile.lock /app/Gemfile.lock
# RUN bundle install
ADD ./server /app

COPY ./server/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3010

CMD [ "rails","server","-b","0.0.0.0","-p","3000"]