# TODO: Logic on who can see what!!!

class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_notifications, except: [:index]

  def index
    @notifications = Notification.where(user: current_user).reverse
  end

  # Adds the shift to your schedule.
  def add_shift
    user_shift = UserShift.where(
      user: current_user,
      shift_id: params[:shift_id]
    ).first_or_initialize

    if user_shift.new_record? && user_shift.save
      @notification.destroy
      flash[:notice] = 'We have successfully added your shift!'
    else
      flash[:error] = error_msg(user_shift)
    end
    redirect_to :root
  end

  # Adds the shift to your schedule,
  # AND removes from other users schedule.
  def take_shift
    user_shift = UserShift.find(params[:user_shift_id])
    original_user = user_shift.user
    user_shift.user = current_user
    if user_shift.save
      Notification.where(
        notification_type: @notification.notification_type,
        user_shift: user_shift
      ).each(&:destroy)
      Notification.where(
        user: original_user,
        action: false,
        notification_type: Notification::SHIFT_TAKEN,
        user_shift: user_shift).first_or_create
      flash[:notice] = 'We have successfully added your shift!'
    else
      flash[:error] = error_msg(user_shift)
    end
    redirect_to :root
  end

  # Swaps shift between two employees.
  def trade_shift
  end

  def destroy
    @notification.destroy
  end

  private
  def load_notifications
    @notification = Notification.find(params[:id])
  end

  def error_msg(obj)
    if obj.errors.any?
      "We encountered the following erorrs with your request: #{user_shift.errors.full_messages}."
    else
      "We encountered some issues with your request."
    end
  end
end
