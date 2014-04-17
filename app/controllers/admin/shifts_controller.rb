class Admin::ShiftsController < ApplicationController
  before_action :authenticate_user!, :authenticate_admin!

  def index
    @users = User.all
    @shifts_data = {}
    Shift.includes(:user_shifts=>:user).all.each do |shift|
      @shifts_data[shift.id] = {
          scheduled: shift.user_shifts.detect{|us| us.scheduled?},
          all: shift.user_shifts.map{|us| attrs = us.attributes; attrs["user_name"] = us.user.name; attrs}
      }
    end
  end

  def generate_schedule
    UserShift.generate_schedule!
    redirect_to admin_shifts_path
  end

  def publish_schedule
    UserShift.update_assignments(params[:user_shift_ids])
    Schedule.publish!
    redirect_to admin_shifts_path
  end

  def unpublish_schedule
    Schedule.unpublish!
    redirect_to admin_shifts_path
  end

  private
  def authenticate_admin!
    redirect_to :root unless current_user.admin?
  end
end
