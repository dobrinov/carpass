env :PATH, ENV['PATH']
env :SENDGRID_USERNAME, ENV['SENDGRID_USERNAME']
env :SENDGRID_PASSWORD, ENV['SENDGRID_PASSWORD']

every 1.day, at: '7:11pm' do
  rake "histories:notify_expiration", output: 'cron_history_expiration_notifier.log'
end
