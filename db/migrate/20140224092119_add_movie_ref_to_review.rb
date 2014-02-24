class AddMovieRefToReview < ActiveRecord::Migration
  def change
    add_reference :reviews, :movie, index: true
  end
end
