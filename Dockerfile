FROM 345668227719.dkr.ecr.us-east-1.amazonaws.com/base:b410f86fd79dbb2bb93e6ff87ce4fe6670db00aa as build1
# install default version of bundler
ENV APP_HOME /srv/code
RUN mkdir -p $APP_HOME
ADD . /$APP_HOME/
WORKDIR $APP_HOME
RUN gem install bundler --version 2.0.1 && bundle init \
&& bundle install -j64  
#RUN gem install passenger --version 6.0.8

FROM build1 as build2
ENV APP_HOME /srv/code
RUN mkdir -p $APP_HOME
#RUN chmod -R 755 /usr/local/bundle/ && chmod -R 755 $APP_HOME
COPY --from=build1 /usr/local/bundle/ $APP_HOME     
WORKDIR $APP_HOME
#ENV NODE_ENV=production
#RUN export CC='ccache clang -fcolor-diagnostics -Qunused-arguments -fcatch-undefined-behavior -ftrapv'
#RUN export CXX='ccache clang++ -fcolor-diagnostics -Qunused-arguments -fcatch-undefined-behavior -ftrapv'
#RUN passenger-config compile-agent --
RUN passenger-config install-standalone-runtime --auto --url-root=fake --connect-timeout=1

FROM build2 as build3 
ENV APP_HOME /srv/code
RUN mkdir -p $APP_HOME
COPY --from=build2 $APP_HOME/ $APP_HOME  
WORKDIR $APP_HOME
#ENV NODE_ENV=production
RUN passenger-config build-native-support


# install default version of passenger

FROM build3
EXPOSE 9393
ENV APP_HOME /srv/code
RUN mkdir -p $APP_HOME
COPY --from=build3 $APP_HOME $APP_HOME  
WORKDIR $APP_HOME 
RUN passenger-config build-native-support
COPY ./Rakefile $APP_HOME
RUN rm -rf /srv/code/public/assets && rake assets:precompile --task
ENTRYPOINT bundle exec passenger start --port 3000 --log-level 3 --min-instances 5 --max-pool-size 5

