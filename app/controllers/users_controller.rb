class UsersController < ApplicationController
  def shifts
    render json: User.find(params[:user_id]).user_shifts.map(&:id)
  end
end
