every 1.day, at: '1:00pm' do
  rake "histories:notify_expiration"
end
