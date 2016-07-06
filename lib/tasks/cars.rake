namespace :cars do
  desc "Notifies users about car history inactivity"
  task notify_history_inactivity: :environment do
    CarHistoryInactivityNotifier.call
  end
end
