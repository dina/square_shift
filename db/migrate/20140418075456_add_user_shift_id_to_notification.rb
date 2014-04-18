class AddUserShiftIdToNotification < ActiveRecord::Migration
  def up
    add_belongs_to :notifications, :user_shift
  end

  def down
    remove_belongs_to :notifications, :user_shift
  end
end
