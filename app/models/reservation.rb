class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :user
  has_one :review

  validates :listing, presence: true
  validates :user, presence: true
  validates :start_date, date: { before: :end_date }
  validates :end_date, date: { after: :start_date }
end
