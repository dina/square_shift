class ShiftChangeRequestsController < ApplicationController
  before_action :authenticate_user!, :ensure_published!
  before_action :set_shift_change_request, :authorize_user_for_response!, :check_original_user!, :ensure_request_is_open!, only: [:accept_cover_request, :decline_cover_request]

  def create_cover_request
    original_user_shift = UserShift.find(params[:original_user_shift_id])

    if current_user != original_user_shift.user
      render json: {error: "You don't have the necessary permissions!"}, status: 403
    elsif !original_user_shift.scheduled?
      render json: {error: "You are not assigned to this shift!"}, status: 403
    else
      (User.all - [current_user]).each do |user|
        Notification.where(
          user: user,
          action: true,
          notification_type: Notification::CANT_MAKE_SHIFT_REQUEST,
          user_shift_id: params[:original_user_shift_id]
        ).first_or_create
      end
      render json: :none
    end
  end

  def user_schedule
    @current_user_shift_ids = current_user.user_shifts.scheduled.pluck(:shift_id)
    @shifts = Shift.includes([{:user_shifts => :user}]).to_json(:include =>  { :user_shifts => {:include => :user} } )

  end

  def accept_cover_request
    shift_change_request.accept_cover_request
    render json: :none
  end

  def decline_cover_request
    shift_change_request.decline
    render json: :none
  end

  private

  def ensure_published!
    render json: {error: "Not allowed before publishing!"}, status: 403 unless Schedule.published?
  end

  def set_shift_change_request
    shift_change_request = ShiftChangeRequest.find(params[:shift_change_request_id])
    render json: {error: ""}, status: 403 unless shift_change_request
  end

  def authorize_user_for_response!
    render json: {error: "This request was not sent to you!"}, status: 403 unless current_user == shift_change_request.target_user
  end

  def check_original_user!
    render json: {error: "Someone else already covered this shift!"} unless shift_change_request.original_user_shift.scheduled?
  end

  def ensure_request_is_open!
    render json: {error: "The request has already been responded!"}, status: 403 if !shift_change_request.open?
  end
end
