class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :available_dates
  belongs_to :property_category

  validates :city, presence: true
  validates :address, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :title, presence: true
  validates :user, presence: true
  validates :accommodates, presence: true, numericality: { greater_than: 0 }

  def self.search(search_params)
    result_set = where("city ILIKE ?", "%#{search_params[:city]}%")

    if search_params[:price].present?
      result_set = result_set.where("price <= ?", search_params[:price])
    end

    result_set
  end

  def make_available_on(date)
    available_dates.new(date).save
  end
end
