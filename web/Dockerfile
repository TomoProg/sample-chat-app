FROM ruby:2.6.3
MAINTAINER TomoProg <helloworld0306.xxx@gmail.com>
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    default-mysql-client \
    vim-tiny

RUN mkdir /myapp
WORKDIR /myapp
