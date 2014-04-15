class CreateUserShifts < ActiveRecord::Migration
  def change
    create_table :user_shifts do |t|
      t.belongs_to :user, null: false
      t.belongs_to :shift, null: false
      t.boolean :scheduled
    end
  end
end
