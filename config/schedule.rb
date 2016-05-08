every 1.day, at: '2:25pm' do
  rake "histories:notify_expiration"
end
