class AvailableDateRange < ActiveRecord::Base
  belongs_to :listing

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :listing, presence: true

  validate :start_date_is_a_date
  validate :end_date_is_a_date
  validate :start_date_is_before_end_date

  before_create :extend_availability

  def availability
    start_date..end_date
  end

  private

  def extend_availability
    listing.available_date_ranges.each do |range|
      availability_overlaps?(range)
    end
  end

  def availability_overlaps?(range)
    if range.availability.overlaps?(availability)
      new_start_and_end = range_values(range)
      update_range(range, new_start_and_end)
    end
  end

  def range_values(range)
    earliest_date = earlier_date(range.start_date, start_date)
    latest_date = later_date(range.end_date, end_date)
    { start_date: earliest_date, end_date: latest_date }
  end

  def update_range(range, values)
    if range != self
      range.update(values)
    end
  end

  def later_date(date_1, date_2)
    if date_1 <=> date_2 = 1
      date_1
    elsif date_1 <=> date_2 = -1
      date_2
    end
  end

  def earlier_date(date_1, date_2)
    if date_1 <=> date_2 = -1
      date_1
    elsif date_1 <=> date_2 = 1
      date_2
    end
  end

  def start_date_is_before_end_date
    if start_date > end_date
      errors.add(:date, "Start date must be before end date.")
    end
  end

  def start_date_is_a_date
    unless start_date.is_a?(Date)
      errors.add(:start_date, "Start date must be a valid date")
    end
  end

  def end_date_is_a_date
    unless end_date.is_a?(Date)
      errors.add(:end_date, "End date must be a valid date")
    end
  end
end
