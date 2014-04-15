class ShiftsController < ApplicationController
  before_action :authenticate_user!
  def index
    @all_shifts = Shift.all
    @current_user_shifts = current_user.user_shifts
  end
end
