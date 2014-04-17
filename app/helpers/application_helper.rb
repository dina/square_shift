module ApplicationHelper

  def display_shift_time(shift)
    shift.start_at.strftime('%A, %I:%M%p - ') + shift.end_at.strftime('%I:%M%p')
  end

  def display_datetime(datetime)
    datetime.strftime('%m/%d %I:%M %p')
  end

  def pretty_date(datetime)
    datetime.strftime('%A %I:%M%p')
  end

end
