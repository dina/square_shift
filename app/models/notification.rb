class Notification < ActiveRecord::Base

  UPDATE_AVAILABILITY = "update_availability"
  OPEN_SHIFT =  "open_shift"
  TRADE_SHIFT_REQUEST =  "trade_shift_request"
  CANT_MAKE_SHIFT_REQUEST =  "cant_make_shift_request"
  NEW_SCHEDULE =  "new_schedule"
  UPDATED_SCHEDULE =  "updated_schedule"
  SHIFT_TRADE =  "shift_trade"

  TYPES = [
    UPDATE_AVAILABILITY,
    OPEN_SHIFT,
    TRADE_SHIFT_REQUEST,
    CANT_MAKE_SHIFT_REQUEST,
    NEW_SCHEDULE,
    UPDATED_SCHEDULE,
    SHIFT_TRADE
  ].freeze

  belongs_to :user
  belongs_to :user_shift

  serialize :data, JSON
  validates :notification_type, presence: true

  scope :actionable, -> { where(action: true) }
  scope :informational, -> { where(action: false) }

end
