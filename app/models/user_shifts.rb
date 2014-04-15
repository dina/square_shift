class UserShift < ActiveRecord::Base
  belongs_to :user
  belongs_to :shift

  validates :user, presence: true
  validates :shift, presence: true

end
