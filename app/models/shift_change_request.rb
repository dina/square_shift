class ShiftChangeRequest < ActiveRecord::Base
  module Status
    OPEN = "open"
    ACCEPTED = "accepted"
    DECLINED = "declined"
    CLOSED = "closed" # indirectly by others
  end

  module Kind
    SWAP = "swap"
    COVER = "cover"
  end

  belongs_to :initiator, class_name: "User"
  belongs_to :original_user, class_name: "User"
  belongs_to :original_shift, class_name: "UserShift"
  belongs_to :original_user_shift, class_name: "UserShift"
  belongs_to :target_user, class_name: "User"
  belongs_to :target_shift, class_name: "Shift"
  belongs_to :target_user_shift, class_name: "UserShift"

  scope :open,->{where(kind: Status::OPEN)}

  before_create { self.status ||= Status::OPEN }

  def open?
    status == Status::OPEN
  end

  # COVER REQUESTS
  def self.create_cover_request(initiator, original_user_shift, target_user)
    target_users = target_user ? [target_user] : (User.all - original_user_shift.user)

    creation_proc = Proc.new do |tu, ref_req_id|
      create(initiator: initiator, kind: Kind::COVER, reference_request_id: ref_req_id,
             original_user: original_user_shift.user, target_user: tu,
             original_user_shift: original_user_shift,
             original_shift: original_user_shift.shift)
    end

    reference_request = creation_proc.call(target_users.shift, nil)
    reference_request.update_attribute(reference_request_id: reference_request.id)
    target_users.each {|tu| creation_proc.call(tu, reference_request.id)}
  end

  def accept_cover_request
    target_user_shift = target_user.user_shifts.find_or_create_by(shift: original_shift)
    target_user_shift.schedule!
    original_user_shift.unschedule!
    status = ShiftChangeRequest::Status::ACCEPTED
    save

    ShiftChangeRequest.open.where(reference_request_id: reference_request_id).each { req.close }
  end

  def decline
    status = ShiftChangeRequest::Status::DECLINED
    save
  end

  def close
    status = ShiftChangeRequest::Status::CLOSED
    save
  end

end
