FROM rjocoleman/alpine-s3fs:ruby2

RUN gem update --system;

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install --without development test
COPY config.ru /app/config.ru

CMD ["rackup", "--host", "0.0.0.0"]
