require "spec_helper"

feature "user sees article list" do
  scenario "user views all article list items" do
    CSV.open("articles.csv", "a", headers: true) do |csv|
      title = "Unicorns: What You Should Know"
      description = "Everything!!!"
      url = "http://www.unicornknowledge.com"
      csv.puts([title, description, url])
    end

    visit "/articles"
    expect(page).to have_content("tacos")
  end

  scenario "user sees all article items at root path due to a redirect" do
    CSV.open("articles.csv", "a", headers: true) do |csv|
      title = "Unicorns: What You Should Know"
      description = "Everything!!!"
      url = "http://www.unicornknowledge.com"

      csv << [title, description, url]
    end

    visit "/"
    expect(page).to have_content("Unicorns: What You Should Know")
    expect(current_path).to eq("/articles")
  end
end

feature "user adds article" do
  scenario "item added when filled form submitted" do
    visit "/articles"

    fill_in "Title", with: "Mushrooms are from Space"
    fill_in "Description", with: "totes aliens yo"
    fill_in "URL", with: "http://www.mushroomsspace.com"
    click_on "Add Article"

    expect(page).to have_content("Mushrooms are from Space")
    expect(page.current_path).to eq "/articles"
  end

  scenario "empty li element is not added when form missing name is submitted" do
    visit "/articles/new"
    click_on "Add Article"

    expect(page.current_path).to eq "/articles/new"
  end
end
