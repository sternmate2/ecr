FROM ruby:2.5.5-alpine3.8 as builder
ENV APP_HOME /srv/code
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

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
RUN gem install passenger --version 6.0.8

FROM builder
ENV APP_HOME /srv/code
RUN mkdir -p $APP_HOME
COPY --from=builder $APP_HOME $APP_HOME
WORKDIR $APP_HOME
RUN passenger-config compile-agent --auto --optimize




