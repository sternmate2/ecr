FROM ruby:2.5.5-alpine3.8 
ENV APP_HOME /srv/code
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

#COPY Gemfile* $APP_HOME/
RUN apk add --update \
  curl curl-dev \
  libxml2-dev \
  build-base \
  libxml2-dev \
  libxslt-dev \
  mysql-client \
  mysql-dev \
  tzdata \
  nodejs \
  linux-headers \
  pcre pcre-dev 
RUN gem install bundler --version 2.0.1 
RUN gem install passenger --version 6.0.2
RUN bundle install -j64




