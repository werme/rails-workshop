namespace :bootstrap do
  desc "Add default categories"
  task default_categories: :environment do
    ['Comedy', 'Romantic Comedy', 'Thriller', 'Science Fiction', 'Horror', 'Drama', 'Documentary', 'Action', 'Family'].each do |title|
      Category.create(title: title)
    end
  end

  desc "Add default movies"
  task default_movies: :environment do
    Movie.create(title:'Old Boy', description:'Best movie ever made', rating: 10, category_id: 2)
    Movie.create(title:'Dumb Dumber', description:'They ARE quite dumb', rating: 7, category_id: 1)
    Movie.create(title:'Avatar', description:'Insultingly stupid, but quite beautiful', rating: 5, category_id: 3)
    Movie.create(title:'Snatch', description:'Hardcore and badass', rating: 9, category_id: 7)
    Movie.create(title:'Amelie', description:'Only romantic movie ever made', rating: 9, category_id: 5)
    Movie.create(title:'Donkey Kong and a fistful of quarters', description:'They love that game man', rating: 8, category_id: 6)
    Movie.create(title:'Robocop', description:'Badass and good satire', rating: 7, category_id: 7)
    Movie.create(title:'Terminator', description:'Arnold', rating: 9, category_id: 7)
    Movie.create(title:'Descpicable me', description:'All about the minions!', rating: 8, category_id: 8)
    Movie.create(title:'Megamind', description:'PRESENTATION', rating: 8, category_id: 8)
  end

  desc "Run all bootstrapping tasks"
  task all: [:default_categories, :default_movies]
end