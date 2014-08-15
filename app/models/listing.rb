class Listing < ActiveRecord::Base
  has_many :available_dates
  has_many :photos
  belongs_to :property_category
  belongs_to :room_category
  belongs_to :user

  validates :city, presence: true
  validates :address, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :title, presence: true
  validates :user, presence: true
  validates :accommodates, presence: true, numericality: { greater_than: 0 }

  def self.search(search_params)
    city(search_params[:city]).
      price(search_params[:price]).
      property_category(search_params[:property_category]).
      room_category(search_params[:room_category])
  end

  def self.city(city)
    query_if_present(city) do |c|
      where("city ILIKE ?", "%#{c}%")
    end
  end

  def self.price(price)
    query_if_present(price) do |p|
      where("price <= ?", p)
    end
  end

  def self.property_category(category)
    query_if_present(category) do |ct|
      where("property_category_id = ?", ct)
    end
  end

  def self.room_category(category)
    query_if_present(category) do |cat|
      where("room_category_id = ?", cat)
    end
  end

  def self.query_if_present(term, &block)
    if term.present?
      block.call(term)
    else
      all
    end
  end

  def make_available_on(date)
    available_dates.new(date).save
  end
end
