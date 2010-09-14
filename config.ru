require 'rubygems'
require 'bundler/setup'
require 'vol'

run Rack::Handler::WEBrick.run Sinatra::Application, :Port => 3400