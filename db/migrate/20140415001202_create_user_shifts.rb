class CreateUserShifts < ActiveRecord::Migration
  def change
    create_table :user_shifts do |t|
      t.belongs_to :users
      t.belongs_to :shifts
      t.boolean :scheduled
    end
  end
end
