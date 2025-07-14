# Base Ruby image
FROM ruby:3.1.2

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential libpq-dev nodejs yarn curl

# Set working directory
WORKDIR /app

# Install bundler
RUN gem install bundler

# Copy Gemfiles
COPY Gemfile Gemfile.lock ./

# Install Ruby gems
RUN bundle install

# Copy the rest of the app
COPY . .

ENV RAILS_ENV=production

# Expose Rails port
EXPOSE 3000

# Start server (override in docker-compose if needed)
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails s -b 0.0.0.0 -p $PORT"]
