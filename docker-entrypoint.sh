#!/bin/bash

set -e

echo 'Waiting for a connection with postgres...'

until psql -h "postgres" -U "postgres" -c '\q' > /dev/null 2>&1; do
  sleep 1
done

echo "Connected to postgres..."

echo "Bundling gems"
bundle check || bundle install

echo "Creating the database..."
bundle exec rails db:create
echo "Migrating the database..."
bundle exec rails db:migrate

# parameters will pass to bundle exec from docker-compose
bundle exec "$@"
