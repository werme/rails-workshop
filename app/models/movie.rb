class Movie < ActiveRecord::Base
  belongs_to :category

  validates :title, presence: true, uniqueness: { case_sensitive: false }, length: { in: 2..60 }
  validates :category, presence: true
  validates :rating, inclusion: { in: 1..10, message: "%{value} is not in valid range 1 - 10." }
end

