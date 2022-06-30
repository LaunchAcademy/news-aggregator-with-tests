require "spec_helper"

feature "when adding a new article" do
  scenario "a user can navigate to the form page from the articles index page" do
    visit "/articles"
    
    # save_and_open_page

    click_link "Add a new article"
    expect(page).to have_content("New Article Form")
  end

  scenario "user is redirected to index and sees article if successful" do
    visit "/articles/new"

    fill_in "Title", with: "Mushrooms are from Space"
    fill_in "Description", with: "totes aliens yo"
    fill_in "URL", with: "http://www.mushroomsspace.com"
    click_on "Add Article"

    expect(page).to have_content("Mushrooms are from Space")
    expect(page.current_path).to eq "/articles"
  end

  scenario "user remains on page if form submission is unsuccessful" do
    visit "/articles/new"
    click_on "Add Article"

    expect(page).to have_content("New Article Form")
  end
end