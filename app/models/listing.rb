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

  def reserve(user, reservation_params)
    start_date = reservation_params[:start_date]
    end_date = reservation_params[:end_date]
    reservation = []
    transaction do
      if available?(start_date, end_date)
        reservation << reservations.create(user: user,
                            start_date: start_date,
                            end_date: end_date)
        make_unavailable_on(start_date, end_date)
      end
    end
    reservation.first
  end

  def available?(start_date, end_date)
    nights = start_date...end_date
    nights.each do |night|
      unless available_dates.find_by(date: night)
        return false
      end
    end
  end

  def make_unavailable_on(start_date, end_date)
    nights = start_date...end_date
    available_dates.where("date BETWEEN ? AND ?",
                          nights.min,
                          nights.max).
                          delete_all
  end
end
