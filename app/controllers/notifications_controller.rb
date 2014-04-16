class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_notifications

  def index
  end

  def add_shift
    user_shift = UserShift.where(
      user: current_user,
      shift_id: params[:shift_id]
    ).first_or_initialize

    if user_shift.new_record? && user_shift.save
      @notification.destroy
      flash[:notice] = 'You have successfully added your shift!'
    else
      flash[:error] = "We encountered some errors when adding your shift"
      flash[:error] += ": #{user_shift.errors.full_messages}" if user_shift.errors.any?
    end
    redirect_to :root
  end

  private
  def load_notifications
    @notifications = Notification.all
    @notification = Notification.find(params[:id]) if params[:id]
  end


end
