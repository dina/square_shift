class ShiftChangeRequestsController < ApplicationController
  before_action :authenticate_user!, :ensure_published!, :set_shift_change_request
  before_action :authorize_user_for_response!, only: [:accept_cover_request, :decline_cover_request]

  # COVER REQUESTS
  def create_cover_request
    original_user_shift = UserShift.find(params[:original_user_shift_id])
    target_user = User.find(params[:target_user_id])

    if !current_user.admin? and current_user != original_user_shift.user
      render json: {error: "You don't have the necessary permissions!"}, status: 403
    else
      ShiftChangeRequest.create_cover_request(current_user, original_user_shift, target_user)
      render json: :none
    end
  end

  def accept_cover_request
    shift_change_request.accept_cover_request
    render json: :none
  end

  def decline_cover_request
    shift_change_request.decline_cover_request
    render json: :none
  end

  private

  def ensure_published!
    render json: {error: "Not allowed before publishing!"}, status: 403 if Schedule.published?
  end

  def set_shift_change_request
    shift_change_request = ShiftChangeRequest.find(params[:shift_change_request_id])
    render json: {error: ""}, status: 403 unless shift_change_request
  end

  def authorize_user_for_response!
    render json: {error: "This request was not sent to you!"}, status: 403 unless current_user == shift_change_request.target_user
  end
end
