FROM ruby:3.1.2

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt update -qq && apt install -y nodejs build-essential postgresql-client yarn curl dirmngr apt-transport-https lsb-release ca-certificates

#ディレクトリ名をAPP_ROOTに割り当てて、以下$APP_ROOTで参照 作業ディレクトリ名が変わっても下の一文を変えるだけで済む
ENV APP_ROOT /sample_app
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT
COPY Gemfile $APP_ROOT/Gemfile
COPY Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install

COPY . $APP_ROOT
