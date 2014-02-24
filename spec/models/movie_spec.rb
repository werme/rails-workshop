# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#  rating      :integer
#  category_id :integer
#

describe Movie do

  let(:category) { FactoryGirl.create :category }
  let(:movie) { FactoryGirl.create :movie }

  it "has a valid factory" do 
    expect(movie).to be_valid
  end

  context "when title is too short" do

    it "it is invalid" do
      movie = FactoryGirl.build(:movie, title: "A")
      expect(movie).to be_invalid
    end
  end

   context "when no category is given" do

    it "it is invalid" do
      movie = FactoryGirl.build(:movie, category: nil)
      expect(movie).to be_invalid
    end
  end

   context "when rating is too high" do

    it "it is invalid" do
      movie = FactoryGirl.build(:movie, rating: 11)
      expect(movie).to be_invalid
    end
  end

  describe "by_category scope" do

    let(:categoryA) { FactoryGirl.create(:category, title: "Category A") }
    let(:categoryB) { FactoryGirl.create(:category, title: "Category B") }
    
    let(:movieA) { FactoryGirl.create(:movie, title: "Movie A", category: categoryA) }
    let(:movieB) { FactoryGirl.create(:movie, title: "Movie B", category: categoryA) }
    let(:movieC) { FactoryGirl.create(:movie, title: "Movie C", category: categoryB) }

    context "when filtering by category" do 
      
      it "returns a array with all the movies in the given category" do 
        filtered_movies = Movie.by_category(categoryA)
        expect(filtered_movies).to include(movieA, movieB) 
      end 
   
      it "does not return movie not in the given category" do 
        filtered_movies = Movie.by_category(categoryA)
        expect(filtered_movies).to_not include(movieC) 
      end
    end
  end

  describe ".sanity" do

    context "when user is insane" do

      it "is reasonable" do
        romantic_comedy = FactoryGirl.create(:category, title: "Romantic Comedy")
        movie = FactoryGirl.build(:movie, category: romantic_comedy ,rating: 6)
        expect(movie).to be_invalid
      end
    end
  end

  describe ".accept_by_jesper" do

    context "when Old Boy is created" do

      it "always gets reasonable defaults" do
        movie = FactoryGirl.create(:movie, title: "Old Boy", description: "Ok movie", rating: 6)
        expect(movie.description).to eq("Best movie ever made")
        expect(movie.rating).to eq(10)
      end
    end
  end
end
