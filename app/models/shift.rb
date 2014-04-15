class Shift < ActiveRecord::Base
  has_many :user_shifts
  has_many :users, through: :user_shifts

  validates :start_at, presence: true
  validates :end_at, presence: true

end
