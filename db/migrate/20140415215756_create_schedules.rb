class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.boolean :scheduled

      t.timestamps
    end
  end
end
