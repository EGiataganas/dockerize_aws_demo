# Base image
FROM ruby:2.6.5

ARG APP_HOME=/dockerize_aws_demo

# Installation of dependencies
RUN apt-get update -qq && \
    apt-get install -y \
    # Needed for installing curl
    curl \
    # Needed for certain gems
    build-essential \
    # Needed for postgres gem
    libpq-dev && \
    # Install Node.js 12.x
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    # Install Yarn via Debian package repository
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    # Install Node.js and yarn
    apt-get update && apt-get install -y nodejs yarn && \
    # The following are used to trim down the size of the image by removing unneeded data
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf \
    /var/lib/apt \
    /var/lib/dpkg \
    /var/lib/cache \
    /var/lib/log

# Install bundler gem
RUN gem install bundler --no-doc

# Create a directory for our application
# and set it as the working directory
WORKDIR $APP_HOME

# Add our Gemfile
COPY Gemfile* $APP_HOME/

# Install gems
RUN bundle check || bundle install

# Run our app
COPY . $APP_HOME
