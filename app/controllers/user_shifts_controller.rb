class UserShiftsController < ApplicationController
  before_action :authenticate_user!

  def index
    @all_shifts = Shift.all
    @current_shift_ids = current_user.shifts.map &:id
  end

  # expected params: array of shift ids that the user has selected
  # saves the new availability for the employee
  def update_selections
    current_user.update_shift_selections(params[:shift_ids])

    respond_to do |format|
      format.json { render json: :none }
    end
  end

end
