namespace :cars do
  desc "Notifies users about car history inactivity"
  task :notify_history_inactivity, [:period] => [:environment] do |t, args|
    period = args[:period].to_i.days
    CarHistoryInactivityNotifier.call(period)
  end
end
