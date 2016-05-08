env :PATH, ENV['PATH']
env :SENDGRID_USERNAME, ENV['SENDGRID_USERNAME']
env :SENDGRID_PASSWORD, ENV['SENDGRID_PASSWORD']

every 1.day, at: '12:30pm' do
  rake "histories:notify_expiration", output: 'log/cron/history_expiration_notifier.log'
end
