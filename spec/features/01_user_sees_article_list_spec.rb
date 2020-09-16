require "spec_helper"

feature "when navigating to index page" do
  scenario "A user will be redirected from the root page to the articles index" do
    visit "/"

    expect(page).to have_current_path("/articles")
  end
  
  scenario "user sees all article items" do
    CSV.open("articles.csv", "a", headers: true) do |csv|
      title = "Unicorns: What You Should Know"
      description = "Everything!!!"
      url = "http://www.unicornknowledge.com"
      csv.puts([title, description, url])
    end

    visit "/articles"
    expect(page).to have_content("Unicorns: What You Should Know")
    expect(page).to have_content("Everything!!!")
    expect(page).to have_content("http://www.unicornknowledge.com")
  end
end
