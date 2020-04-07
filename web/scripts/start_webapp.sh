#!/bin/bash

# Bundle install
bundle install --path /myapp/vendor/bundle

# start server
ruby /myapp/sample.rb -p "$APP_PORT" -o '0.0.0.0'

# 何かしらプロセスが永続的に起動していないと
# dockerが落ちてしまうため、tailしておく
tail -f /dev/null
