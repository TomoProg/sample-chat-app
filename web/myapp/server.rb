require "bundler/setup"
require 'sinatra'
require_relative 'models/user'
if development?
  require 'sinatra/reloader' if development?
  require 'pry'
end

get '/' do
  'Hello world!'
end

post '/api/login' do
  param = JSON.parse(request.body.read)
  binding.pry
  Models::User.login(param["email"], param["password"])
end

post '/api/signup' do
  param = JSON.parse(request.body.read)
  Models::User.new(
    email: param["email"],
    password: param["password"],
    name: param["user_name"],
  ).create
  'OK'
end
