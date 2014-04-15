class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.datetime :start_at, null: false
      t.datetime :end_at, null: true
    end
  end
end
