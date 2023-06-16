FROM ruby:2.7.8-alpine AS builder
RUN apk add \
  build-base \
  libpq-dev \
  git
COPY Gemfile* .
RUN gem install bundler:2.2.24
RUN bundle install

FROM ruby:2.7.8-alpine AS runner
RUN apk add \
    tzdata \
    libpq-dev \
    nodejs \
    git
RUN git config --global core.autocrlf true
WORKDIR /app
COPY . .
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]