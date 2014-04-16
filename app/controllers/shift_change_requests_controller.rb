class ShiftChangeRequestsController < ApplicationController
  before_action :authenticate_user!, :ensure_published!

  def create_swap_request
    current_user.create_swap_request(UserShift.find(params[:original_user_shift_id]), UserShift.find(params[:target_user_shift_id]))
    respond_to { |format| format.json { render json: :none }}
  end

  def accept_swap_request
    current_user.accept_swap_request(ShiftChangeRequest.find(params[:shift_change_request_id]))
    respond_to { |format| format.json { render json: :none }}
  end

  def decline_swap_request
    current_user.decline_swap_request(ShiftChangeRequest.find(params[:shift_change_request_id]))
    respond_to { |format| format.json { render json: :none }}
  end

  private
  def ensure_published!
    respond_to { |format| format.json { render json: {error: "Not allowed before publishing!"}, status: 403 }} if Schedule.published?
  end
end
