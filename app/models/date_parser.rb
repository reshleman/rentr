class DateParser
  def initialize(options)
    @start_date = options[:start_date]
    @end_date = options[:end_date]
  end

  def valid?
    start_date && end_date
  end

  def start_date
    @start_date.to_date
  end

  def end_date
    @end_date.to_date
  end
end
