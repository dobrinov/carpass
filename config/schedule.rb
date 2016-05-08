every 1.day, at: '2:30pm' do
  rake "histories:notify_expiration", output: 'cron_history_expiration_notifier.log'
end
