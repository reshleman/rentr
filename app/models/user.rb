class User < ActiveRecord::Base
  has_many :listings
  has_many :reservations

  has_many :reserved_listings,
           through: :reservations,
           source: :listing

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  def reservations_for(listing)
    reservations.where(listing: listing).includes(:listing)
  end

  def reserved?(listing)
    reserved_listings.include?(listing)
  end

  def owns?(listing)
    listing.user_id == id
  end
end
