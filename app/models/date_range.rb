class DateRange
  attr_reader :start_date, :end_date

  def initialize(date_range)
    @start_date = date_range[:start_date]
    @end_date = date_range[:end_date]
  end

  def stay
    start_date...end_date
  end
end
