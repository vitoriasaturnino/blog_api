# syntax=docker/dockerfile:1
FROM ruby:3.1.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /blog_api
COPY Gemfile /blog_api/Gemfile
COPY Gemfile.lock /blog_api/Gemfile.lock
RUN gem update --system 3.2.3
RUN gem install bundler:2.3.3

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
