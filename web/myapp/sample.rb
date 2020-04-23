# myapp.rb
require "bundler/setup"
require 'sinatra'
if development?
  require 'sinatra/reloader' if development?
  require 'pry'
end

get '/' do
  'Hello world!'
end

post '/api/login' do
  '/api/login'
end

post '/api/signup' do
  param = JSON.parse(request.body.read)
  binding.pry
  '/api/signup'
end
