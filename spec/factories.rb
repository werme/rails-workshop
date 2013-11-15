FactoryGirl.define do
  
  factory :category do
    title "Category Title"
  end
  
  factory :movie do
    title "Movie Title"
    rating 5
    category { create(:category) } 
  end
end