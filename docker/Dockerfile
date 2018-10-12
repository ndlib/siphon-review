# Dockerfile

FROM ruby:2.4-alpine

RUN apk update && apk add nodejs git libxml2 libxml2-dev libxml2-utils make g++ mysql-dev openssl && rm -rf /var/cache/apk/*

COPY Gemfile ./Gemfile
RUN bundle update

COPY . /siphon
WORKDIR /siphon

RUN openssl req -nodes -x509 -new -keyout self_signed.key -out self_signed.cert \
  -subj "/C=US/ST=IN/O=University of Notre Dame/OU=LIBITS"

RUN bundle install --without test development

ARG DEFAULT_PORT="3000"
ENV PORT=$DEFAULT_PORT
EXPOSE $PORT

CMD chmod u+x docker/start.sh && docker/start.sh
