class AvailableDateRange < ActiveRecord::Base
  belongs_to :listing

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :listing, presence: true

  def availability_range
    start_date..end_date
  end
end
