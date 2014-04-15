class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_shifts
  has_many :shifts, through: :user_shifts

  # saves the new availability for the employee
  def update_shift_selections(new_shift_ids)
    old_shift_ids = user.shifts.map(&:id)

    (new_shift_ids - old_shift_ids).each do |shift_id|
      user.user_shifts.create(shift_id: shift_id)
    end

    (old_shift_ids - new_shift_ids).each do |shift_id|
      user.user_shifts.find_by_shift_id(shift_id: shift_id).destroy
    end

    redirect_to user_shifts_path
  end
end
