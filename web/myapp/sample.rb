# myapp.rb
require "bundler/setup"
require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
  'Hello world!'
end

post '/api/login' do
  '/api/login'
end
