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

  SEARCH_RANGE = 0..99

  def self.search(search_params)
    result_set = where("city ILIKE ?", "%#{search_params[:city]}%")

    if search_params[:price].present?
      result_set = result_set.where("price <= ?", search_params[:price])
    end

    if search_params[:property_category].present?
      result_set = result_set.
        where("property_category_id = ?", search_params[:property_category])
    end

    if search_params[:accommodates].present?
      result_set = result_set.
        where("accommodates <= ?", search_params[:accommodates])
    end
    result_set
  end

  def make_available_on(date)
    available_dates.new(date).save
  end
end
