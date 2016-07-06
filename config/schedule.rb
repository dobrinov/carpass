env :PATH, ENV['PATH']
env :SENDGRID_USERNAME, ENV['SENDGRID_USERNAME']
env :SENDGRID_PASSWORD, ENV['SENDGRID_PASSWORD']

every 1.day, at: '12:30pm' do
  rake "histories:notify_expiration"
end

every 1.day, at: '08:00pm' do
  rake "cars:notify_history_inactivity"
end

every 1.day, at: '08:30pm' do
  rake "users:notify_unfinished_registrations"
end

