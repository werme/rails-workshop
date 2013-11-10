require "spec_helper"

feature "Movie management" do

  before do
    FactoryGirl.create(:category, title: "Comedy")
  end

  def addMovie
    visit "/movies/new"

    fill_in "Title", :with => "My awesome movie"
    select "Comedy", from: "movie_category_id"
    fill_in "movie_rating", :with => "1"
    click_button "Create Movie"
  end

  scenario "User adds a new movie" do
    expect { addMovie }.to change(Movie, :count)
    expect(page).to have_text "Movie was successfully added."
  end

  scenario "User tries to adds an invalid movie" do
    visit "/movies/new"

    expect { click_button "Create Movie" }.not_to change(Movie, :count)
    expect(page).to have_text "3 errors prohibited this post from being saved"
  end
end