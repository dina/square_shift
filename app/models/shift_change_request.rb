class ShiftChangeRequest < ActiveRecord::Base
  module Status
    INITIATED = "initiated"
    ACCEPTED = "accepted"
    DECLINED = "declined"
  end

  module Type
    SWAP = "swap"
  end

  belongs_to :initiator, class_name:"User"
  belongs_to :original_user, class_name:"User"
  belongs_to :original_shift, class_name:"UserShift"
  belongs_to :original_user_shift, class_name:"UserShift"
  belongs_to :target_user, class_name:"User"
  belongs_to :target_shift, class_name:"Shift"
  belongs_to :target_user_shift, class_name:"UserShift"

  before_create { self.status ||= Status::INITIATED }


  # SWAP REQUESTS

  def self.create_swap_request(initiator, original_user_shift, target_user_shift)
    raise "Not Authorized!" if initiator != original_user_shift.user

    # assume, for now, that only the original_user can initiate a swap request for one of his user_shifts
    create(initiator: initiator, type: Type::SWAP,
           original_user: original_user_shift.user, target_user: target_user_shift.user,
           original_user_shift: original_user_shift, target_user_shift: target_user_shift,
           original_shift: original_user_shift.shift, target_shift: target_user_shift.shift
    )
  end

  def accept_swap_request(user)
    raise "Not Authorized" if target_user != user

    original_user.user_shifts.create(shift: target_shift)
    target_user.user_shifts.create(shift: original_shift)
    original_user_shift.destroy
    target_user_shift.destroy
    status = ShiftChangeRequest::Status::ACCEPTED
    save
  end

  def decline_swap_request(user)
    raise "Not Authorized" if target_user != user

    status = ShiftChangeRequest::Status::DECLINED
    save
  end
end
