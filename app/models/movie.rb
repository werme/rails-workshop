class Movie < ActiveRecord::Base
  belongs_to :category
  has_many :reviews

  validates :title, presence: true, uniqueness: { :case_sensitive => false }, length: { in: 2..60 }
  validates :category, presence: true
  validates :rating, inclusion: { in: 1..10, message: "%{value} is not in valid range 1 - 10." }
  validate :sanity

  before_save :accept_by_jesper 

  scope :by_category, ->(category) { where category_id: category }
  scope :by_rating, ->(rating) { where "rating >= ?", rating }

  private

  def sanity
    if category.title == "Romantic Comedy" and rating > 5
      errors.add("Rating: ","A romantic comedy can't possibly be that good.")
    end
  end

  def accept_by_jesper
    if self.title == 'Old Boy'
      self.rating = 10
      self.description = 'Best movie ever made'
    end
  end
end
