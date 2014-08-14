class DateRange
  attr_reader :start_date, :end_date

  def initialize(options)
    @start_date = options.start_date
    @end_date = options.end_date
  end

  def count
    (start_date...end_date).count
  end
end
