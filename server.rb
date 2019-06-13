require "sinatra"

require "sinatra/reloader" if development?
require "pry" if development? || test?
require "csv"

set :bind, '0.0.0.0'  # bind to all interfaces

get '/articles' do
  @articles = []

  CSV.foreach("articles.csv", headers:true) do |row|
    @articles << row.to_hash
    # @articles << {title: row["title"], description: row["description"], url: row["url"]}
  end

  erb :index
end

get "/articles/new" do
  erb :new
end

post "/articles/new" do
  # take the inputs from the form (using params)
  title = params["title"]
  description = params["description"]
  url = params["url"]

  if title.strip != "" && description.strip != "" && url.strip != ""
    # write to the CSV file with those params
    CSV.open("articles.csv", "a") do |csv_file|
      csv_file << [title, description, url]
    end

    # redirect back to the articles index page
    redirect "/articles"
  else
    @error = "You have to fill out all of the fields in order to be dope!"

    erb :new
  end


end
