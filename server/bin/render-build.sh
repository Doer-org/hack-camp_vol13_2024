#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate
rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'