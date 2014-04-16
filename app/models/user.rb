class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_shifts
  has_many :shifts, through: :user_shifts

  # saves the new availability for the employee
  def update_shift_selections(new_shift_ids)
    old_shift_ids = shifts.map(&:id)
    new_shift_ids ||= []

    user_shifts.where(shift_id: (old_shift_ids - new_shift_ids)).destroy_all
    (new_shift_ids - old_shift_ids).each { |shift_id| user_shifts.create(shift_id: shift_id)}
  end

  def provided_availability?
    UserShift.where(user: self).any?
  end

  # SWAP REQUESTS
  def create_swap_request(original_user_shift, target_user_shift)
    ShiftChangeRequest.create_swap_request(self, original_user_shift, target_user_shift)
  end

  def accept_swap_request(request)
    request.accept_swap_request(self)
  end

  def decline_swap_request(request)
    request.accept_swap_request(self)
  end

end
