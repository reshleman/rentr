class Listing < ActiveRecord::Base
  has_many :available_dates
  has_many :photos
  belongs_to :property_category
  belongs_to :room_category
  belongs_to :user
  has_many :reservations
  has_many :reviews, through: :reservations

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

  def reserve(user, date_range)
    if available_during?(date_range)
      book(user, date_range)
    else
      NullReservation.new
    end
  end

  private

  def available_during?(date_range)
    count_dates_between(date_range) ==
      count_available_dates_between(date_range)
  end

  def book(user, date_range)
    transaction do
      book_during(date_range)
      create_reservation(user, date_range)
    end
  end

  def book_during(date_range)
    available_date_range(date_range).destroy_all
  end

  def create_reservation(user, date_range)
    reservations.create(
      user: user,
      start_date: date_range.start_date,
      end_date: date_range.end_date
    )
  end

  def count_dates_between(date_range)
    date_range.days_in_range
  end

  def count_available_dates_between(date_range)
    available_date_range(date_range).count
  end

  def available_date_range(date_range)
    available_dates.where(
      "date BETWEEN ? AND ?",
      date_range.start_date,
      date_range.end_date - 1
    )
  end
end
