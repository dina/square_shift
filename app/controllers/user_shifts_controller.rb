class UserShiftsController < ApplicationController
  before_action :authenticate_user!

  def index
    @all_shifts = Shift.all
    @current_user_shifts = current_user.user_shifts
  end

  # expected params: array of shift ids that the user has selected
  # saves the new availability for the employee
  def update_selections
    new_shift_ids = [1,2,5] # TODO: parse this info from the params (possibly from params[:shift_ids])
    current_user.update_shift_selections(new_shift_ids)

    redirect_to user_shifts_path
  end

end
