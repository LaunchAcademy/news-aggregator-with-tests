require "sinatra"

require "sinatra/reloader" if development?
require "pry" if development? || test?
require "csv"

set :bind, '0.0.0.0'  # bind to all interfaces

def articles_csv 
  if ENV["RACK_ENV"] == "test"
    return "articles_test.csv"
  else
    return "articles.csv"
  end
end