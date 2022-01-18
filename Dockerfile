# syntax=docker/dockerfile:1
FROM ruby:2.6.8
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /imc_app
COPY Gemfile /imc_app/Gemfile
COPY Gemfile.lock /imc_app/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
