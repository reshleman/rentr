class Listing < ActiveRecord::Base
  belongs_to :user

  validates :city, presence: true
  validates :address, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :title, presence: true
  validates :user, presence: true

  def self.search(query)
    where("city ILIKE ?", "%#{query}%")
  end
end
