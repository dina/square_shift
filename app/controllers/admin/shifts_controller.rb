class Admin::ShiftsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  def index
  end

  # expected params: array of assigned user_shift_ids
  # saves the new assignments
  def update_assignments
    new_assignments = [1,3,4,6] # TODO: parse this info from the params (possibly from params[:assignments])

    # clear the initial 'scheduled' flags
    UserShift.where(scheduled: true).update_all(scheduled: false)

    # TODO: Validations.
    # Details: we are skipping a bunch of validations here.
    # For instance, this code can be fooled into setting the 'scheduled' flags for two user_shifts that correspond to the same shift.

    # set the 'scheduled' flags of new assignments
    UserShift.find(new_assignments).update_all(scheduled: true)
  end

  private
  def authenticate_admin!
    redirect_to :root unless current_user.admin?
  end
end
