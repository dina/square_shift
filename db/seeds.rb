# rake db:seed
User.create(
  name: "John",
  phone_number: "5555555555",
  admin: true,
  email: "admin@adminsquare.com",
  password: "adminsRus"
)

User.create(
  name: "Jane",
  phone_number: "5555555555",
  admin: false,
  email: "hello@adminsquare.com",
  password: "yeahyeah"
)

User.create(
  name: "Adam",
  phone_number: "5555555555",
  admin: false,
  email: "world@adminsquare.com",
  password: "yeahyeah"
)

User.create(
  name: "Sally",
  phone_number: "5555555555",
  admin: true,
  email: "yeah@adminsquare.com",
  password: "yeahyeah"
)

today = DateTime.now.utc.beginning_of_day
sunday = today
while sunday.cwday != 7
  sunday += 1.day
end

0.upto(6) do |d|
  day = sunday + d.days
  Shift.create(start_at: day + 8.hours, end_at: day + 12.hours)
  Shift.create(start_at: day + 12.hours, end_at: day + 16.hours)
  Shift.create(start_at: day + 16.hours, end_at: day + 20.hours)
end

users = User.all
shifts = Shift.all
1.upto(50) do |i|
  user_offset = Random.new.rand(users.count)
  shift_offset = Random.new.rand(shifts.count)
  UserShift.where(user: users[user_offset], shift: shifts[shift_offset]).first_or_create
end

UserShift.generate_schedule!

User.all.each do |user|
  Notification.create(user: user, action: true, notification_type: 'cant_make_shift_request',
    user_shift_id: UserShift.scheduled.last.id)
  Notification.create(user: user, action: false, notification_type: 'new_schedule')
  # Notification.create(user: users[1], action: true, notification_type: 'open_shift',
  #   data: { shift_id: Shift.first.id })
  # Notification.create(user: users[1], action: false, notification_type: 'shift_trade',
    # data: { from_user_shift_id: UserShift.scheduled.first.id, to_user_shift_id: UserShift.scheduled.last.id })
  # Notification.create(user: users[1], action: true, notification_type: 'trade_shift_request',
    # data: { from_user_shift_id: UserShift.scheduled.first.id, to_user_shift_id: UserShift.scheduled.last.id })
  Notification.create(user: user, action: true, notification_type: 'update_availability',
    data: { user_id: users[2].id })
  Notification.create(user: user, action: false, notification_type: 'updated_schedule')
end
