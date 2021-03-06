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

class Movie < ActiveRecord::Base
  include OMDB

  belongs_to :category
  has_many :reviews

  validates :title, presence: true, uniqueness: { case_sensitive: false }, length: { in: 2..60 }
  validates :category, presence: true
  validates :rating, inclusion: { in: 1..10, message: "%{value} is not in valid range 1 - 10." }
  validate :sanity

  scope :by_category, -> category { where(category: category) }

  before_create :update_info_from_omdb, :accept_by_jesper
  before_save :accept_by_jesper

  private

  def sanity
    if self.category and self.category.title == "Romantic Comedy" and self.rating > 5
      errors.add("Rating: ","A romantic comedy can't possibly be that good.")
    end
  end

  def accept_by_jesper
    if self.title == "Old Boy"
      self.rating = 10
      self.description = "Best movie ever made"
    end
  end

  def update_info_from_omdb
    result = query_omdb(self.title)

    self.year        = result["Year"]
    self.description = result["Plot"]
    self.poster_uri  = result["Poster"]
  end
end
