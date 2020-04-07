FROM nginx:1.15.4
MAINTAINER TomoProg <helloworld0306.xxx@gmail.com>
RUN apt-get update -qq && apt-get install -y \
    vim-tiny \
    openssl
ADD config/nginx.conf /etc/nginx/
ADD config/default.conf /etc/nginx/conf.d/
