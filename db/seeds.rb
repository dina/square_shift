# rake db:seed

today = DateTime.now.utc.beginning_of_day
sunday = today
while sunday.cwday != 7
  sunday += 1.day
end

User.create(
  phone_number: "5555555555",
  admin: true,
  email: "admin@adminsquare.com",
  password: "adminsRus"
)

0.upto(6) do |d|
  day = sunday + d.days
  Shift.create(start_at: day + 8.hours, end_at: day + 12.hours)
  Shift.create(start_at: day + 12.hours, end_at: day + 16.hours)
  Shift.create(start_at: day + 16.hours, end_at: day + 20.hours)
end
