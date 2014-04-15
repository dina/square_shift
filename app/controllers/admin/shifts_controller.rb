class Admin::ShiftsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  def index
  end

  # expected params: hash of shift ids to assigned user ids
  # saves the new assignments for the employee
  def update_assignments
    assignments = {1=>1, 2=>1, 4=>2} # TODO: parse this info from the params (possibly from params[:assignments])

  end

  private
  def authenticate_admin!
    redirect_to :root unless current_user.admin?
  end
end
