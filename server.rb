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
  # binding.pry
  erb :index
end

get "/articles/new" do
  erb :new
end

post "/articles/new" do
  # binding.pry
  title = params["title"]
  description = params["description"]
  url = params["url"]

  if title == "" || description == "" || url == ""
  # if title.strip == "" || description.strip == "" || url.strip == ""
  # ^^ using `strip`!
    erb :new
  else
    CSV.open(articles_csv, "a", headers: true) do |csv|
      csv << [title,description,url]
    end

    redirect "/articles"
  end
end