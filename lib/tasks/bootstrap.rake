namespace :bootstrap do
  desc "Add default categories"
  task :default_categories => :environment do
    ['Comedy', 'Thriller'].each do |title|
      Category.create(title: title)
    end
  end

  desc "Add default movies"
  task :default_movies => :environment do
    Movie.create(title: 'Old boy', description: "Best movie ever made.", rating: 10, category_id: 2)
  end

  desc "Run all bootstrapping tasks"
  task :all => [:default_categories, :default_movies]
end