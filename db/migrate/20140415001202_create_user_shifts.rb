class CreateUserShifts < ActiveRecord::Migration
  def change
    create_table :user_shifts do |t|
      t.belongs_to :users, null: false
      t.belongs_to :shifts, null: false
      t.boolean :scheduled
    end
  end
end
