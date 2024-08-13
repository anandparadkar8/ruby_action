# Use the official Ruby image from the Docker Hub
FROM ruby:3.0.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the working directory inside the container
WORKDIR /ruby_action

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile /ruby_action/Gemfile
COPY Gemfile.lock /ruby_action/Gemfile.lock

# Install gems
RUN bundle install

# Copy the rest of the application code into the container
COPY . /ruby_action

# Precompile assets (optional, only if you’re using asset pipeline)
RUN bundle exec rake assets:precompile

# Set environment variables
ENV RAILS_ENV=production
ENV RACK_ENV=production

# Expose port 3000 to the outside world
EXPOSE 3000

# Command to run the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
