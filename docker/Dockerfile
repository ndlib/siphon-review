# Dockerfile

FROM ruby:2.4-alpine

RUN apk update && apk add wget nodejs git libxml2 libxml2-dev libxml2-utils make g++ mysql-dev openssl && rm -rf /var/cache/apk/*

COPY Gemfile ./Gemfile
RUN bundle update

COPY . /siphon
WORKDIR /siphon

ENV CHAMBER_KMS_KEY_ALIAS=aws/ssm
ARG DEFAULT_ENV_SSM_PATH="all/siphon/prod"
ENV ENV_SSM_PATH=$DEFAULT_ENV_SSM_PATH

RUN openssl req -nodes -x509 -new -keyout self_signed.key -out self_signed.cert \
  -subj "/C=US/ST=IN/O=University of Notre Dame/OU=LIBITS"

RUN bundle install --without test development

RUN wget https://github.com/segmentio/chamber/releases/download/v2.2.0/chamber-v2.2.0-linux-amd64 -O /bin/chamber && \
  chmod +x /bin/chamber

ARG DEFAULT_PORT="3000"
ENV PORT=$DEFAULT_PORT
EXPOSE $PORT

# The CMD will need to be updated - it is not prod ready
CMD chmod u+x docker/start.sh && docker/start.sh
