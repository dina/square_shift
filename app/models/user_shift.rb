require 'scheduler'

class UserShift < ActiveRecord::Base

  belongs_to :user
  belongs_to :shift

  validates :user, presence: true
  validates :shift, presence: true

  scope :scheduled, -> {where(scheduled: true)}

  # saves the new assignments
  def self.update_assignments(new_assignments)
    # clear the initial 'scheduled' flags
    UserShift.scheduled.each(&:unschedule!)

    # TODO: Validations.
    # Details: we are skipping a bunch of validations here.
    # For instance, this code can be fooled into setting the 'scheduled' flags for two user_shifts that correspond to the same shift.

    # set the 'scheduled' flags of new assignments
    UserShift.find(new_assignments).each(&:schedule!)

    redirect_to :index
  end

  def self.generate_schedule!
    return if Schedule.published?

    UserShift.scheduled.each(&:unschedule!)
    scheduler = Scheduler.new(UserShift.all, Shift.all)
    scheduled_user_shifts = scheduler.generate_schedule
    scheduled_user_shifts.each(&:schedule!)
    scheduled_user_shifts
  end

  def scheduled?
    self.scheduled
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
