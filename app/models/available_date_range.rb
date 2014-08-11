class AvailableDateRange < ActiveRecord::Base
  belongs_to :listing

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :listing, presence: true
end
