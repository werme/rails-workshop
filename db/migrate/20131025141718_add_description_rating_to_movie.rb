class AddDescriptionRatingToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :description, :text
    add_column :movies, :rating, :integer
  end
end
