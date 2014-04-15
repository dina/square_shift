require 'scheduler'

class UserShift < ActiveRecord::Base

  belongs_to :user
  belongs_to :shift

  validates :user, presence: true
  validates :shift, presence: true

  def self.find_schedule
    UserShift.all.each(&:unschedule!)
    scheduler = Scheduler.new(UserShift.all, Shift.all)
    scheduled_user_shifts = scheduler.generate_schedule
    scheduled_user_shifts.each(&:schedule!)
    scheduled_user_shifts
  end

  def schedule!
    self.scheduled = true
    self.save!
  end

  def unschedule!
    self.scheduled = false
    self.save!
  end

end
