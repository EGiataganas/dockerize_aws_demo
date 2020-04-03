# Base image
FROM ruby:2.6.5

# Installation of dependencies
RUN apt-get update -qq \
  && apt-get install -y \
      # Needed for certain gems
    build-essential \
         # Needed for postgres gem
    libpq-dev \
         # Needed for asset compilation
    nodejs

# Install bundler gem
RUN gem install bundler --no-doc

# Create a directory for our application
# and set it as the working directory
RUN mkdir /myapp
WORKDIR /myapp

# Add our Gemfile
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Install gems
RUN bundle install

# Run our app
COPY . /myapp
