class CreateShiftChangeRequests < ActiveRecord::Migration
  def change
    create_table :shift_change_requests do |t|
      t.integer :initiator_id
      t.integer :original_user_shift_id
      t.integer :target_user_id
      t.integer :target_user_shift_id

      t.integer :status
      t.text :reason

      t.timestamps
    end
  end
end
