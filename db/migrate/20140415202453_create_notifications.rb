class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.boolean :action, default: false
      t.string :notification_type, null: false
      t.text :data
      t.timestamps
    end
  end
end
