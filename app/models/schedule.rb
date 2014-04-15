class Schedule < ActiveRecord::Base
  def self.scheduled?
    sch = Schedule.last
    !!sch and sch.scheduled
  end
end
