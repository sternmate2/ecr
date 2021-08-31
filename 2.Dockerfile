FROM ruby:2.5.5-alpine3.8 as build1

RUN mkdir -p /srv/code

WORKDIR /srv/code

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
FROM alpine:3.4

COPY --from=build1 /srv/code /srv/code
#RUN gem install bundler --version 2.0.1 && gem install passenger --version 6.0.2 && bundle init && bundle install -j64 && passenger-config compile-agent --auto


