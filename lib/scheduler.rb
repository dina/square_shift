class Scheduler

  def initialize(user_shifts, shifts)
    @user_shifts = user_shifts
    @shifts = shifts
  end

  def generate_schedule
    selected = []
    @shifts.each do |shift|
      possible_user_shifts = @user_shifts.select { |us| us.shift == shift }
      next if possible_user_shifts.none?
      index = Random.new.rand(possible_user_shifts.count)
      selected << possible_user_shifts[index]
    end
    selected
  end

end
