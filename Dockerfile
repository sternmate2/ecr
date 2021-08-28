FROM ruby:2.5.5-alpine3.8


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
  
FROM 345668227719.dkr.ecr.us-east-1.amazonaws.com/base:443b6b5d44f32f4469170d7538d8011aaac1605c
WORKDIR /srv/code
COPY . /srv/code

# install default version of bundler
RUN gem install bundler --version 2.0.1

# install default version of passenger
RUN gem install passenger --no-ri
#gem install passenger --version 6.0.2
#RUN bundle install -j64
RUN passenger-config compile-agent --auto --optimize && \
  passenger-config install-standalone-runtime --auto --url-root=fake --connect-timeout=1 && \
  passenger-config build-native-support
