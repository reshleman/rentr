class AvailableDate < ActiveRecord::Base
  belongs_to :listing

  validates :date, date: true, uniqueness: { scope: :listing_id }
  validates :listing, presence: true
end
