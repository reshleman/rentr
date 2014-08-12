class User < ActiveRecord::Base
  has_many :listings

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  def owns?(listing)
    listing.user_id == id
  end
end
