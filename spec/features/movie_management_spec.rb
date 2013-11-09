require "spec_helper"

feature "Movie management" do

  before do
    FactoryGirl.create(:category, title: "Comedy")
  end

  scenario "User adds a new movie" do
    visit "/movies/new"

    fill_in "Title", :with => "My awesome movie"
    select "Comedy", from: "movie_category_id"
    fill_in "movie_rating", :with => "1"
    click_button "Create Movie"

    expect(page).to have_text "Movie was successfully added."
  end

  scenario "User tries to adds an invalid movie" do
    visit "/movies/new"

    click_button "Create Movie"

    expect(page).to have_text "3 errors prohibited this post from being saved"
  end
end