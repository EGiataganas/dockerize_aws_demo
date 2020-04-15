#!/bin/bash

set -e

echo "Bundling gems"
bundle check || bundle install

# parameters will pass to bundle exec from docker-compose
bundle exec "$@"
