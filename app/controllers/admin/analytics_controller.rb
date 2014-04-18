class Admin::AnalyticsController < ApplicationController
  before_action :authenticate_user!, :authenticate_admin!

  def index
  end

  private
  def authenticate_admin!
    redirect_to :root unless current_user.admin?
  end
end
