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

  def reserve(user, start_date, end_date)
    if available_from?(start_date, end_date)
      make_unavailable_and_reserve(
        user,
        start_date,
        end_date
      )
    end
  end

  private

  def available_from?(start_date, end_date)
    count_dates_between(start_date, end_date) ==
      count_available_dates_between(start_date, end_date)
  end

  def make_unavailable_and_reserve(user, start_date, end_date)
    reservation = nil

    transaction do
      make_unavailable_from(start_date, end_date)
      reservation = create_reservation(user, start_date, end_date)
    end

    reservation
  end

  def make_unavailable_from(start_date, end_date)
    available_dates.
      where("date BETWEEN ? AND ?", start_date.to_date, end_date.to_date-1).
      destroy_all
  end

  def create_reservation(user, start_date, end_date)
    reservations.create(user: user, start_date: start_date, end_date: end_date)
  end

  def count_dates_between(start_date, end_date)
    (start_date...end_date).count
  end

  def count_available_dates_between(start_date, end_date)
    available_dates.
      where("date BETWEEN ? AND ?", start_date.to_date, end_date.to_date-1).
      count
  end
end
