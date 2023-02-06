FROM ruby:3.1.2

#ディレクトリ名をAPP_ROOTに割り当てて、以下$APP_ROOTで参照 作業ディレクトリ名が変わっても下の一文を変えるだけで済む
ENV APP_ROOT /dockerplactice
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT
COPY Gemfile $APP_ROOT/Gemfile
COPY Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install

COPY . $APP_ROOT

CMD /bin/sh -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 8080 -b '0.0.0.0'"
