class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def reset_application
    s = Schedule.last
    s.published = false
    s.save
    UserShift.all.each(&:destroy)
    Notification.where(
      "notification_type in ('shift_taken', 'cant_make_shift_request')"
    ).each(&:destroy)

    redirect_to :root
  end

end
