FROM ruby:2.7.5

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock fetch ./
COPY lib lib
RUN bundle install

ENTRYPOINT ["/usr/src/app/fetch"]
CMD ["--help"]
