class ShiftChangeRequestsController < ApplicationController
  before_action :authenticate_user!, :ensure_published!, :set_shift_change_request
  before_action :authorize_user_for_response!, :check_original_user!, :ensure_request_is_open!, only: [:accept_cover_request, :decline_cover_request]

  def create_cover_request
    original_user_shift = UserShift.find(params[:original_user_shift_id])
    target_user = User.find(params[:target_user_id])

    if !current_user.admin? and current_user != original_user_shift.user
      render json: {error: "You don't have the necessary permissions!"}, status: 403
    elsif !original_user_shift.scheduled?
      render json: {error: "You are not assigned to this shift!"}, status: 403
    else
      ShiftChangeRequest.create_cover_request(current_user, original_user_shift, target_user)
      render json: :none
    end
  end

  def user_schedule
    # @all_shifts = Shift.all
    # @current_user_shift_ids = current_user.shifts.map &:id
    # @users = User.all
    # @shifts = {}
    # Shift.includes(:user_shifts=>:user).all.each do |shift|
    #   @shifts[shift.id] = {
    #       scheduled: shift.user_shifts.detect{|us| us.scheduled?},
    #       all: shift.user_shifts
    #   }
    # end

    # @shifts = Shift.includes(:user_shifts=>:user)

    # @shifts = render :json => @customer, :include => :calls
    # shifts = Shift.all

    # @shifts = shifts.as_json(:include => { :user_shifts })
    shifts = Shift.all
    @shifts = shifts.as_json(include: :user_shifts)
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
    render json: {error: "Not allowed before publishing!"}, status: 403 if Schedule.published?
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
