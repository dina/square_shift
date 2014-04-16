module ApplicationHelper

  def display_shift_time(start_datetime, end_datetime)
    "#{display_datetime(start_datetime)} - #{display_datetime(end_datetime)}"
  end

  def display_datetime(datetime)
    datetime.strftime('%m/%d %I:%M %p')
  end

end
