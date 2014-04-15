class Admin::ShiftsController < ApplicationController
  before_action :authenticate_user!, :authenticate_admin!

  def index
  end

  def generate_schedule
    UserShift.generate_schedule

    redirect_to :index
  end

  def publish_schedule
    raise "NOT IMPLEMENTED YET!"
    redirect_to :index
  end

  # expected params: array of assigned user_shift_ids
  # saves the new assignments
  def update_assignments
    new_assignments = [1,3,4,6] # TODO: parse this info from the params (possibly from params[:assignments])
    UserShift.update_assignments(new_assignments)

    redirect_to :index
  end

  private
  def authenticate_admin!
    redirect_to :root unless current_user.admin?
  end
end
