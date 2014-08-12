module DateHelpers
  def format_date(date, format = :long_ordinal)
    date.to_formatted_s(format)
  end
end
