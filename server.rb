require "sinatra"

require "sinatra/reloader" if development?
require "pry" if development? || test?
require "csv"

set :bind, '0.0.0.0'  # bind to all interfaces

get "/" do
  redirect "/articles"
end

get "/articles" do
  @articles = CSV.readlines("articles.csv", headers: true)
  # binding.pry
  erb :index
end

get "/articles/new" do
  erb :new
end

post "/articles/new" do
  # binding.pry
  title = params["article_title"]
  description = params["article_description"]
  url = params["article_url"]

  if title.strip == "" || description.strip == "" || url.strip == ""
    # data is not valid
    erb :new
  else
    # happy path
    CSV.open("articles.csv", "a", headers: true) do |csv|
      csv << [title, description, url]
    end
    redirect "/articles"
  end
end