env :PATH, ENV['PATH']
env :SENDGRID_USERNAME, ENV['SENDGRID_USERNAME']
env :SENDGRID_PASSWORD, ENV['SENDGRID_PASSWORD']
env :FACEBOOK_KEY, ENV['FACEBOOK_KEY']
env :FACEBOOK_SECRET, ENV['FACEBOOK_SECRET']

every 1.day, at: '12:30pm' do
  rake "histories:notify_expiration"
end

every 1.day, at: '08:00pm' do
  rake "cars:notify_history_inactivity[60]"
end

every :saturday, at: '11:00am' do
  rake "users:notify_unfinished_registrations[3]"
end
