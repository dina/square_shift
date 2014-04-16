class ShiftChangeRequest < ActiveRecord::Base
  module Status
    INITIATED = 1
    ACCEPTED = 2
    REJECTED = 3
  end

  belongs_to :initiator, class_name:"User"
  belongs_to :original_user, class_name:"User"
  belongs_to :original_shift, class_name:"UserShift"
  belongs_to :original_user_shift, class_name:"UserShift"
  belongs_to :target_user, class_name:"User"
  belongs_to :target_shift, class_name:"Shift"
  belongs_to :target_user_shift, class_name:"UserShift"


  # initiator will always exist
  def self.initiate(initiator, target_user, original_user_shift=nil, original_shift=nil, target_shift=nil)
    # only an admin or the user themselves can request a change with that user set as origin
    raise "Not Authorized" if !initiator.admin? and original_user_shift.user != initiator


    create(initiator: initiator, target_user: target_user, original_user_shift: original_user_shift, target_user_shift: target_user_shift, status: Status::INITIATED)
  end
end
