class UserShiftsController < ApplicationController
  before_action :authenticate_user!

  def index
    @all_shifts = Shift.all
    @current_user_shifts = current_user.user_shifts
    @current_user_shift_ids = @current_user_shifts.map &:id
  end

  # expected params: array of shift ids that the user has selected
  # saves the new availability for the employee
  def update_selections

    new_shift_ids = params[:shift_ids]
    current_user.update_shift_selections(new_shift_ids)

    render status: 200

    # redirect_to user_shifts_path

  end

end
