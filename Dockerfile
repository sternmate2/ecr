FROM 345668227719.dkr.ecr.us-east-1.amazonaws.com/base:Latest as build1
#EXPOSE 9393
# install default version of bundler
ENV APP_HOME /srv/code
WORKDIR $APP_HOME
RUN gem install bundler --version 2.0.1 

RUN chmod -R 755 /usr/local/bundle/

# && gem install passenger --version 6.0.2 \
# && bundle install -j64 
#  COPY /usr/local/bundle/ $APP_HOME
RUN ls /usr/local/bundle/ #$APP_HOME
#FROM  as build2
#WORKDIR /srv/code
#COPY --from=build1 /srv/code  
#RUN passenger-config compile-agent --auto && \

# install default version of passenger

#FROM 345668227719.dkr.ecr.us-east-1.amazonaws.com/base:673caf65f994c175e0cae156180d48acec64ca09 as build3

#WORKDIR /srv/code 
#RUN passenger-config install-standalone-runtime --auto --url-root=fake --connect-timeout=1 && \
#    passenger-config build-native-support


#COPY ./Rakefile /srv/code
#RUN rm -rf /srv/code/public/assets && rake assets:precompile --task
#ENTRYPOINT bundle exec passenger start --port 3000 --log-level 3 --min-instances 5 --max-pool-size 5

