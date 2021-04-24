FROM ruby:2.6

# WebPackerのinstallにyarn必須
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir /animal-system

WORKDIR /animal-system
COPY Gemfile /animal-system/Gemfile
COPY Gemfile.lock /animal-system/Gemfile.lock
RUN bundle install
COPY . /animal-system

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]