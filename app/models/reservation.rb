class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :user

  validates :listing, presence: true
  validates :user, presence: true
  validates :start_date, presence: true,
            date: { before_or_equal_to: Proc.new { :end_date } }
  validates :end_date, presence: true,
            date: { after_or_equal_to: Proc.new { :start_date } }
end
