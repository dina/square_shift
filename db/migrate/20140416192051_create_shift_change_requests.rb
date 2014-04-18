class CreateShiftChangeRequests < ActiveRecord::Migration
  def change
    create_table :shift_change_requests do |t|
      t.integer :initiator_id, null: false
      t.integer :original_user_id
      t.integer :original_user_shift_id
      t.integer :original_shift_id

      t.integer :target_user_id
      t.integer :target_user_shift_id
      t.integer :target_shift_id

      t.integer :reference_request_id

      t.string :status
      t.string :kind
      t.text :reason

      t.timestamps
    end
  end
end
