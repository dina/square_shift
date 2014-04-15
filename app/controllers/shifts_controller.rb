class ShiftsController < ApplicationController
  before_action :authenticate_user!
  def index
    @shifts = Shift.all
  end
end
