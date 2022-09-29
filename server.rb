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

get "/" do 
  redirect "/articles"
end

get "/articles" do 
  @articles = CSV.readlines(articles_csv, headers: true)

  erb :list
end

get '/articles/new' do
  erb :form 
end

post "/articles" do 
  title = params["title"]
  description = params["description"]
  url = params["URL"]

  if !title.strip.blank?

    CSV.open(articles_csv, "a") do |csv| 
      csv << [title, description, url]
    end

    redirect "/articles"
  else 
    erb :form
  end
end