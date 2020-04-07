#!/bin/bash

sed -i -e "s/FRONT_PORT/$FRONT_PORT/g" /etc/nginx/conf.d/default.conf
sed -i -e "s/APP_HOST/$APP_HOST/g" /etc/nginx/conf.d/default.conf
sed -i -e "s/APP_PORT/$APP_PORT/g" /etc/nginx/conf.d/default.conf
nginx -g "daemon off;"
