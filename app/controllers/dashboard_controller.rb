class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.all
  end

end
