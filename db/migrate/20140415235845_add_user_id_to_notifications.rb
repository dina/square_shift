class AddUserIdToNotifications < ActiveRecord::Migration
  def up
    add_belongs_to :notifications, :user
  end

  def down
    remove_belongs_to :notifications, :user
  end
end
