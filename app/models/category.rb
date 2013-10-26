class Category < ActiveRecord::Base
  has_many :movies

  validates :title, uniqueness: true  
end
