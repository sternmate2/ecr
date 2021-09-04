FROM 345668227719.dkr.ecr.us-east-1.amazonaws.com/base:38e0487f1fcd61f502a0b1418b9b05e39be51dd6 as build1
# install default version of bundler
ENV APP_HOME /srv/code
RUN mkdir -p $APP_HOME
ADD . /$APP_HOME/
WORKDIR $APP_HOME
#RUN gem install bundler --version 2.0.1  && gem install passenger --version 6.0.2 && bundle init \
#&& bundle install -j64  
RUN gem install passenger --version 6.0.2
#FROM build1 as build2
#ENV APP_HOME /srv/code
#RUN mkdir -p $APP_HOME
#RUN chmod -R 755 /usr/local/bundle/ && chmod -R 755 $APP_HOME
#COPY --from=build1 /usr/local/bundle/ $APP_HOME     
#WORKDIR $APP_HOME
#ENV NODE_ENV=production
RUN passenger-config compile-agent --auto 

#FROM build2 as build3 
#ENV APP_HOME /srv/code
#RUN mkdir -p $APP_HOME
#COPY --from=build2 $APP_HOME/ $APP_HOME  
#WORKDIR $APP_HOME
#ENV NODE_ENV=production
#RUN passenger-config install-standalone-runtime --auto --url-root=fake --connect-timeout=1
#    passenger-config build-native-support


# install default version of passenger

#FROM build3
#EXPOSE 9393
#ENV APP_HOME /srv/code
#RUN mkdir -p $APP_HOME
#COPY --from=build3 $APP_HOME $APP_HOME  
#WORKDIR $APP_HOME 
#RUN passenger-config build-native-support
#COPY ./Rakefile $APP_HOME
#RUN rm -rf /srv/code/public/assets && rake assets:precompile --task
#ENTRYPOINT bundle exec passenger start --port 3000 --log-level 3 --min-instances 5 --max-pool-size 5

