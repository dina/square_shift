class Schedule < ActiveRecord::Base
  def self.published?
    sch = Schedule.last
    !!sch and sch.published
  end

  def self.publish!
    return if

    if Schedule.any?
      Schedule.last.update_attribute :published, true
    else
      Schedule.create(published: true)
    end
  end
end
