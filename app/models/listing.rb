class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :available_date_ranges

  validates :city, presence: true
  validates :address, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :title, presence: true
  validates :user, presence: true
end
