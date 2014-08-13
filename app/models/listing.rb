class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :available_dates
  has_many :reservations

  validates :city, presence: true
  validates :address, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :title, presence: true
  validates :user, presence: true
  validates :accommodates, presence: true, numericality: { greater_than: 0 }

  def self.search(query)
    where("city ILIKE ?", "%#{query}%")
  end

  def make_available_on(date)
    available_dates.new(date).save
  end
end
