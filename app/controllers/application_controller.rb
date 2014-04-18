class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate

  def reset_application
    s = Schedule.last
    s.published = false
    s.save
    UserShift.all.map do |us|
      us unless ['Mike', 'Scott'].include?(us.user.name)
    end.compact.each(&:destroy)
    UserShift.all.each{|us| us.scheduled = false; us.save;}
    Notification.where(
      "notification_type in ('shift_taken', 'cant_make_shift_request')"
    ).each(&:destroy)

    redirect_to :root
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "SquareShift4EVA"
    end
  end

end
