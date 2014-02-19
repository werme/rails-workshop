class AddPosterUriToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :poster_uri, :string
  end
end
