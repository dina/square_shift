class UserShiftsController < ApplicationController
  before_action :authenticate_user!

  # expected params: array of shift ids that the user has selected
  def save_user_shifts
    # params[:shift_ids]
    new_shift_ids = [1,2,5] # TODO: parse this info from the params
    old_shift_ids = current_user.shifts.map(&:id)

    (new_shift_ids - old_shift_ids).each do |shift_id|
      current_user.user_shifts.create(shift_id: shift_id)
    end

    (old_shift_ids - new_shift_ids).each do |shift_id|
      current_user.user_shifts.find_by_shift_id(shift_id: shift_id).destroy
    end

    redirect_to shifts_path
  end

end
