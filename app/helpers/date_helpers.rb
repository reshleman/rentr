module DateHelpers
  def start_date(available_date_range)
    format_time(available_date_range.start_date)
  end

  def end_date(available_date_range)
    format_time(available_date_range.end_date)
  end

  private

  def format_time(date, format = :long_ordinal)
    date.to_formatted_s(format)
  end
end
