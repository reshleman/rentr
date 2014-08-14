class DateRange
  attr_reader :start_date, :end_date

  def initialize(dates)
    @start_date = dates[:start_date].to_date
    @end_date = dates[:end_date].to_date
  end

  def count
    (start_date...end_date).count
  end
end
