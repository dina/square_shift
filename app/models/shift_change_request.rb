class ShiftChangeRequest < ActiveRecord::Base
  module Status
    INITIATED = "initiated"
    ACCEPTED = "accepted"
    DECLINED = "declined"
  end

  module Type
    SWAP = "swap"
    COVER = "cover"
  end

  belongs_to :initiator, class_name:"User"
  belongs_to :original_user, class_name:"User"
  belongs_to :original_shift, class_name:"UserShift"
  belongs_to :original_user_shift, class_name:"UserShift"
  belongs_to :target_user, class_name:"User"
  belongs_to :target_shift, class_name:"Shift"
  belongs_to :target_user_shift, class_name:"UserShift"

  before_create { self.status ||= Status::INITIATED }


  # COVER REQUESTS
  def self.create_cover_request(initiator, original_user_shift, target_user)
    tus = target_user ? UserShift.find_by(user: target_user, shift: original_user_shift.shift) : nil

    create(initiator: initiator, type: Type::COVER,
           original_user: original_user_shift.user, target_user: target_user,
           original_user_shift: original_user_shift, target_user_shift: tus,
           original_shift: original_user_shift.shift
    )
  end

  def accept_cover_request
    original_user.user_shifts.create(shift: target_shift)
    target_user.user_shifts.create(shift: original_shift)
    original_user_shift.destroy
    target_user_shift.destroy
    status = ShiftChangeRequest::Status::ACCEPTED
    save
  end

  def decline_cover_request
    status = ShiftChangeRequest::Status::DECLINED
    save
  end
end
