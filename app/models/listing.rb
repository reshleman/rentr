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

  def reserve(user, date_range)
    if available_from?(date_range)
      make_unavailable_and_reserve(user, date_range)
    else
      NullReservation.new
    end
  end

  private

  def available_from?(date_range)
    count_dates_between(date_range) ==
      count_available_dates_between(date_range)
  end

  def make_unavailable_and_reserve(user, date_range)
    reservation = nil

    transaction do
      make_unavailable_from(date_range)
      reservation = create_reservation(user, date_range)
    end

    reservation
  end

  def make_unavailable_from(date_range)
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
    date_range.count
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
