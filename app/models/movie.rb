class Movie < ActiveRecord::Base
  belongs_to :category

  validates :title, presence: true, uniqueness: { :case_sensitive => false }, length: { in: 2..60 }
  validates :category, presence: true
  validates :rating, :inclusion => 1..10

  before_update :accept_by_jesper 

  scope :by_category, ->(category) { where category_id: category }
  scope :by_rating, ->(rating) { where "rating >= ?", rating }

  private

  def accept_by_jesper
    if self.title == 'Old Boy'
      self.rating = 10
      self.description = 'Best movie ever made'
    end
  end
end
