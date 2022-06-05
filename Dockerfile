FROM ruby:3.0.0

RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
    postgresql-client \
    nodejs \
  && apt-get -q clean \
  && rm -rf /var/lib/apt/lists

# Pre-install gems with native extensions
#RUN gem install nokogiri -v "1.6.8.1"

RUN mkdir -p /app
WORKDIR /app
COPY . /app/
COPY Gemfile* ./
RUN gem install rails
RUN bundle install
COPY . /app/

CMD ["bin/rails","server","-b","0.0.0.0"]

EXPOSE 3000