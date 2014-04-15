class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.datetime :start_at
      t.datetime :end_at
    end
  end
end
