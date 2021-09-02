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
  pcre pcre-dev && rm -rf /var/cache/apk/*




