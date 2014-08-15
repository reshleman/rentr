class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :user
  has_one :order

  validates :listing, presence: true
  validates :user, presence: true
  validates :start_date, date: { before: :end_date }
  validates :end_date, date: { after: :start_date }

  def total_price
    listing.price * (start_date...end_date).count
  end

  def price_in_cents
    total_price * 100
  end

  def listing_title
    listing.title
  end

  def guest_email
    user.email
  end

  def guest_stripe_customer
    user.stripe_customer
  end
end
