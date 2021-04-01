FROM ruby:2.6.5

ENV BUNDLER_VERSION=2.1.4
ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential nodejs yarn

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN gem install bundler:$BUNDLER_VERSION
ADD Gemfile* $APP_HOME/
RUN bundle update mimemagic
RUN bundle install

ADD . $APP_HOME
RUN yarn install --check-files
CMD ["rails","server","-b","0.0.0.0"]
