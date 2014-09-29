require 'sinatra'

get '/hi' do
  "Hello"
end

get '/' do
	erb :index
end