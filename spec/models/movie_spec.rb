describe Movie do
  let(:category) { FactoryGirl.create :category }

  it 'creates a movie' do
    Movie.create!(title: "My test movie", rating: 1, category: category)
  end
end