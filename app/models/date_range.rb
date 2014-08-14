class DateRange
  attr_reader :start_date, :end_date

  def initialize(date_range)
    @start_date = date_range[:start_date].to_date
    @end_date = date_range[:end_date].to_date
  end

  def invalid?
    @start_date.nil? || @end_date.nil?
  end

  def count
    (start_date...end_date).count
  end
end
