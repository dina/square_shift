class Admin::ShiftsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  def index

  end

  private
  def authenticate_admin!
    redirect_to :root unless current_user.admin?
  end
end
