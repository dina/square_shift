class Schedule < ActiveRecord::Base
  def self.published?
    sch = Schedule.last
    !!sch and sch.published
  end

  def self.publish!
    return if published?
    if Schedule.any?
      Schedule.last.update_attribute :published, true
    else
      Schedule.create(published: true)
    end
  end

  def self.unpublish!
    Schedule.destroy_all
  end

end
