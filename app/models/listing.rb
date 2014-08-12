class Listing < ActiveRecord::Base
  belongs_to :user

  validates :city, presence: true
  validates :address, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :title, presence: true
  validates :user, presence: true
  validates :accommodates, presence: true, numericality: { greater_than: 0 }

  def self.search(query = "", price)
    if price.blank?
      price = 99999
    end
    where("city ILIKE ?", "%#{query}%").
    where("price <= ?", price)
  end
end
