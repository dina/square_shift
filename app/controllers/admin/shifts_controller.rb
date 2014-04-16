class Admin::ShiftsController < ApplicationController
  before_action :authenticate_user!, :authenticate_admin!

  def index
    @shifts_data = {}
    Shift.includes(:user_shifts=>:user).all.each do |shift|
      @shifts_data[shift.id] = {
          scheduled: shift.user_shifts.detect{|us| us.scheduled?},
          all: shift.user_shifts
      }
    end
  end

  def generate_schedule
    UserShift.generate_schedule!
    redirect_to admin_shifts_path
  end

  def publish_schedule
    Schedule.publish!
    redirect_to admin_shifts_path
  end

  def unpublish_schedule
    Schedule.unpublish!
    redirect_to admin_shifts_path
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
