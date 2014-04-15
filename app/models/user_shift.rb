require 'scheduler'

class UserShift < ActiveRecord::Base

  belongs_to :user
  belongs_to :shift

  validates :user, presence: true
  validates :shift, presence: true

  def self.schedule!
    Scheduler.new(UserShift.all).generate_schedule
  end

end
