class Review < ActiveRecord::Base
  belongs_to :reservation
  validates :body, presence: true
  validates :reservation, presence: true, uniqueness: true
end
