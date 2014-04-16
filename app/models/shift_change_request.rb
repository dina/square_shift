class ShiftChangeRequest < ActiveRecord::Base
  module Status
    INITIATED = 1
    ACCEPTED = 2
    REJECTED = 3
  end

  belongs_to :initiator, class_name:"User"
  belongs_to :original_user_shift, class_name:"UserShift"

  belongs_to :target_user, class_name:"User"
  belongs_to :target_user_shift, class_name:"UserShift"


  # initiator will always exist
  def self.build(initiator, original_user_shift, target_user, target_user_shift)
    req = new(initiator: initiator, original_user_shift: original_user_shift, target_user: target_user, target_user_shift: target_user_shift)
    
  end
end
